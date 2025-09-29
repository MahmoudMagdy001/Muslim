import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/prayer_times_model.dart';

class PrayerTimesService {
  static const String _latitudeKey = 'lat';
  static const String _longitudeKey = 'lng';
  static const String _lastUpdatedKey = 'last_updated';
  static const int _cacheDurationHours = 24;

  final DateFormat _timeFormatter = DateFormat.Hm();

  /// الحصول على مواقيت الصلاة
  Future<LocalPrayerTimes> getPrayerTimes() async {
    try {
      final coordinates = await _getCachedOrCurrentCoordinates();
      return await _calculatePrayerTimes(coordinates);
    } catch (error) {
      debugPrint('❌ خطأ في الحصول على مواقيت الصلاة: $error');
      return _getDefaultPrayerTimes();
    }
  }

  /// حساب مواقيت الصلاة بناءً على الإحداثيات
  Future<LocalPrayerTimes> _calculatePrayerTimes(
    Coordinates? coordinates,
  ) async {
    if (coordinates == null) {
      return _getDefaultPrayerTimes();
    }

    final calculationParams = _getCalculationParameters();
    final prayerTimes = PrayerTimes.today(coordinates, calculationParams);

    return LocalPrayerTimes(
      fajr: _formatTime(prayerTimes.fajr),
      dhuhr: _formatTime(prayerTimes.dhuhr),
      asr: _formatTime(prayerTimes.asr),
      maghrib: _formatTime(prayerTimes.maghrib),
      isha: _formatTime(prayerTimes.isha),
    );
  }

  /// الحصول على معاملات الحساب
  CalculationParameters _getCalculationParameters() =>
      CalculationMethod.egyptian.getParameters()..madhab = Madhab.shafi;

  /// تنسيق الوقت
  String _formatTime(DateTime dateTime) =>
      _timeFormatter.format(dateTime.toLocal());

  /// الحصول على مواقيت الصلاة الافتراضية (في حالة الخطأ)
  LocalPrayerTimes _getDefaultPrayerTimes() => LocalPrayerTimes(
    fajr: '--:--',
    dhuhr: '--:--',
    asr: '--:--',
    maghrib: '--:--',
    isha: '--:--',
  );

  /// الحصول على الإحداثيات المخزنة أو الحالية
  Future<Coordinates?> _getCachedOrCurrentCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedCoordinates = await _getCachedCoordinates(prefs);

    if (cachedCoordinates != null) {
      return cachedCoordinates;
    }

    return await _fetchAndCacheCurrentCoordinates(prefs);
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

  /// جلب الإحداثيات الحالية وتخزينها
  Future<Coordinates?> _fetchAndCacheCurrentCoordinates(
    SharedPreferences prefs,
  ) async {
    try {
      final position = await _getCurrentPosition();
      await _cacheCoordinates(prefs, position.latitude, position.longitude);
      return Coordinates(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('⚠️ فشل في الحصول على الموقع الحالي: $e');
      return null;
    }
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

  /// مسح الإحداثيات المخزنة (لأغراض الت testing أو إعادة التعيين)
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
