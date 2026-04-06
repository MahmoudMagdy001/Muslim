import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../core/service/periodic_reminder_channel_factory.dart';
import '../../../../core/service/periodic_reminder_constants.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../settings/service/settings_service.dart';
import '../../domain/entities/local_prayer_times.dart';
import '../../presentation/helper/notification_channel_factory.dart';
import '../../presentation/helper/notification_constants.dart';
import 'prayer_notification_local_data_source.dart';
import 'prayer_times_local_data_source.dart';

/// WorkManager callback dispatcher for background prayer time updates.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final now = DateTime.now();
    logInfo('🎯 WorkManager task started! Task: $task - Time: $now');

    // Route to appropriate handler based on task name
    if (task == PeriodicReminderConstants.workManagerTaskName) {
      return await _handlePeriodicReminderTask();
    } else {
      return await _handlePrayerTimesTask();
    }
  });
}

Future<bool> _handlePrayerTimesTask() async {
  // Initialize notifications in the background isolate
  await AwesomeNotifications().initialize(
    NotificationConstants.notificationIcon,
    [createPrayerChannel()],
  );

  final now = DateTime.now();
  logInfo(
    '🕒 Timezone initialized: ${now.timeZoneName}, offset: ${now.timeZoneOffset}',
  );

  try {
    final prayerDataSource = PrayerTimesLocalDataSourceImpl();
    final notificationDataSource = PrayerNotificationLocalDataSourceImpl();
    final settingsService = SettingsService();

    // Load per-prayer settings
    final settings = await settingsService.getPrayerNotificationSettings();

    final cachedCoords = await prayerDataSource.getCachedCoordinates();
    if (cachedCoords == null) {
      logWarning('لا توجد إحداثيات محفوظة، لا يمكن جدولة الصلاة');
      return false;
    }

    final List<LocalPrayerTimes> upcomingDaysTimes = [];

    for (int i = 0; i < NotificationConstants.scheduleDaysAhead; i++) {
      final date = now.add(Duration(days: i));
      final times = await prayerDataSource.getPrayerTimesForDate(
        cachedCoords,
        date,
      );
      upcomingDaysTimes.add(times);
    }

    await notificationDataSource.scheduleAll(upcomingDaysTimes, settings);

    logSuccess(
      'تمت جدولة مواقيت الصلاة لـ ${NotificationConstants.scheduleDaysAhead} أيام بنجاح في الخلفية - ${DateTime.now()}',
    );
    return true;
  } catch (e, s) {
    logError('خطأ في WorkManager prayer task', e, s);
    return false;
  }
}

Future<bool> _handlePeriodicReminderTask() async {
  final now = DateTime.now();
  logInfo('🔄 Periodic Reminder WorkManager started! Time: $now');

  try {
    // Initialize notifications in the background isolate
    await AwesomeNotifications().initialize(
      PeriodicReminderConstants.notificationIcon,
      [createPeriodicReminderChannel()],
    );

    final settingsService = SettingsService();
    final isEnabled = await settingsService.getPeriodicReminderEnabled();
    final intervalMinutes = await settingsService.getPeriodicReminderInterval();

    if (!isEnabled) {
      logInfo('🚫 Periodic reminders disabled, cancelling any existing');
      await AwesomeNotifications().cancelSchedule(
        PeriodicReminderConstants.periodicReminderNotificationId,
      );
      return true;
    }

    // Cancel existing and reschedule with native interval
    await AwesomeNotifications().cancelSchedule(
      PeriodicReminderConstants.periodicReminderNotificationId,
    );

    final random = Random();
    const messages = PeriodicReminderConstants.reminderMessages;
    final message = messages[random.nextInt(messages.length)];

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: PeriodicReminderConstants.periodicReminderNotificationId,
        channelKey: PeriodicReminderConstants.reminderChannelKey,
        title: message['title'],
        body: message['body'],
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationInterval(
        interval: Duration(minutes: intervalMinutes),
        allowWhileIdle: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
    );

    logSuccess(
      '✅ Periodic reminder rescheduled: every $intervalMinutes minutes',
    );
    return true;
  } catch (e, s) {
    logError('❌ Error in Periodic Reminder WorkManager', e, s);
    return false;
  }
}
