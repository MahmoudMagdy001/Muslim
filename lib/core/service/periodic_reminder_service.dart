import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:workmanager/workmanager.dart';

import '../../core/utils/app_logger.dart';
import 'periodic_reminder_constants.dart';

/// Service for managing periodic Islamic reminder notifications.
/// Uses native scheduling (NotificationAndroidCrontab) for battery efficiency.
class PeriodicReminderService {
  factory PeriodicReminderService() => _instance;
  PeriodicReminderService._internal();
  static final PeriodicReminderService _instance =
      PeriodicReminderService._internal();

  final Random _random = Random();

  /// Schedules a repeating notification with the specified interval in minutes.
  /// Uses native Android scheduling for battery efficiency.
  /// Also registers WorkManager for background reliability.
  Future<void> scheduleReminder({required int intervalMinutes}) async {
    try {
      // Cancel any existing periodic reminders first
      await cancelReminder();

      final now = DateTime.now();
      final firstNotificationTime = now.add(Duration(minutes: intervalMinutes));

      // Pick a random reminder message
      final message = _getRandomReminderMessage();

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

      // Register WorkManager for background reliability
      await _registerWorkManagerTask();

      logSuccess(
        '✅ Periodic reminder scheduled: every $intervalMinutes minutes starting at ${firstNotificationTime.toString()}',
      );
    } catch (e, stackTrace) {
      logError('❌ Error scheduling periodic reminder', e, stackTrace);
      rethrow;
    }
  }

  /// Registers WorkManager task for background reliability
  Future<void> _registerWorkManagerTask() async {
    try {
      await Workmanager().registerPeriodicTask(
        PeriodicReminderConstants.workManagerUniqueId,
        PeriodicReminderConstants.workManagerTaskName,
        frequency: const Duration(
          minutes: 15,
        ), // Re-schedule check every 15 minutes
        existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      );
      logInfo('🔄 WorkManager task registered for periodic reminders');
    } catch (e) {
      logWarning('⚠️ Could not register WorkManager task: $e');
    }
  }

  /// Cancels the periodic reminder notification and WorkManager task.
  Future<void> cancelReminder() async {
    try {
      // Cancel notification schedule
      await AwesomeNotifications().cancelSchedule(
        PeriodicReminderConstants.periodicReminderNotificationId,
      );
      // Cancel WorkManager task
      await Workmanager().cancelByUniqueName(
        PeriodicReminderConstants.workManagerUniqueId,
      );
      logInfo('🗑️ Periodic reminder and WorkManager task cancelled');
    } catch (e, stackTrace) {
      logError('⚠️ Error cancelling periodic reminder', e, stackTrace);
    }
  }

  /// Reschedules the reminder with a new interval.
  /// Useful when user changes settings.
  Future<void> rescheduleReminder({required int intervalMinutes}) async {
    await scheduleReminder(intervalMinutes: intervalMinutes);
  }

  /// Checks if the periodic reminder is currently scheduled.
  Future<bool> isReminderScheduled() async {
    try {
      final schedules = await AwesomeNotifications()
          .listScheduledNotifications();
      return schedules.any(
        (schedule) =>
            schedule.content?.id ==
            PeriodicReminderConstants.periodicReminderNotificationId,
      );
    } catch (e) {
      logWarning('⚠️ Error checking reminder status: $e');
      return false;
    }
  }

  /// Gets a random reminder message from the predefined list.
  Map<String, String> _getRandomReminderMessage() {
    final index = _random.nextInt(
      PeriodicReminderConstants.reminderMessages.length,
    );
    return PeriodicReminderConstants.reminderMessages[index];
  }

  /// Gets the next scheduled time for the reminder.
  /// Returns null if not scheduled.
  Future<DateTime?> getNextScheduledTime() async {
    try {
      final schedules = await AwesomeNotifications()
          .listScheduledNotifications();
      for (final schedule in schedules) {
        if (schedule.content?.id ==
            PeriodicReminderConstants.periodicReminderNotificationId) {
          // The schedule object doesn't directly expose the next occurrence time
          // but we can infer it from the creation time + interval
          return null; // Not reliably available from the API
        }
      }
      return null;
    } catch (e) {
      logWarning('⚠️ Error getting next scheduled time: $e');
      return null;
    }
  }
}
