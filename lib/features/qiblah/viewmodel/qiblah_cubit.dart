import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/service/location_service.dart';
import '../service/qiblah_service.dart';
import 'qiblah_state.dart';

class QiblahCubit extends Cubit<QiblahState> {
  QiblahCubit({required this.service, required this.locationService})
    : super(const QiblahState());

  final QiblahService service;
  final LocationService locationService;

  StreamSubscription<QiblahDirection>? _qiblahSubscription;
  StreamSubscription<ServiceStatus>? _locationSubscription;
  bool _hasTriggeredFeedback = false;

  static const double _alignmentThreshold = 0.1;
  static const double _degreesToRadians = pi / 180;

  /// Initializes the cubit and sets up location service listeners
  Future<void> init() async {
    _setupLocationServiceListener();
    await _startIfGranted();
  }

  /// Sets up listener for location service status changes
  void _setupLocationServiceListener() {
    _locationSubscription = locationService.serviceStatusStream.listen(
      (ServiceStatus status) async {
        if (status == ServiceStatus.enabled) {
          await _startIfGranted();
        } else {
          await _handleLocationServiceDisabled();
        }
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: QiblahStatus.error,
            message: 'خطأ في خدمة الموقع: ${error.toString()}',
          ),
        );
      },
    );
  }

  /// Handles when location service is disabled
  Future<void> _handleLocationServiceDisabled() async {
    await _qiblahSubscription?.cancel();
    emit(
      state.copyWith(
        status: QiblahStatus.error,
        message: 'من فضلك شغل خدمة الموقع لاستخدام البوصلة',
      ),
    );
  }

  /// Starts Qiblah compass if location permissions are granted
  Future<void> _startIfGranted() async {
    try {
      final status = await locationService.checkLocationStatus();

      if (status.isGranted) {
        await startQiblahCompass();
      } else {
        emit(
          state.copyWith(
            status: QiblahStatus.error,
            message: 'الموقع مش متفعل أو الصلاحية مرفوضة',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: QiblahStatus.error,
          message: 'خطأ في التحقق من حالة الموقع: ${error.toString()}',
        ),
      );
    }
  }

  /// Starts listening to Qiblah compass stream
  Future<void> startQiblahCompass() async {
    emit(state.copyWith(status: QiblahStatus.loading));

    try {
      await _qiblahSubscription?.cancel();
      _hasTriggeredFeedback = false;

      _qiblahSubscription = service.qiblahStream.listen(
        _handleQiblahData,
        onError: (error) {
          emit(
            state.copyWith(
              status: QiblahStatus.error,
              message: 'خطأ في بوصلة القبلة: ${error.toString()}',
            ),
          );
        },
      );
    } catch (error) {
      _handleQiblahStartError(error);
    }
  }

  /// Handles incoming Qiblah direction data
  void _handleQiblahData(QiblahDirection data) {
    final qiblahAngle = _calculateQiblahAngle(data.qiblah);
    final headingAngle = _calculateHeadingAngle(data.direction);
    final isAligned = _checkAlignment(qiblahAngle);

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

  /// Calculates and validates Qiblah angle
  double _calculateQiblahAngle(double rawAngle) =>
      _validateAndConvertAngle(rawAngle);

  /// Calculates and validates heading angle
  double _calculateHeadingAngle(double rawDirection) =>
      _validateAndConvertAngle(rawDirection);

  /// Validates and converts degrees to radians
  double _validateAndConvertAngle(double angle) {
    if (angle.isNaN || !angle.isFinite) {
      return 0.0;
    }
    return -angle * _degreesToRadians;
  }

  /// Checks if the device is aligned with Qiblah
  bool _checkAlignment(double qiblahAngle) {
    final angleDiff = (qiblahAngle % (2 * pi));
    return angleDiff.abs() < _alignmentThreshold;
  }

  /// Triggers haptic feedback when aligned with Qiblah
  void _triggerHapticFeedback(bool isAligned) {
    if (isAligned && !_hasTriggeredFeedback) {
      HapticFeedback.heavyImpact();
      _hasTriggeredFeedback = true;
    } else if (!isAligned) {
      _hasTriggeredFeedback = false;
    }
  }

  /// Handles errors during Qiblah compass start
  void _handleQiblahStartError(Object error) {
    emit(
      state.copyWith(
        status: QiblahStatus.error,
        message: 'فشل في تشغيل بوصلة القبلة: ${error.toString()}',
      ),
    );
  }

  /// Clean up resources when cubit is closed
  @override
  Future<void> close() {
    _qiblahSubscription?.cancel();
    _locationSubscription?.cancel();
    return super.close();
  }
}
