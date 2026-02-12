import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/service/location_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../settings/service/settings_service.dart';
import '../model/prayer_times_model.dart';

/// Service responsible for calculating and providing prayer times.
///
/// Handles coordinate caching, geocoding, and prayer time calculations
/// using the `adhan` package.
class PrayerTimesService {
  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';

  final DateFormat _timeFormatter = DateFormat.Hm();

  /// Fetches prayer times for today, optionally for the whole month.
  ///
  /// [isArabic] controls geocoding locale.
  /// [forMonth] returns a list of all days in the current month.
  /// [coordinates] overrides cached/detected coordinates.
  Future<dynamic> getPrayerTimes({
    required bool isArabic,
    bool forMonth = false,
    Coordinates? coordinates,
  }) async {
    try {
      final coords =
          coordinates ??
          await _getCachedOrCurrentCoordinates(coordinates == null);
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
        logWarning('فشل geocoding: $e');
      }

      if (forMonth) {
        return await _calculateMonthlyPrayerTimes(coords, cityName: cityName);
      } else {
        return await _calculatePrayerTimes(coords, cityName: cityName);
      }
    } catch (error) {
      logError('خطأ في الحصول على مواقيت الصلاة', error);
      return await _getDefaultPrayerTimes();
    }
  }

  /// Fetches prayer times for a specific [date] with given [coordinates].
  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  }) async =>
      _calculatePrayerTimes(coordinates, date: date, cityName: cityName);

  /// Calculates prayer times for a single day (defaults to today).
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

    return LocalPrayerTimes(
      fajr: _formatTime(prayerTimes.fajr),
      dhuhr: _formatTime(prayerTimes.dhuhr),
      asr: _formatTime(prayerTimes.asr),
      maghrib: _formatTime(prayerTimes.maghrib),
      isha: _formatTime(prayerTimes.isha),
      city: cityName ?? 'غير معروف',
      date: targetDate,
    );
  }

  /// Calculates prayer times for every day of the current month.
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
          date: date,
        ),
      );
    }

    return monthlyTimes;
  }

  CalculationParameters _getCalculationParameters() =>
      CalculationMethod.egyptian.getParameters()..madhab = Madhab.shafi;

  String _formatTime(DateTime dateTime) =>
      _timeFormatter.format(dateTime.toLocal());

  /// Fallback prayer times using Cairo coordinates.
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

    return LocalPrayerTimes(
      fajr: _formatTime(prayerTimes.fajr),
      dhuhr: _formatTime(prayerTimes.dhuhr),
      asr: _formatTime(prayerTimes.asr),
      maghrib: _formatTime(prayerTimes.maghrib),
      isha: _formatTime(prayerTimes.isha),
      city: 'القاهرة',
      date: now,
    );
  }

  /// Gets coordinates from cache or current location.
  Future<Coordinates?> _getCachedOrCurrentCoordinates(bool allowRequest) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsService = SettingsService();

    if (allowRequest && await settingsService.getAutoLocationEnabled()) {
      try {
        final position = await _getCurrentPosition();
        await _cacheCoordinates(prefs, position.latitude, position.longitude);
        return Coordinates(position.latitude, position.longitude);
      } catch (e) {
        logWarning('فشل في الحصول على الموقع الحالي: $e');
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

  Future<Position> _getCurrentPosition() async {
    final locationService = LocationService();
    final position = await locationService.getCurrentLocate();
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
