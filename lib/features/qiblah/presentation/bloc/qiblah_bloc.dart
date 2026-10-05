// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/features/qiblah/domain/entities/qiblah_direction_entity.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';
import 'package:muslim/features/qiblah/presentation/bloc/qiblah_event.dart';
import 'package:muslim/features/qiblah/presentation/bloc/qiblah_state.dart';
import 'package:rxdart/rxdart.dart';

export 'qiblah_event.dart';
export 'qiblah_state.dart';

class QiblahBloc extends Bloc<QiblahEvent, QiblahState> {
  QiblahBloc({
    QiblahRepository? repository,
    LocationService? locationService,
  }) : _repository =
           repository ?? getIt<QiblahRepository>(),
       locationService = locationService ?? getIt<LocationService>(),
       super(const QiblahState()) {
    on<QiblahInit>(_onInit);
    on<QiblahLocationStatusChanged>(_onLocationStatusChanged);
    on<QiblahStartCompass>(_onStartCompass);
    on<QiblahDataReceived>(_onDataReceived);
    on<QiblahLocationDisabled>(_onLocationDisabled);
    on<QiblahErrorOccurred>(_onErrorOccurred);
  }

  final QiblahRepository _repository;
  final LocationService locationService;

  StreamSubscription<QiblahDirectionEntity>? _qiblahSubscription;
  StreamSubscription<ServiceStatus>? _locationSubscription;
  bool _hasTriggeredFeedback = false;
  bool _isInitialized = false;

  static const double _alignmentThreshold = 0.09;
  static const double _degreesToRadians = pi / 180;

  Future<void> _onInit(
    QiblahInit event,
    Emitter<QiblahState> emit,
  ) async {
    if (_isInitialized) return;
    _isInitialized = true;

    emit(state.copyWith(status: QiblahStatus.loading));

    _setupLocationServiceListener();
    await _startIfGranted();
  }

  void _setupLocationServiceListener() {
    _locationSubscription = locationService.serviceStatusStream.listen(
      (status) {
        add(QiblahEvent.locationStatusChanged(status));
      },
      onError: (Object error) {
        add(QiblahEvent.errorOccurred('خطأ في خدمة الموقع: $error'));
      },
    );
  }

  Future<void> _onLocationStatusChanged(
    QiblahLocationStatusChanged event,
    Emitter<QiblahState> emit,
  ) async {
    if (event.status == ServiceStatus.enabled) {
      await _startIfGranted();
    } else {
      add(const QiblahEvent.locationDisabled());
    }
  }

  Future<void> _onLocationDisabled(
    QiblahLocationDisabled event,
    Emitter<QiblahState> emit,
  ) async {
    await _qiblahSubscription?.cancel();
    emit(
      state.copyWith(
        status: QiblahStatus.error,
        message: 'من فضلك شغل خدمة الموقع لاستخدام البوصلة',
      ),
    );
  }

  void _onErrorOccurred(
    QiblahErrorOccurred event,
    Emitter<QiblahState> emit,
  ) {
    emit(
      state.copyWith(
        status: QiblahStatus.error,
        message: event.message,
      ),
    );
  }

  Future<void> _startIfGranted() async {
    try {
      final status = await locationService.checkLocationStatus();

      if (status.isGranted) {
        add(const QiblahEvent.startCompass());
      } else {
        add(const QiblahEvent.errorOccurred('الموقع مش متفعل أو الصلاحية مرفوضة'));
      }
    } on Object catch (error) {
      add(QiblahEvent.errorOccurred('خطأ في التحقق من حالة الموقع: $error'));
    }
  }

  Future<void> _onStartCompass(
    QiblahStartCompass event,
    Emitter<QiblahState> emit,
  ) async {
    if (state.status != QiblahStatus.loading) {
      emit(state.copyWith(status: QiblahStatus.loading));
    }

    await _qiblahSubscription?.cancel();
    _hasTriggeredFeedback = false;

    _qiblahSubscription = _repository.getQiblahStream()
        .sampleTime(const Duration(milliseconds: 16))
        .distinct(
          (prev, curr) =>
              (prev.direction - curr.direction).abs() < 0.1 &&
              (prev.qiblah - curr.qiblah).abs() < 0.1,
        )
        .listen(
          (data) => add(QiblahEvent.qiblahDataReceived(data)),
          onError: (Object error) {
            add(QiblahEvent.errorOccurred('خطأ في بوصلة القبلة: $error'));
          },
        );
  }

  void _onDataReceived(
    QiblahDataReceived event,
    Emitter<QiblahState> emit,
  ) {
    final data = event.data;
    final qiblahAngle = _validateAndConvertAngle(data.qiblah);
    final headingAngle = _validateAndConvertAngle(data.direction);
    final isAligned = (qiblahAngle % (2 * pi)).abs() < _alignmentThreshold;

    _triggerHapticFeedback(isAligned);

    emit(
      state.copyWith(
        status: QiblahStatus.success,
        qiblahAngle: qiblahAngle,
        headingAngle: headingAngle,
        isAligned: isAligned,
      ),
    );
  }

  double _validateAndConvertAngle(double angle) {
    if (angle.isNaN || !angle.isFinite) return 0.0;
    return -angle * _degreesToRadians;
  }

  void _triggerHapticFeedback(bool isAligned) {
    if (isAligned && !_hasTriggeredFeedback) {
      unawaited(HapticFeedback.heavyImpact());
      _hasTriggeredFeedback = true;
    } else if (!isAligned) {
      _hasTriggeredFeedback = false;
    }
  }

  // Convenience method
  Future<void> init() async => add(const QiblahEvent.init());

  @override
  Future<void> close() async {
    await _qiblahSubscription?.cancel();
    await _locationSubscription?.cancel();
    return super.close();
  }
}
