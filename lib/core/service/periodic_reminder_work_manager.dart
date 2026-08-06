import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:muslim/core/service/periodic_reminder_channel_factory.dart';
import 'package:muslim/core/service/periodic_reminder_constants.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:workmanager/workmanager.dart';

/// WorkManager callback dispatcher for periodic reminder background scheduling.
@pragma('vm:entry-point')
void periodicReminderCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final now = DateTime.now();
    logInfo(
      '🔄 Periodic Reminder WorkManager started! Task: $task - Time: $now',
    );

    try {
      // Initialize notifications in the background isolate
      await AwesomeNotifications().initialize(
        PeriodicReminderConstants.notificationIcon,
        [createPeriodicReminderChannel()],
      );

      final settingsService = SettingsService();
      final isEnabled = await settingsService.getPeriodicReminderEnabled();
      final intervalMinutes = await settingsService
          .getPeriodicReminderInterval();

      if (!isEnabled) {
        logInfo('🚫 Periodic reminders disabled, cancelling any existing');
        await AwesomeNotifications().cancelSchedule(
          PeriodicReminderConstants.periodicReminderNotificationId,
        );
        return Future.value(true);
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
          color: PeriodicReminderConstants.reminderChannelColor,
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
      return Future.value(true);
    } on Object catch (e, s) {
      logError('❌ Error in Periodic Reminder WorkManager', e, s);
      return Future.value(false);
    }
  });
}
