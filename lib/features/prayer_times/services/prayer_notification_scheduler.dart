import 'package:awesome_notifications/awesome_notifications.dart';

import '../../../core/utils/app_logger.dart';
import '../helper/notification_constants.dart';
import '../model/prayer_times_model.dart';
import '../models/prayer_notification_settings_model.dart';
import '../models/prayer_type.dart';
import 'prayer_notification_canceler.dart';
import 'prayer_notification_id_generator.dart';
import 'prayer_time_parser.dart';

/// Schedules prayer notifications for multiple days.
///
/// Respects per-prayer settings: only enabled prayers are scheduled.
/// Scheduling is idempotent — rescheduling uses deterministic IDs so
/// it will never create duplicate notifications.
class PrayerNotificationScheduler {
  PrayerNotificationScheduler({
    PrayerTimeParser? timeParser,
    PrayerNotificationIdGenerator? idGenerator,
    PrayerNotificationCanceler? canceler,
  }) : _timeParser = timeParser ?? PrayerTimeParser(),
       _idGenerator = idGenerator ?? PrayerNotificationIdGenerator(),
       _canceler = canceler ?? PrayerNotificationCanceler();

  final PrayerTimeParser _timeParser;
  final PrayerNotificationIdGenerator _idGenerator;
  final PrayerNotificationCanceler _canceler;

  /// Schedules notifications for all enabled prayers across [days].
  ///
  /// Cancels existing notifications first to ensure idempotency.
  Future<void> scheduleAll(
    List<LocalPrayerTimes> days,
    PrayerNotificationSettings settings,
  ) async {
    final now = DateTime.now();
    await _canceler.cancelAll();
    logInfo('تم مسح أي إشعارات قديمة...');

    int totalScheduled = 0;

    for (final times in days) {
      final date = times.date;

      logInfo('📅 جدولة صلوات يوم: ${date.toLocal().toString().split(' ')[0]}');

      for (final prayer in PrayerType.values) {
        if (!settings.isEnabled(prayer)) {
          logInfo(
            '⏭️ تخطي ${prayer.arabicName} — الإشعار معطل بواسطة المستخدم',
          );
          continue;
        }

        final timeStr = times.timeForPrayer(prayer);
        final scheduled = await _scheduleSinglePrayer(
          prayer,
          timeStr,
          date,
          now,
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

  /// Schedules a single prayer notification.
  ///
  /// Returns `true` if the notification was scheduled, `false` if skipped
  /// (e.g. prayer time already passed).
  Future<bool> _scheduleSinglePrayer(
    PrayerType prayer,
    String timeStr,
    DateTime date,
    DateTime now,
  ) async {
    final prayerDateTime = _timeParser.parse(timeStr, date);
    if (prayerDateTime == null) return false;

    if (prayerDateTime.isBefore(now)) return false;

    final notificationId = _idGenerator.generate(date, prayer);

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

  /// Schedules a fallback notification to remind the user to update prayer times.
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
}
