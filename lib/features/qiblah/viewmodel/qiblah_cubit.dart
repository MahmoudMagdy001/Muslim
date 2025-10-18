// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

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
  bool _isFetchingRoute = false;
  bool _isInitialized = false; // Add this flag

  static const double _alignmentThreshold = 0.1;
  static const double _degreesToRadians = pi / 180;

  static const LatLng _kaabaLocation = LatLng(21.4225, 39.8262);

  /// Initializes listeners
  Future<void> init() async {
    if (_isInitialized) return; // Prevent multiple initializations
    _isInitialized = true;

    emit(
      state.copyWith(status: QiblahStatus.loading),
    ); // Set loading state immediately

    _setupLocationServiceListener();
    await _startIfGranted();
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
      onError: (error) {
        emit(
          state.copyWith(
            status: QiblahStatus.error,
            message: 'خطأ في خدمة الموقع: $error',
          ),
        );
      },
    );
  }

  Future<void> _handleLocationServiceDisabled() async {
    await _qiblahSubscription?.cancel();
    emit(
      state.copyWith(
        status: QiblahStatus.error,
        message: 'من فضلك شغل خدمة الموقع لاستخدام البوصلة',
      ),
    );
  }

  // ✅ Start if permissions are granted
  Future<void> _startIfGranted() async {
    try {
      final status = await locationService.checkLocationStatus();
      if (status.isGranted) {
        await _fetchUserLocation();
        await _startQiblahCompass();
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
          message: 'خطأ في التحقق من حالة الموقع: $error',
        ),
      );
    }
  }

  // ✅ Start compass stream
  Future<void> _startQiblahCompass() async {
    // Don't emit loading again if already in loading state
    if (state.status != QiblahStatus.loading) {
      emit(state.copyWith(status: QiblahStatus.loading));
    }

    await _qiblahSubscription?.cancel();
    _hasTriggeredFeedback = false;

    // نضيف buffer لتقليل التحديثات السريعة
    _qiblahSubscription = service.qiblahStream
        .distinct(
          (prev, curr) =>
              (prev.direction - curr.direction).abs() < 0.5 &&
              (prev.qiblah - curr.qiblah).abs() < 0.5,
        )
        .listen(
          _handleQiblahData,
          onError: (error) => emit(
            state.copyWith(
              status: QiblahStatus.error,
              message: 'خطأ في بوصلة القبلة: $error',
            ),
          ),
        );
  }

  // ✅ Handle Qiblah data updates
  void _handleQiblahData(QiblahDirection data) {
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
      HapticFeedback.heavyImpact();
      _hasTriggeredFeedback = true;
    } else if (!isAligned) {
      _hasTriggeredFeedback = false;
    }
  }

  // ✅ Fetch user location and route (with guard)
  Future<void> _fetchUserLocation() async {
    try {
      final position = await locationService.getCurrentLocate();
      if (position == null) {
        emit(
          state.copyWith(
            status: QiblahStatus.error,
            message: 'تعذر الحصول على الموقع',
          ),
        );
        return;
      }

      emit(state.copyWith(userLocation: position));

      if (!_isFetchingRoute) {
        _isFetchingRoute = true;
        unawaited(_fetchRoute(position));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: QiblahStatus.error,
          message: 'تعذر الحصول على الموقع الحالي: $e',
        ),
      );
    }
  }

  // ✅ Fetch route from OSRM (non-blocking)
  Future<void> _fetchRoute(Position position) async {
    // Only emit loading if not already in success state
    if (state.status != QiblahStatus.success) {
      emit(state.copyWith(status: QiblahStatus.loading));
    }

    try {
      final userLocation = LatLng(position.latitude, position.longitude);
      final url =
          'https://router.project-osrm.org/route/v1/driving/${userLocation.longitude},${userLocation.latitude};${_kaabaLocation.longitude},${_kaabaLocation.latitude}?overview=full&geometries=polyline';

      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10)); // Increased timeout

      if (response.statusCode != 200) {
        // If route fetch fails, but we have compass data, don't show error
        if (state.status == QiblahStatus.loading) {
          emit(
            state.copyWith(status: QiblahStatus.success),
          ); // Show compass anyway
        }
        return;
      }

      final data = json.decode(response.body);
      if (data['routes'] == null || data['routes'].isEmpty) {
        if (state.status == QiblahStatus.loading) {
          emit(
            state.copyWith(status: QiblahStatus.success),
          ); // Show compass anyway
        }
        return;
      }

      final route = data['routes'][0];
      final polyline = _decodePolyline(route['geometry']);
      final distanceKm = (route['distance'] as num) / 1000;
      final durationMin = (route['duration'] as num) / 60;

      emit(
        state.copyWith(
          routePoints: polyline,
          distance: distanceKm,
          duration: durationMin,
          status: QiblahStatus.success, // Ensure success state
        ),
      );
    } catch (e) {
      debugPrint('Route fetch error: $e');
      // If route fetch fails, but we have compass data, don't show error
      if (state.status == QiblahStatus.loading) {
        emit(
          state.copyWith(status: QiblahStatus.success),
        ); // Show compass anyway
      }
    } finally {
      _isFetchingRoute = false;
    }
  }

  // ✅ Optimized polyline decoder
  List<LatLng> _decodePolyline(String encoded) {
    final List<LatLng> points = [];
    int index = 0, lat = 0, lng = 0;

    while (index < encoded.length) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Future<void> close() async {
    await _qiblahSubscription?.cancel();
    await _locationSubscription?.cancel();
    return super.close();
  }
}
