import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../helper/prayer_consts.dart';
import '../model/prayer_times_model.dart';

class PrayerNotificationService {
  final DateFormat _timeFormat = DateFormat('HH:mm');

  /// جدولة إشعارات الصلاة
  Future<void> schedulePrayerNotifications(LocalPrayerTimes times) async {
    final now = DateTime.now();
    final areAllPrayersFinished = _areAllPrayersFinished(times, now);

    await AwesomeNotifications().cancelSchedulesByChannelKey('prayer_reminder');
    debugPrint('⏳ تم مسح أي إشعارات قديمة...');

    final prayers = _getPrayersMap(times);
    int scheduledCount = 0;

    for (final entry in prayers.entries) {
      final prayerName = entry.key;
      final prayerTimeStr = entry.value;

      if (prayerTimeStr == '--:--') {
        debugPrint('⚠️ تخطي $prayerName لعدم توفر توقيت');
        continue;
      }

      final shouldSchedule = await _scheduleSinglePrayer(
        prayerName,
        prayerTimeStr,
        now,
        areAllPrayersFinished,
      );

      if (shouldSchedule) scheduledCount++;
    }

    debugPrint('🎉 تم جدولة $scheduledCount إشعار بنجاح!');

    if (scheduledCount == 0 && !areAllPrayersFinished) {
      await _scheduleUpdateNotification(now);
    }
  }

  /// جدولة إشعار صلاة واحدة
  Future<bool> _scheduleSinglePrayer(
    String prayerName,
    String prayerTimeStr,
    DateTime now,
    bool areAllPrayersFinished,
  ) async {
    final prayerDateTime = _getPrayerDateTime(
      prayerTimeStr,
      now,
      prayerName,
      areAllPrayersFinished,
    );

    if (prayerDateTime == null) return false;

    final scheduledTime = prayerDateTime.subtract(const Duration(minutes: 1));

    if (scheduledTime.isAfter(now) ||
        (areAllPrayersFinished && prayerName == 'الفجر')) {
      final notificationId = _getPrayerNotificationId(prayerName);

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'prayer_reminder',
          title: 'اذان $prayerName',
          body: 'باقي دقيقة على صلاة $prayerName',
          wakeUpScreen: true,
        ),
        schedule: NotificationCalendar(
          year: scheduledTime.year,
          month: scheduledTime.month,
          day: scheduledTime.day,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
        ),
      );

      debugPrint('✅ تم جدولة إشعار $prayerName (${scheduledTime.toLocal()})');
      return true;
    }

    debugPrint('⚠️ تم تخطي إشعار $prayerName');
    return false;
  }

  /// الحصول على خريطة الصلوات
  Map<String, String> _getPrayersMap(LocalPrayerTimes times) => {
    'الفجر': times.fajr,
    'الظهر': times.dhuhr,
    'العصر': times.asr,
    'المغرب': times.maghrib,
    'العشاء': times.isha,
  };

  /// الحصول على معرف الإشعار للصلاة
  int _getPrayerNotificationId(String prayerName) {
    final prayerIds = {
      'الفجر': 1,
      'الظهر': 2,
      'العصر': 3,
      'المغرب': 4,
      'العشاء': 5,
    };
    return prayerIds[prayerName]!;
  }

  /// الحصول على وقت الصلاة كـ DateTime
  DateTime? _getPrayerDateTime(
    String prayerTimeStr,
    DateTime now,
    String prayerName,
    bool areAllPrayersFinished,
  ) {
    final parts = prayerTimeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    // إذا انتهت جميع الصلوات، نجدول الفجر للغد
    if (areAllPrayersFinished && prayerName == 'الفجر') {
      return DateTime(now.year, now.month, now.day + 1, hour, minute);
    }

    final prayerDateTime = DateTime(now.year, now.month, now.day, hour, minute);

    // إذا مضى وقت الصلاة ولا نجدول للغد، نتخطاها
    if (prayerDateTime.isBefore(now) && !areAllPrayersFinished) {
      return null;
    }

    return prayerDateTime;
  }

  /// جدولة إشعار التحديث
  Future<void> _scheduleUpdateNotification(DateTime now) async {
    final updateTime = DateTime(now.year, now.month, now.day, 23, 59);

    if (updateTime.isAfter(now)) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 100,
          channelKey: 'prayer_reminder',
          title: 'تحديث مواعيد الصلاة',
          body: 'سيتم تحديث مواعيد الصلاة لليوم الجديد تلقائياً',
        ),
        schedule: NotificationCalendar(
          year: updateTime.year,
          month: updateTime.month,
          day: updateTime.day,
          hour: updateTime.hour,
          minute: updateTime.minute,
          second: 0,
        ),
      );
      debugPrint('🔔 تم جدولة إشعار التحديث');
    }
  }

  /// التحقق إذا انتهت جميع صلوات اليوم
  bool _areAllPrayersFinished(LocalPrayerTimes times, DateTime now) {
    final timingsMap = times.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      if (prayerTime == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return false;
    }

    return true;
  }

  DateTime _parsePrayerTime(String timeString, DateTime referenceDate) {
    final parsed = _timeFormat.parse(timeString);
    return DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      parsed.hour,
      parsed.minute,
    );
  }
}
