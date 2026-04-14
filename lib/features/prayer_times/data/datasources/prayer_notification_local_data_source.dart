import 'package:awesome_notifications/awesome_notifications.dart';

import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/local_prayer_times.dart';
import '../../domain/entities/prayer_notification_settings.dart';
import '../../domain/entities/prayer_type.dart';
import '../../presentation/helper/notification_constants.dart';

abstract class PrayerNotificationLocalDataSource {
  Future<void> scheduleAll(
    List<LocalPrayerTimes> days,
    PrayerNotificationSettings settings,
  );

  Future<void> cancelAll();
}

class PrayerNotificationLocalDataSourceImpl
    implements PrayerNotificationLocalDataSource {
  @override
  Future<void> scheduleAll(
    List<LocalPrayerTimes> days,
    PrayerNotificationSettings settings,
  ) async {
    final now = DateTime.now();
    await cancelAll();
    logInfo('تم مسح أي إشعارات قديمة...');

    int totalScheduled = 0;

    for (final times in days) {
      final date = times.date;

      logInfo('📅 جدولة صلوات يوم: ${date.toLocal().toString().split(' ')[0]}');

      for (final prayer in PrayerType.values) {
        // Skip prayers that don't have an azan (e.g., sunrise)
        if (!prayer.hasAzan) continue;

        if (!settings.isEnabled(prayer)) {
          logInfo(
            '⏭️ تخطي ${prayer.arabicName} — الإشعار معطل بواسطة المستخدم',
          );
          continue;
        }

        final timeStr = times.timeForPrayer(prayer);
        final prayerDateTimeObj = times.dateTimeForPrayer(prayer);
        final scheduled = await _scheduleSinglePrayer(
          prayer,
          timeStr,
          date,
          now,
          prayerDateTimeObj,
        );
        if (scheduled) totalScheduled++;
      }
    }

    logSuccess('تم جدولة إجمالي $totalScheduled إشعار بنجاح لأيام متعددة!');

    // Schedule a fallback update reminder if nothing was scheduled
    if (totalScheduled == 0) {
      await _scheduleUpdateNotification(now);
    }
  }

  @override
  Future<void> cancelAll() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(
        NotificationConstants.prayerChannelKey,
      );
      logInfo('تم إلغاء جميع إشعارات الصلاة السابقة');
    } catch (e) {
      logWarning('حدث خطأ أثناء إلغاء الإشعارات: $e');
    }
  }

  Future<bool> _scheduleSinglePrayer(
    PrayerType prayer,
    String timeStr,
    DateTime date,
    DateTime now,
    DateTime? prayerDateTimeObj,
  ) async {
    // Use the DateTime object if available (accurate timezone), otherwise parse from string
    DateTime? prayerDateTime;
    if (prayerDateTimeObj != null) {
      prayerDateTime = prayerDateTimeObj;
    } else {
      prayerDateTime = _parsePrayerTime(timeStr, date);
    }
    if (prayerDateTime == null) return false;

    if (prayerDateTime.isBefore(now)) return false;

    final notificationId = _generateNotificationId(date, prayer);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: NotificationConstants.prayerChannelKey,
        title: 'أذان ${prayer.arabicName}',
        body: 'حان الأن موعد أذان ${prayer.arabicName}',
        wakeUpScreen: true,
        category: NotificationCategory.Event,
        criticalAlert: true,
      ),
      schedule: NotificationCalendar(
        year: prayerDateTime.year,
        month: prayerDateTime.month,
        day: prayerDateTime.day,
        hour: prayerDateTime.hour,
        minute: prayerDateTime.minute,
        second: 0,
        allowWhileIdle: true,
      ),
    );

    logSuccess(
      'تم جدولة ${prayer.arabicName} في ${prayerDateTime.toString()} (ID: $notificationId)',
    );
    return true;
  }

  Future<void> _scheduleUpdateNotification(DateTime now) async {
    final updateTime = DateTime(
      now.year,
      now.month,
      now.day + NotificationConstants.updateDelayDays,
      NotificationConstants.updateHour,
    );

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: NotificationConstants.updateNotificationId,
        channelKey: NotificationConstants.prayerChannelKey,
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

  DateTime? _parsePrayerTime(String timeStr, DateTime date) {
    if (timeStr == '--:--') return null;

    final parts = timeStr.split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    // Create in local timezone to avoid DST offset issues
    // Use date.toLocal() to ensure we're working with local timezone
    final localDate = date.toLocal();
    return DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
      hour,
      minute,
    );
  }

  int _generateNotificationId(DateTime date, PrayerType prayer) {
    final dateStr =
        '${date.year}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}';

    return int.parse('$dateStr${prayer.notificationIndex}');
  }
}
