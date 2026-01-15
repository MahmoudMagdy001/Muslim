import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

import '../../settings/service/settings_service.dart';
import '../model/prayer_times_model.dart';

class PrayerNotificationService {
  final SettingsService _settingsService = SettingsService();

  /// جدولة إشعارات الصلاة لعدة أيام
  Future<void> schedulePrayerNotifications(
    List<LocalPrayerTimes> upcomingDaysTimes,
  ) async {
    final enabled = await _settingsService.getPrayerNotificationsEnabled();
    if (!enabled) {
      debugPrint('🚫 الإشعارات معطلة، لن يتم جدولة أي إشعار');
      await cancelAllNotifications();
      return;
    }

    final now = DateTime.now();
    await cancelAllNotifications(); // تنظيف القديم والجدولة من جديد
    debugPrint('⏳ تم مسح أي إشعارات قديمة...');

    int totalScheduled = 0;

    for (final times in upcomingDaysTimes) {
      final date = times.date ?? now; // استخدام تاريخ اليوم من الموديل
      final prayers = _getPrayersMap(times);

      debugPrint(
        '📅 جدولة صلوات يوم: ${date.toLocal().toString().split(' ')[0]}',
      );

      for (final entry in prayers.entries) {
        final prayerName = entry.key;
        final prayerTimeStr = entry.value;

        if (prayerTimeStr == '--:--') continue;

        final shouldSchedule = await _scheduleSinglePrayer(
          prayerName,
          prayerTimeStr,
          date,
        );

        if (shouldSchedule) totalScheduled++;
      }
    }

    debugPrint('🎉 تم جدولة إجمالي $totalScheduled إشعار بنجاح لأيام متعددة!');

    // جدولة تحديث لليوم التالي (اختياري الآن مع الـ WorkManager، ولكن جيد كاحتياط)
    if (totalScheduled == 0) {
      await _scheduleUpdateNotification(now);
    }
  }

  /// جدولة إشعار صلاة واحدة
  Future<bool> _scheduleSinglePrayer(
    String prayerName,
    String prayerTimeStr,
    DateTime date,
  ) async {
    final now = DateTime.now();
    final prayerDateTime = _getPrayerDateTime(prayerTimeStr, date);

    if (prayerDateTime.isBefore(now)) {
      // تخطي الصلوات التي مضى وقتها (لليوم الحالي فقط)
      return false;
    }

    final notificationId = _getPrayerNotificationId(date, prayerName);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'prayer_reminder',
        title: 'أذان $prayerName',
        body: 'حان الأن موعد أذان $prayerName',
        wakeUpScreen: true,
        category: NotificationCategory.Alarm, // مهم جداً للأذان
        criticalAlert: true,
      ),
      schedule: NotificationCalendar(
        year: prayerDateTime.year,
        month: prayerDateTime.month,
        day: prayerDateTime.day,
        hour: prayerDateTime.hour,
        minute: prayerDateTime.minute,
        second: 0,
        allowWhileIdle: true, // يعمل حتى لو الجوال في وضع الخمول
      ),
    );

    debugPrint(
      '✅ تم جدولة $prayerName في ${prayerDateTime.toString()} (ID: $notificationId)',
    );
    return true;
  }

  /// الحصول على خريطة الصلوات
  Map<String, String> _getPrayersMap(LocalPrayerTimes times) => {
    'الفجر': times.fajr,
    'الظهر': times.dhuhr,
    'العصر': times.asr,
    'المغرب': times.maghrib,
    'العشاء': times.isha,
  };

  /// توليد ID فريد بناءً على التاريخ واسم الصلاة
  /// التنسيق: YYYYMMDD + Index (1-5)
  /// مثال: 202401151 (الفجر يوم 15 يناير 2024)
  int _getPrayerNotificationId(DateTime date, String prayerName) {
    final prayerIds = {
      'الفجر': 1,
      'الظهر': 2,
      'العصر': 3,
      'المغرب': 4,
      'العشاء': 5,
    };

    final dateStr =
        "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
    final prayerIndex = prayerIds[prayerName]!;

    // دمج التاريخ مع رقم الصلاة لإنشاء ID فريد
    return int.parse('$dateStr$prayerIndex');
  }

  /// تحويل وقت الصلاة النصي إلى DateTime بناءً على تاريخ معين
  DateTime _getPrayerDateTime(String prayerTimeStr, DateTime date) {
    final parts = prayerTimeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  /// جدولة إشعار التحديث
  Future<void> _scheduleUpdateNotification(DateTime now) async {
    // يمكن الإبقاء عليه كاحتياطي لتذكير المستخدم بفتح التطبيق
    final updateTime = DateTime(
      now.year,
      now.month,
      now.day + 3,
      9,
    ); // بعد 3 أيام

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 999999,
        channelKey: 'prayer_reminder',
        title: 'تحديث المواقيت',
        body: 'يرجى فتح التطبيق لتحديث مواقيت الصلاة للأيام القادمة',
      ),
      schedule: NotificationCalendar(
        year: updateTime.year,
        month: updateTime.month,
        day: updateTime.day,
        hour: updateTime.hour,
        minute: updateTime.minute,
        second: 0,
        allowWhileIdle: true,
      ),
    );
  }

  Future<void> cancelAllNotifications() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(
        'prayer_reminder',
      );
      debugPrint('❌ تم إلغاء جميع إشعارات الصلاة السابقة');
    } catch (e) {
      debugPrint('⚠️ حدث خطأ أثناء إلغاء الإشعارات: $e');
    }
  }
}
