import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/prayer_times_model.dart';

class PrayerTimesService {
  /// يرجع مواعيد الصلوات اليوم
  Future<LocalPrayerTimes> getPrayerTimes() async {
    final coords = await _getSavedOrFetchCoordinates();

    if (coords == null) {
      // في حالة مفيش صلاحية أو الخدمة مقفولة
      return LocalPrayerTimes(
        fajr: '--:--',
        sunrise: '--:--',
        dhuhr: '--:--',
        asr: '--:--',
        maghrib: '--:--',
        isha: '--:--',
      );
    }

    final params = CalculationMethod.egyptian.getParameters()
      ..madhab = Madhab.shafi;

    final prayerTimes = PrayerTimes.today(coords, params);

    String fmt(DateTime dt) => DateFormat.Hm().format(dt.toLocal());

    return LocalPrayerTimes(
      fajr: fmt(prayerTimes.fajr),
      sunrise: fmt(prayerTimes.sunrise),
      dhuhr: fmt(prayerTimes.dhuhr),
      asr: fmt(prayerTimes.asr),
      maghrib: fmt(prayerTimes.maghrib),
      isha: fmt(prayerTimes.isha),
    );
  }

  /// يحفظ الإحداثيات مره يومياً فقط
  Future<Coordinates?> _getSavedOrFetchCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble('lat');
    final lng = prefs.getDouble('lng');
    final lastUpdatedMillis = prefs.getInt('last_updated');

    final now = DateTime.now();
    final lastUpdated = lastUpdatedMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastUpdatedMillis)
        : null;

    if (lat != null && lng != null && lastUpdated != null) {
      final diff = now.difference(lastUpdated);
      if (diff.inHours < 24) {
        return Coordinates(lat, lng);
      }
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      await prefs.setDouble('lat', position.latitude);
      await prefs.setDouble('lng', position.longitude);
      await prefs.setInt('last_updated', now.millisecondsSinceEpoch);

      return Coordinates(position.latitude, position.longitude);
    } catch (e) {
      print('⚠️ فشل الحصول على الإحداثيات: $e');
      return null;
    }
  }
}
