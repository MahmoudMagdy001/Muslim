import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/prayer_times_model.dart';

class PrayerTimesService {
  /// يرجع مواعيد الصلوات اليوم
  Future<LocalPrayerTimes> getPrayerTimes() async {
    final coords = await _getSavedOrFetchCoordinates();

    final params = CalculationMethod.egyptian.getParameters()
      ..madhab = Madhab.hanafi;

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

  /// جدولة إشعارات الصلاة لليوم
  Future<void> schedulePrayerNotifications() async {
    final times = await getPrayerTimes();
    final now = DateTime.now();

    final prayers = {
      'الفجر': times.fajr,
      'الظهر': times.dhuhr,
      'العصر': times.asr,
      'المغرب': times.maghrib,
      'العشاء': times.isha,
    };

    // IDs ثابتة لكل صلاة
    final prayerIds = {
      'الفجر': 1,
      'الظهر': 2,
      'العصر': 3,
      'المغرب': 4,
      'العشاء': 5,
    };

    // امسح أي إشعارات قديمة قبل ما تعمل جدولة جديدة
    await AwesomeNotifications().cancelSchedulesByChannelKey('prayer_reminder');
    print('⏳ تم مسح أي إشعارات قديمة...');

    for (final entry in prayers.entries) {
      final prayerName = entry.key;
      final prayerTimeStr = entry.value;

      final parts = prayerTimeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final scheduled = DateTime(now.year, now.month, now.day, hour, minute);

      if (scheduled.isAfter(now)) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: prayerIds[prayerName]!,
            channelKey: 'prayer_reminder',
            title: 'موعد $prayerName',
            body: 'حان الآن موعد صلاة $prayerName',
            wakeUpScreen: true,
          ),
          schedule: NotificationCalendar(
            year: scheduled.year,
            month: scheduled.month,
            day: scheduled.day,
            hour: scheduled.hour,
            minute: scheduled.minute,
            second: 0,
          ),
        );

        print('✅ تم جدولة إشعار $prayerName عند ${scheduled.toLocal()}');
      } else {
        print('⚠️ تم تخطي $prayerName لأنه عدى (${scheduled.toLocal()})');
      }
    }

    print('🎉 تم جدولة جميع الصلوات القادمة بنجاح!');
  }

  /// يحفظ الإحداثيات مره يومياً فقط
  Future<Coordinates> _getSavedOrFetchCoordinates() async {
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

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      throw Exception('صلاحية الموقع مرفوضة أو الخدمة مش متاحة');
    }

    final position = await Geolocator.getCurrentPosition();
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lng', position.longitude);
    await prefs.setInt('last_updated', now.millisecondsSinceEpoch);

    return Coordinates(position.latitude, position.longitude);
  }

  /// التحقق من صلاحية اللوكيشن
  Future<bool> _handleLocationPermission() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }
}
