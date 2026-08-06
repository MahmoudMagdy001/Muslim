import 'dart:async';

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
  /// Kept for backward compatibility with existing callers.
  /// Prefer [getDailyPrayerTimes] / [getMonthlyPrayerTimes] for type safety.
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    bool useLocation = true,
    Coordinates? coordinates,
  });

  Future<LocalPrayerTimes> getDailyPrayerTimes({
    required bool isArabic,
    bool useLocation = true,
    Coordinates? coordinates,
  });

  Future<List<LocalPrayerTimes>> getMonthlyPrayerTimes({
    required bool isArabic,
    bool useLocation = true,
    Coordinates? coordinates,
  });

  Future<LocalPrayerTimes> getPrayerTimesForDate(Coordinates coordinates, DateTime date, {String? cityName});

  Future<Coordinates?> getCachedCoordinates();
}

class PrayerTimesLocalDataSourceImpl implements PrayerTimesLocalDataSource {
  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';
  static const String _cityNameKey = 'city_name';

  final DateFormat _timeFormatter = DateFormat.Hm();

  @override
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    bool useLocation = true,
    Coordinates? coordinates,
  }) {
    if (forMonth) {
      return getMonthlyPrayerTimes(isArabic: isArabic, useLocation: useLocation, coordinates: coordinates);
    }
    return getDailyPrayerTimes(isArabic: isArabic, useLocation: useLocation, coordinates: coordinates);
  }

  @override
  Future<LocalPrayerTimes> getDailyPrayerTimes({
    required bool isArabic,
    bool useLocation = true,
    Coordinates? coordinates,
  }) async {
    try {
      final resolved = await _resolveCoordinatesAndCityName(
        isArabic: isArabic,
        useLocation: useLocation,
        coordinates: coordinates,
      );
      if (resolved == null) return _getDefaultPrayerTimes();

      return await _calculatePrayerTimes(resolved.coordinates, cityName: resolved.cityName);
    } on Object catch (error) {
      logError('خطأ في الحصول على مواقيت الصلاة', error);
      return _getDefaultPrayerTimes();
    }
  }

  @override
  Future<List<LocalPrayerTimes>> getMonthlyPrayerTimes({
    required bool isArabic,
    bool useLocation = true,
    Coordinates? coordinates,
  }) async {
    try {
      final resolved = await _resolveCoordinatesAndCityName(
        isArabic: isArabic,
        useLocation: useLocation,
        coordinates: coordinates,
      );
      if (resolved == null) return [await _getDefaultPrayerTimes()];

      return await _calculateMonthlyPrayerTimes(resolved.coordinates, cityName: resolved.cityName);
    } on Object catch (error) {
      logError('خطأ في الحصول على مواقيت الصلاة', error);
      return [await _getDefaultPrayerTimes()];
    }
  }

  /// ponytail: cache-first — resolves coordinates and the best-known city
  /// name immediately, then refreshes the city name in the background.
  Future<_ResolvedLocation?> _resolveCoordinatesAndCityName({
    required bool isArabic,
    required bool useLocation,
    Coordinates? coordinates,
  }) async {
    final coords = useLocation ? (coordinates ?? await _getCachedOrFreshCoordinates()) : null;
    if (coords == null) return null;

    final prefs = await SharedPreferences.getInstance();
    final cachedCity = prefs.getString(_cityNameKey);

    // Fire-and-forget: update city name in background without blocking
    unawaited(_refreshCityNameIfNeeded(coords, isArabic, prefs));

    return _ResolvedLocation(coordinates: coords, cityName: cachedCity);
  }

  @override
  Future<LocalPrayerTimes> getPrayerTimesForDate(Coordinates coordinates, DateTime date, {String? cityName}) async =>
      _calculatePrayerTimes(coordinates, date: date, cityName: cityName);

  Future<LocalPrayerTimes> _calculatePrayerTimes(Coordinates coordinates, {DateTime? date, String? cityName}) async {
    final calculationParams = _getCalculationParameters();
    final targetDate = date ?? DateTime.now();

    final prayerTimes = PrayerTimes(coordinates, DateComponents.from(targetDate), calculationParams);

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

  Future<List<LocalPrayerTimes>> _calculateMonthlyPrayerTimes(Coordinates coordinates, {String? cityName}) async {
    final calculationParams = _getCalculationParameters();
    final now = DateTime.now();

    final monthlyTimes = <LocalPrayerTimes>[];
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(now.year, now.month, day);
      final prayerTimes = PrayerTimes(coordinates, DateComponents.from(date), calculationParams);

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

  String _formatTime(DateTime dateTime) => _timeFormatter.format(dateTime.toLocal());

  /// Fallback used when no location is available or an error occurs.
  /// Deliberately NOT persisted to the location cache: doing so would
  /// silently overwrite a previously-known real location and cause
  /// subsequent cache-first reads to serve Cairo times instead of the
  /// user's actual last-known location.
  Future<LocalPrayerTimes> _getDefaultPrayerTimes() async {
    final cairoCoordinates = Coordinates(30.0444, 31.2357);
    final calculationParams = _getCalculationParameters();
    final now = DateTime.now();
    final prayerTimes = PrayerTimes(cairoCoordinates, DateComponents.from(now), calculationParams);

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

  /// ponytail: cache-first — return cached coords instantly, then update GPS
  /// in background. On first launch (nothing cached yet) we await a single
  /// GPS fetch instead of firing it twice.
  Future<Coordinates?> _getCachedOrFreshCoordinates() async {
    final cached = await getCachedCoordinates();

    if (cached != null) {
      logInfo('📍 كاش فوري (Cached): ${cached.latitude}, ${cached.longitude}');
      // Fire-and-forget GPS refresh so next launch gets fresh coords.
      unawaited(_refreshGpsInBackground());
      return cached;
    }

    // First launch only: nothing cached, so we must wait for a single GPS fix.
    return _refreshGpsInBackground();
  }

  Future<Coordinates?> _refreshGpsInBackground() async {
    final settingsService = SettingsService();
    if (!await settingsService.getAutoLocationEnabled()) return null;
    try {
      final position = await _getCurrentPosition();
      final prefs = await SharedPreferences.getInstance();
      await _cacheCoordinates(prefs, position.latitude, position.longitude);
      logSuccess('📍 GPS محدّث في الخلفية: ${position.latitude}, ${position.longitude}');
      return Coordinates(position.latitude, position.longitude);
    } on Object catch (e) {
      logWarning('فشل GPS في الخلفية: $e');
      return null;
    }
  }

  /// Refreshes city name via geocoding in background and caches it for next launch.
  Future<void> _refreshCityNameIfNeeded(Coordinates coords, bool isArabic, SharedPreferences prefs) async {
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
        final city = place.locality?.isNotEmpty ?? false ? place.locality : place.administrativeArea;
        if (city != null) {
          await prefs.setString(_cityNameKey, city);
          logInfo('🏙️ تم تحديث اسم المدينة في الخلفية: $city');
        }
      }
    } on Object catch (e) {
      logWarning('فشل geocoding في الخلفية: $e');
    }
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

  Future<void> _cacheCoordinates(SharedPreferences prefs, double latitude, double longitude) async {
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
    await prefs.setInt(_lastUpdatedKey, DateTime.now().millisecondsSinceEpoch);
  }
}

class _ResolvedLocation {
  const _ResolvedLocation({required this.coordinates, required this.cityName});

  final Coordinates coordinates;
  final String? cityName;
}
