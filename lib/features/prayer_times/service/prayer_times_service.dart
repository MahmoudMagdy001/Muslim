import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/prayer_times_model.dart';

class PrayerTimesService {
  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';
  static const int _cacheDurationHours = 24;

  final DateFormat _timeFormatter = DateFormat.Hm();

  /// الحصول على مواقيت الصلاة + اسم المدينة
  Future<LocalPrayerTimes> getPrayerTimes() async {
    try {
      final coordinates = await _getCachedOrCurrentCoordinates();
      if (coordinates == null) return await _getDefaultPrayerTimes();

      String? cityName;
      try {
        geo.setLocaleIdentifier('ar');
        final placemarks = await geo.placemarkFromCoordinates(
          coordinates.latitude,
          coordinates.longitude,
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

      return await _calculatePrayerTimes(coordinates, cityName: cityName);
    } catch (error) {
      debugPrint('❌ خطأ في الحصول على مواقيت الصلاة: $error');
      return await _getDefaultPrayerTimes();
    }
  }

  /// حساب مواقيت الصلاة بناءً على الإحداثيات
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

  /// الحصول على معاملات الحساب
  CalculationParameters _getCalculationParameters() =>
      CalculationMethod.egyptian.getParameters()..madhab = Madhab.shafi;

  /// تنسيق الوقت
  String _formatTime(DateTime dateTime) =>
      _timeFormatter.format(dateTime.toLocal());

  /// الحصول على مواقيت الصلاة الافتراضية (القاهرة)
  Future<LocalPrayerTimes> _getDefaultPrayerTimes() async {
    final cairoCoordinates = Coordinates(30.0444, 31.2357);
    final calculationParams = _getCalculationParameters();
    final prayerTimes = PrayerTimes.today(cairoCoordinates, calculationParams);

    // 🟢 نخزن القاهرة كإحداثيات افتراضية
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

  /// الحصول على الإحداثيات المخزنة أو الحالية
  /// الحصول على الإحداثيات (الأولوية: الحالي -> الكاش -> القاهرة)
  Future<Coordinates?> _getCachedOrCurrentCoordinates() async {
    final prefs = await SharedPreferences.getInstance();

    // 🟢 نحاول نجيب الموقع الحالي
    try {
      final position = await _getCurrentPosition();
      await _cacheCoordinates(prefs, position.latitude, position.longitude);
      return Coordinates(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('⚠️ فشل في الحصول على الموقع الحالي: $e');
    }

    // 🟡 fallback على الكاش لو موجود وصالح
    final cachedCoordinates = await _getCachedCoordinates(prefs);
    if (cachedCoordinates != null) {
      return cachedCoordinates;
    }

    // 🔴 لو مفيش ولا ده ولا ده → null (هنتعامل معاه في getPrayerTimes)
    return null;
  }

  /// الحصول على الإحداثيات المخزنة
  Future<Coordinates?> _getCachedCoordinates(SharedPreferences prefs) async {
    final lat = prefs.getDouble(_latitudeKey);
    final lng = prefs.getDouble(_longitudeKey);
    final lastUpdatedMillis = prefs.getInt(_lastUpdatedKey);

    if (lat == null || lng == null || lastUpdatedMillis == null) {
      return null;
    }

    final lastUpdated = DateTime.fromMillisecondsSinceEpoch(lastUpdatedMillis);
    final timeDiff = DateTime.now().difference(lastUpdated);

    if (timeDiff.inHours < _cacheDurationHours) {
      return Coordinates(lat, lng);
    }

    return null;
  }

  /// الحصول على الموقع الحالي
  Future<Position> _getCurrentPosition() async =>
      await Geolocator.getCurrentPosition();

  /// تخزين الإحداثيات
  Future<void> _cacheCoordinates(
    SharedPreferences prefs,
    double latitude,
    double longitude,
  ) async {
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
    await prefs.setInt(_lastUpdatedKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// مسح الإحداثيات المخزنة
  Future<void> clearCachedCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_latitudeKey);
    await prefs.remove(_longitudeKey);
    await prefs.remove(_lastUpdatedKey);
  }

  /// الحصول على آخر وقت تم فيه تحديث الإحداثيات
  Future<DateTime?> getLastCoordinatesUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdatedMillis = prefs.getInt(_lastUpdatedKey);

    return lastUpdatedMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastUpdatedMillis)
        : null;
  }
}
