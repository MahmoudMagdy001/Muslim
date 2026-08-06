// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/features/qiblah/domain/entities/qiblah_direction_entity.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';
import 'package:muslim/features/qiblah/presentation/cubit/qiblah_state.dart';
import 'package:rxdart/rxdart.dart';

class QiblahCubit extends Cubit<QiblahState> {
  QiblahCubit({
    QiblahRepository? repository,
    LocationService? locationService,
  }) : _repository =
           repository ?? getIt<QiblahRepository>(),
       locationService = locationService ?? getIt<LocationService>(),
       super(const QiblahState());

  final QiblahRepository _repository;
  final LocationService locationService;

  StreamSubscription<QiblahDirectionEntity>? _qiblahSubscription;
  StreamSubscription<ServiceStatus>? _locationSubscription;
  bool _hasTriggeredFeedback = false;
  bool _isInitialized = false;

  static const double _alignmentThreshold = 0.09;
  static const double _degreesToRadians = pi / 180;

  /// Initializes listeners
  Future<void> init([BuildContext? context]) async {
    if (_isInitialized) return;
    _isInitialized = true;

    if (!isClosed) {
      emit(
        state.copyWith(status: QiblahStatus.loading),
      ); // Set loading state immediately
    }

    _setupLocationServiceListener();
    await _startIfGranted(context);
  }

  // ✅ setup location service listener
  void _setupLocationServiceListener() {
    _locationSubscription = locationService.serviceStatusStream.listen(
      (status) async {
        if (status == ServiceStatus.enabled) {
          await _startIfGranted();
        } else {
          await _handleLocationServiceDisabled();
        }
      },
      onError: (Object error) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: QiblahStatus.error,
              message: 'خطأ في خدمة الموقع: $error',
            ),
          );
        }
      },
    );
  }

  Future<void> _handleLocationServiceDisabled() async {
    await _qiblahSubscription?.cancel();
    if (!isClosed) {
      emit(
        state.copyWith(
          status: QiblahStatus.error,
          message: 'من فضلك شغل خدمة الموقع لاستخدام البوصلة',
        ),
      );
    }
  }

  // ✅ Start if permissions are granted
  Future<void> _startIfGranted([BuildContext? context]) async {
    try {
      final status = await locationService.checkLocationStatus(context);

      if (status.isGranted) {
        await _startQiblahCompass();
      } else {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: QiblahStatus.error,
              message: 'الموقع مش متفعل أو الصلاحية مرفوضة',
            ),
          );
        }
      }
    } on Object catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: QiblahStatus.error,
            message: 'خطأ في التحقق من حالة الموقع: $error',
          ),
        );
      }
    }
  }

  // ✅ Start compass stream with throttling for better performance
  Future<void> _startQiblahCompass() async {
    // Don't emit loading again if already in loading state
    if (state.status != QiblahStatus.loading) {
      if (!isClosed) emit(state.copyWith(status: QiblahStatus.loading));
    }

    await _qiblahSubscription?.cancel();
    _hasTriggeredFeedback = false;

    // High-performance smooth stream: ~60 FPS updates, 0.1 degree sensitivity
    _qiblahSubscription = _repository.getQiblahStream()
        .sampleTime(const Duration(milliseconds: 16))
        .distinct(
          (prev, curr) =>
              (prev.direction - curr.direction).abs() < 0.1 &&
              (prev.qiblah - curr.qiblah).abs() < 0.1,
        )
        .listen(
          _handleQiblahData,
          onError: (Object error) {
            if (!isClosed) {
              emit(
                state.copyWith(
                  status: QiblahStatus.error,
                  message: 'خطأ في بوصلة القبلة: $error',
                ),
              );
            }
          },
        );
  }

  // ✅ Handle Qiblah data updates
  void _handleQiblahData(QiblahDirectionEntity data) {
    final qiblahAngle = _validateAndConvertAngle(data.qiblah);
    final headingAngle = _validateAndConvertAngle(data.direction);
    final isAligned = (qiblahAngle % (2 * pi)).abs() < _alignmentThreshold;

    _triggerHapticFeedback(isAligned);

    if (!isClosed) {
      emit(
        state.copyWith(
          status: QiblahStatus.success,
          qiblahAngle: qiblahAngle,
          headingAngle: headingAngle,
          isAligned: isAligned,
        ),
      );
    }
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

  @override
  Future<void> close() async {
    await _qiblahSubscription?.cancel();
    await _locationSubscription?.cancel();
    return super.close();
  }
}
