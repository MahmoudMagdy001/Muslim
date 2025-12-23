import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart' as geo;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/service/location_service.dart';
import '../../settings/service/settings_service.dart';

import '../model/prayer_times_model.dart';

class PrayerTimesService {
  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';

  final DateFormat _timeFormatter = DateFormat.Hm();

  /// الحصول على مواقيت الصلاة (يوم واحد أو شهر كامل)
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    Coordinates? coordinates,
    BuildContext? context,
  }) async {
    try {
      final coords =
          coordinates ??
          await _getCachedOrCurrentCoordinates(coordinates == null, context);
      if (coords == null) return await _getDefaultPrayerTimes();

      String? cityName;
      try {
        geo.setLocaleIdentifier(isArabic ? 'ar' : 'en');
        final placemarks = await geo.placemarkFromCoordinates(
          coords.latitude,
          coords.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          cityName = place.locality?.isNotEmpty == true
              ? place.locality
              : place.administrativeArea;
        }
      } catch (e) {
        debugPrint('⚠️ فشل geocoding: $e');
      }

      if (forMonth) {
        return await _calculateMonthlyPrayerTimes(coords, cityName: cityName);
      } else {
        return await _calculatePrayerTimes(coords, cityName: cityName);
      }
    } catch (error) {
      debugPrint('❌ خطأ في الحصول على مواقيت الصلاة: $error');
      return await _getDefaultPrayerTimes();
    }
  }

  /// حساب مواقيت الصلاة لليوم
  Future<LocalPrayerTimes> _calculatePrayerTimes(
    Coordinates coordinates, {
    String? cityName,
  }) async {
    final calculationParams = _getCalculationParameters();
    final prayerTimes = PrayerTimes.today(coordinates, calculationParams);

    return LocalPrayerTimes(
      fajr: _formatTime(prayerTimes.fajr),
      dhuhr: _formatTime(prayerTimes.dhuhr),
      asr: _formatTime(prayerTimes.asr),
      maghrib: _formatTime(prayerTimes.maghrib),
      isha: _formatTime(prayerTimes.isha),
      city: cityName ?? 'غير معروف',
    );
  }

  /// حساب مواقيت الصلاة للشهر كله
  Future<List<LocalPrayerTimes>> _calculateMonthlyPrayerTimes(
    Coordinates coordinates, {
    String? cityName,
  }) async {
    final calculationParams = _getCalculationParameters();
    final now = DateTime.now();

    final List<LocalPrayerTimes> monthlyTimes = [];
    final int daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(now.year, now.month, day);
      final prayerTimes = PrayerTimes(
        coordinates,
        DateComponents.from(date),
        calculationParams,
      );

      monthlyTimes.add(
        LocalPrayerTimes(
          fajr: _formatTime(prayerTimes.fajr),
          dhuhr: _formatTime(prayerTimes.dhuhr),
          asr: _formatTime(prayerTimes.asr),
          maghrib: _formatTime(prayerTimes.maghrib),
          isha: _formatTime(prayerTimes.isha),
          city: cityName ?? 'غير معروف',
        ),
      );
    }

    return monthlyTimes;
  }

  /// معاملات الحساب
  CalculationParameters _getCalculationParameters() =>
      CalculationMethod.egyptian.getParameters()..madhab = Madhab.shafi;

  /// تنسيق الوقت
  String _formatTime(DateTime dateTime) =>
      _timeFormatter.format(dateTime.toLocal());

  /// مواقيت افتراضية (القاهرة)
  Future<LocalPrayerTimes> _getDefaultPrayerTimes() async {
    final cairoCoordinates = Coordinates(30.0444, 31.2357);
    final calculationParams = _getCalculationParameters();
    final prayerTimes = PrayerTimes.today(cairoCoordinates, calculationParams);

    final prefs = await SharedPreferences.getInstance();
    await _cacheCoordinates(
      prefs,
      cairoCoordinates.latitude,
      cairoCoordinates.longitude,
    );

    return LocalPrayerTimes(
      fajr: _formatTime(prayerTimes.fajr),
      dhuhr: _formatTime(prayerTimes.dhuhr),
      asr: _formatTime(prayerTimes.asr),
      maghrib: _formatTime(prayerTimes.maghrib),
      isha: _formatTime(prayerTimes.isha),
      city: 'القاهرة',
    );
  }

  /// الحصول على الإحداثيات (الحالية أو الكاش)
  Future<Coordinates?> _getCachedOrCurrentCoordinates(
    bool allowRequest, [
    BuildContext? context,
  ]) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsService = SettingsService();

    // 1. إذا كان مسموحاً بطلب الموقع (وليس في الخلفية) وكان الخيار مفعلاً
    if (allowRequest && await settingsService.getAutoLocationEnabled()) {
      try {
        final position = await _getCurrentPosition(context);

        await _cacheCoordinates(prefs, position.latitude, position.longitude);
        return Coordinates(position.latitude, position.longitude);
      } catch (e) {
        debugPrint('⚠️ فشل في الحصول على الموقع الحالي: $e');
      }
    }

    final cachedCoordinates = await getCachedCoordinates();
    if (cachedCoordinates != null) {
      return cachedCoordinates;
    }

    return null;
  }

  Future<Coordinates?> getCachedCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latitudeKey);
    final lng = prefs.getDouble(_longitudeKey);
    if (lat == null || lng == null) return null;
    return Coordinates(lat, lng);
  }

  Future<Position> _getCurrentPosition([BuildContext? context]) async {
    final locationService = LocationService();
    // We call getCurrentLocate which handles the disclosure if context is provided
    final position = await locationService.getCurrentLocate(context);
    if (position != null) return position;
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _cacheCoordinates(
    SharedPreferences prefs,
    double latitude,
    double longitude,
  ) async {
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
    await prefs.setInt(_lastUpdatedKey, DateTime.now().millisecondsSinceEpoch);
  }
}
