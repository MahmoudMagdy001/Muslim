import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:muslim/core/service/periodic_reminder_channel_factory.dart';
import 'package:muslim/core/service/periodic_reminder_constants.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_notification_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_channel_factory.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_constants.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:workmanager/workmanager.dart';

/// WorkManager callback dispatcher for background prayer time updates.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final now = DateTime.now();
    logInfo('🎯 WorkManager task started! Task: $task - Time: $now');

    // Route to appropriate handler based on task name
    if (task == PeriodicReminderConstants.workManagerTaskName) {
      return _handlePeriodicReminderTask();
    } else {
      return _handlePrayerTimesTask();
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

    final upcomingDaysTimes = <LocalPrayerTimes>[];

    for (var i = 0; i < NotificationConstants.scheduleDaysAhead; i++) {
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
  } on Object catch (e, s) {
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
  } on Object catch (e, s) {
    logError('❌ Error in Periodic Reminder WorkManager', e, s);
    return false;
  }
}
