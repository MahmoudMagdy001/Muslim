import 'dart:async';
import 'dart:io';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/settings/data/services/settings_service.dart';
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

  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  });

  Future<Coordinates?> getCachedCoordinates();
}

class PrayerTimesLocalDataSourceImpl implements PrayerTimesLocalDataSource {
  PrayerTimesLocalDataSourceImpl({
    SettingsService? settingsService,
    LocationService? locationService,
  }) : _settingsService = settingsService ??
            (getIt.isRegistered<SettingsService>()
                ? getIt<SettingsService>()
                : SettingsService()),
       _locationService = locationService ??
            (getIt.isRegistered<LocationService>()
                ? getIt<LocationService>()
                : LocationService());

  final SettingsService _settingsService;
  final LocationService _locationService;

  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';
  static const String _cityNameKey = 'city_name';

  static final Coordinates _cairoCoordinates = Coordinates(30.0444, 31.2357);

  final DateFormat _timeFormatter = DateFormat.Hm();

  @override
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    bool useLocation = true,
    Coordinates? coordinates,
  }) {
    if (forMonth) {
      return getMonthlyPrayerTimes(
        isArabic: isArabic,
        useLocation: useLocation,
        coordinates: coordinates,
      );
    }
    return getDailyPrayerTimes(
      isArabic: isArabic,
      useLocation: useLocation,
      coordinates: coordinates,
    );
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

      return await _calculatePrayerTimes(
        resolved.coordinates,
        cityName: resolved.cityName,
      );
    } on Object catch (error) {
      logError('خطأ في الحصول على مواقيت الصلاة', error);
      return _getDefaultPrayerTimes(isArabic: isArabic);
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

      return await _calculateMonthlyPrayerTimes(
        resolved.coordinates,
        cityName: resolved.cityName,
      );
    } on Object catch (error) {
      logError('خطأ في الحصول على مواقيت الصلاة', error);
      return [await _getDefaultPrayerTimes(isArabic: isArabic)];
    }
  }

  /// Resolves location and city name according to requirements:
  /// 1. If internet is available: wait for city name to load via geocoding.
  /// 2. If no internet: fetch from cache.
  /// 3. If cache is empty: fallback to Cairo.
  Future<_ResolvedLocation> _resolveCoordinatesAndCityName({
    required bool isArabic,
    required bool useLocation,
    Coordinates? coordinates,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final hasInternet = await _hasInternetConnection();

    // 1. If no internet: fetch from cache, else fallback to Cairo
    if (!hasInternet) {
      logInfo('📶 لا يوجد اتصال بالإنترنت — محاولة القراءة من الكاش...');
      final cached = await _getCachedLocation(prefs, isArabic);
      if (cached != null) {
        logSuccess('📦 تم استرجاع مواقيت الصلاة والمدينة من الكاش: ${cached.cityName}');
        return cached;
      }
      logWarning('⚠️ لا يوجد بيانات في الكاش ولا يوجد إنترنت — الرجوع للقاهرة');
      return _getCairoLocation(isArabic);
    }

    // 2. If internet is available: resolve coordinates and await city name geocoding
    var targetCoords = coordinates;

    if (targetCoords == null && useLocation) {
      if (await _settingsService.getAutoLocationEnabled()) {
        try {
          final position = await _getCurrentPosition();
          if (position != null) {
            targetCoords = Coordinates(position.latitude, position.longitude);
          }
        } on Object catch (e) {
          logWarning('تعذر تحديد موقع GPS: $e');
        }
      }
    }

    // If we have coordinates, resolve city name with geocoding
    if (targetCoords != null) {
      String? cityName;
      try {
        cityName = await _geocodeCityName(targetCoords, isArabic);
      } on Object catch (e) {
        logWarning('فشل geocoding أثناء توفر الإنترنت: $e');
      }

      // If geocoding didn't return a city, retain previously cached city or localized fallback
      final cachedCity = (await _getCachedLocation(prefs, isArabic))?.cityName;
      final effectiveCity = (cityName != null && cityName.trim().isNotEmpty)
          ? cityName.trim()
          : (cachedCity != null && cachedCity.isNotEmpty)
              ? cachedCity
              : (isArabic ? 'موقعي الحالي' : 'Current Location');

      await _cacheCoordinates(prefs, targetCoords.latitude, targetCoords.longitude);
      if (cityName != null && cityName.trim().isNotEmpty) {
        await prefs.setString(_cityNameKey, cityName.trim());
        await prefs.setString('${_cityNameKey}_${isArabic ? "ar" : "en"}', cityName.trim());
      }

      logSuccess('🏙️ تم اعتماد إحداثيات وموقع الصلاة: $effectiveCity (${targetCoords.latitude}, ${targetCoords.longitude})');
      return _ResolvedLocation(coordinates: targetCoords, cityName: effectiveCity);
    }

    // 3. If GPS or geocoding failed: fallback to cache, else Cairo
    final cached = await _getCachedLocation(prefs, isArabic);
    if (cached != null) {
      logInfo('📦 الرجوع إلى الكاش لعدم اكتمال بيانات الموقع الجديد: ${cached.cityName}');
      return cached;
    }

    logWarning('⚠️ تعذر تحديد الموقع والكاش فارغ — الرجوع إلى القاهرة');
    return _getCairoLocation(isArabic);
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on Object catch (_) {}

    try {
      return await InternetStateManagerInitializer.checkConnection()
          .timeout(const Duration(seconds: 2));
    } on Object catch (_) {
      return false;
    }
  }

  Future<String?> _geocodeCityName(Coordinates coords, bool isArabic) async {
    try {
      final geocoding = geo.Geocoding();
      final placemarks = await geocoding.placemarkFromCoordinates(
        coords.latitude,
        coords.longitude,
        locale: Locale(isArabic ? 'ar' : 'en'),
      ).timeout(const Duration(seconds: 10));

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = (place.locality?.isNotEmpty ?? false)
            ? place.locality
            : (place.subAdministrativeArea?.isNotEmpty ?? false)
                ? place.subAdministrativeArea
                : (place.administrativeArea?.isNotEmpty ?? false)
                    ? place.administrativeArea
                    : null;
        if (city != null && city.trim().isNotEmpty) {
          return city.trim();
        }
      }
    } on Object catch (e) {
      logWarning('فشل _geocodeCityName: $e');
    }
    return null;
  }

  Future<_ResolvedLocation?> _getCachedLocation(
    SharedPreferences prefs,
    bool isArabic,
  ) async {
    final lat = prefs.getDouble(_latitudeKey);
    final lng = prefs.getDouble(_longitudeKey);
    final cityLocaleKey = '${_cityNameKey}_${isArabic ? "ar" : "en"}';
    final city = prefs.getString(cityLocaleKey) ?? prefs.getString(_cityNameKey);

    if (lat != null && lng != null && city != null && city.trim().isNotEmpty) {
      return _ResolvedLocation(
        coordinates: Coordinates(lat, lng),
        cityName: city.trim(),
      );
    }
    return null;
  }

  _ResolvedLocation _getCairoLocation(bool isArabic) => _ResolvedLocation(
    coordinates: _cairoCoordinates,
    cityName: isArabic ? 'القاهرة' : 'Cairo',
  );

  @override
  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  }) async {
    var city = cityName;
    if (city == null) {
      final prefs = await SharedPreferences.getInstance();
      city = prefs.getString(_cityNameKey) ?? 'القاهرة';
    }
    return _calculatePrayerTimes(coordinates, date: date, cityName: city);
  }

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
      city: cityName ?? 'القاهرة',
      date: targetDate,
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
          city: cityName ?? 'القاهرة',
          date: date,
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

  Future<LocalPrayerTimes> _getDefaultPrayerTimes({bool isArabic = true}) async {
    final calculationParams = _getCalculationParameters();
    final now = DateTime.now();
    final prayerTimes = PrayerTimes(
      _cairoCoordinates,
      DateComponents.from(now),
      calculationParams,
    );

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
      city: isArabic ? 'القاهرة' : 'Cairo',
      date: now,
      fajrDateTime: fajrLocal,
      sunriseDateTime: sunriseLocal,
      dhuhrDateTime: dhuhrLocal,
      asrDateTime: asrLocal,
      maghribDateTime: maghribLocal,
      ishaDateTime: ishaLocal,
    );
  }

  @override
  Future<Coordinates?> getCachedCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latitudeKey);
    final lng = prefs.getDouble(_longitudeKey);
    if (lat == null || lng == null) return null;
    return Coordinates(lat, lng);
  }

  Future<Position?> _getCurrentPosition() async {
    final position = await _locationService.getCurrentLocate();
    if (position != null) return position;

    try {
      final lastKnown = await _locationService.getLastKnownPosition();
      if (lastKnown != null) return lastKnown;
    } on Object catch (_) {}

    return null;
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

class _ResolvedLocation {
  const _ResolvedLocation({required this.coordinates, required this.cityName});

  final Coordinates coordinates;
  final String cityName;
}
