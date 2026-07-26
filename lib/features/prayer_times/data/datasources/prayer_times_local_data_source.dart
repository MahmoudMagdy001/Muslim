import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrayerTimesLocalDataSource {
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    bool useLocation = true,
    Coordinates? coordinates,
  });

  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  });

  Future<Coordinates?> getCachedCoordinates();
}

class PrayerTimesLocalDataSourceImpl implements PrayerTimesLocalDataSource {
  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';

  final DateFormat _timeFormatter = DateFormat.Hm();

  @override
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    bool useLocation = true,
    Coordinates? coordinates,
  }) async {
    try {
      // If location permission not granted, skip location fetching and use default
      final coords = useLocation
          ? (coordinates ??
                await _getCachedOrCurrentCoordinates(coordinates == null))
          : null;

      if (coords == null) return await _getDefaultPrayerTimes();

      String? cityName;
      try {
        // ponytail: Use Geocoding instance for compatibility with v5.0.0
        final geocoding = geo.Geocoding();
        final placemarks = await geocoding.placemarkFromCoordinates(
          coords.latitude,
          coords.longitude,
          locale: Locale(isArabic ? 'ar' : 'en'),
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          cityName = place.locality?.isNotEmpty ?? false
              ? place.locality
              : place.administrativeArea;
        }
      } on Object catch (e) {
        logWarning('فشل geocoding: $e');
      }

      if (forMonth) {
        return await _calculateMonthlyPrayerTimes(coords, cityName: cityName);
      } else {
        return await _calculatePrayerTimes(coords, cityName: cityName);
      }
    } on Object catch (error) {
      logError('خطأ في الحصول على مواقيت الصلاة', error);
      return _getDefaultPrayerTimes();
    }
  }

  @override
  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  }) async =>
      _calculatePrayerTimes(coordinates, date: date, cityName: cityName);

  Future<LocalPrayerTimes> _calculatePrayerTimes(
    Coordinates coordinates, {
    DateTime? date,
    String? cityName,
  }) async {
    final calculationParams = _getCalculationParameters();
    final targetDate = date ?? DateTime.now();

    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents.from(targetDate),
      calculationParams,
    );

    // Ensure prayer times are in local timezone to avoid DST issues
    final fajrLocal = prayerTimes.fajr.toLocal();
    final sunriseLocal = prayerTimes.sunrise.toLocal();
    final dhuhrLocal = prayerTimes.dhuhr.toLocal();
    final asrLocal = prayerTimes.asr.toLocal();
    final maghribLocal = prayerTimes.maghrib.toLocal();
    final ishaLocal = prayerTimes.isha.toLocal();

    return LocalPrayerTimes(
      fajr: _formatTime(fajrLocal),
      sunrise: _formatTime(sunriseLocal),
      dhuhr: _formatTime(dhuhrLocal),
      asr: _formatTime(asrLocal),
      maghrib: _formatTime(maghribLocal),
      isha: _formatTime(ishaLocal),
      city: cityName ?? 'غير معروف',
      date: targetDate,
      // Store DateTime objects for accurate timezone-aware scheduling
      fajrDateTime: fajrLocal,
      sunriseDateTime: sunriseLocal,
      dhuhrDateTime: dhuhrLocal,
      asrDateTime: asrLocal,
      maghribDateTime: maghribLocal,
      ishaDateTime: ishaLocal,
    );
  }

  Future<List<LocalPrayerTimes>> _calculateMonthlyPrayerTimes(
    Coordinates coordinates, {
    String? cityName,
  }) async {
    final calculationParams = _getCalculationParameters();
    final now = DateTime.now();

    final monthlyTimes = <LocalPrayerTimes>[];
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(now.year, now.month, day);
      final prayerTimes = PrayerTimes(
        coordinates,
        DateComponents.from(date),
        calculationParams,
      );

      // Ensure prayer times are in local timezone to avoid DST issues
      final fajrLocal = prayerTimes.fajr.toLocal();
      final sunriseLocal = prayerTimes.sunrise.toLocal();
      final dhuhrLocal = prayerTimes.dhuhr.toLocal();
      final asrLocal = prayerTimes.asr.toLocal();
      final maghribLocal = prayerTimes.maghrib.toLocal();
      final ishaLocal = prayerTimes.isha.toLocal();

      monthlyTimes.add(
        LocalPrayerTimes(
          fajr: _formatTime(fajrLocal),
          sunrise: _formatTime(sunriseLocal),
          dhuhr: _formatTime(dhuhrLocal),
          asr: _formatTime(asrLocal),
          maghrib: _formatTime(maghribLocal),
          isha: _formatTime(ishaLocal),
          city: cityName ?? 'غير معروف',
          date: date,
          // Store DateTime objects for accurate timezone-aware scheduling
          fajrDateTime: fajrLocal,
          sunriseDateTime: sunriseLocal,
          dhuhrDateTime: dhuhrLocal,
          asrDateTime: asrLocal,
          maghribDateTime: maghribLocal,
          ishaDateTime: ishaLocal,
        ),
      );
    }

    return monthlyTimes;
  }

  CalculationParameters _getCalculationParameters() =>
      CalculationMethod.egyptian.getParameters()..madhab = Madhab.shafi;

  String _formatTime(DateTime dateTime) =>
      _timeFormatter.format(dateTime.toLocal());

  Future<LocalPrayerTimes> _getDefaultPrayerTimes() async {
    final cairoCoordinates = Coordinates(30.0444, 31.2357);
    final calculationParams = _getCalculationParameters();
    final now = DateTime.now();
    final prayerTimes = PrayerTimes(
      cairoCoordinates,
      DateComponents.from(now),
      calculationParams,
    );

    final prefs = await SharedPreferences.getInstance();
    await _cacheCoordinates(
      prefs,
      cairoCoordinates.latitude,
      cairoCoordinates.longitude,
    );

    // Ensure prayer times are in local timezone to avoid DST issues
    final fajrLocal = prayerTimes.fajr.toLocal();
    final sunriseLocal = prayerTimes.sunrise.toLocal();
    final dhuhrLocal = prayerTimes.dhuhr.toLocal();
    final asrLocal = prayerTimes.asr.toLocal();
    final maghribLocal = prayerTimes.maghrib.toLocal();
    final ishaLocal = prayerTimes.isha.toLocal();

    return LocalPrayerTimes(
      fajr: _formatTime(fajrLocal),
      sunrise: _formatTime(sunriseLocal),
      dhuhr: _formatTime(dhuhrLocal),
      asr: _formatTime(asrLocal),
      maghrib: _formatTime(maghribLocal),
      isha: _formatTime(ishaLocal),
      city: 'القاهرة',
      date: now,
      // Store DateTime objects for accurate timezone-aware scheduling
      fajrDateTime: fajrLocal,
      sunriseDateTime: sunriseLocal,
      dhuhrDateTime: dhuhrLocal,
      asrDateTime: asrLocal,
      maghribDateTime: maghribLocal,
      ishaDateTime: ishaLocal,
    );
  }

  Future<Coordinates?> _getCachedOrCurrentCoordinates(bool allowRequest) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsService = SettingsService();

    if (allowRequest && await settingsService.getAutoLocationEnabled()) {
      try {
        final position = await _getCurrentPosition();
        await _cacheCoordinates(prefs, position.latitude, position.longitude);
        return Coordinates(position.latitude, position.longitude);
      } on Object catch (e) {
        logWarning('فشل في الحصول على الموقع الحالي: $e');
      }
    }

    final cachedCoordinates = await getCachedCoordinates();
    if (cachedCoordinates != null) {
      return cachedCoordinates;
    }

    return null;
  }

  @override
  Future<Coordinates?> getCachedCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latitudeKey);
    final lng = prefs.getDouble(_longitudeKey);
    if (lat == null || lng == null) return null;
    return Coordinates(lat, lng);
  }

  Future<Position> _getCurrentPosition() async {
    final locationService = LocationService();
    final position = await locationService.getCurrentLocate();
    if (position != null) return position;
    return Geolocator.getCurrentPosition();
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
