import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../../../core/utils/app_logger.dart';
import '../../settings/service/settings_service.dart';
import '../helper/notification_constants.dart';
import '../model/prayer_times_model.dart';
import 'notification_channel_factory.dart';
import 'prayer_notification_scheduler.dart';
import 'prayer_times_service.dart';

/// WorkManager callback dispatcher for background prayer time updates.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize notifications in the background isolate
    await AwesomeNotifications().initialize(
      NotificationConstants.notificationIcon,
      [createPrayerChannel()],
    );

    final now = DateTime.now();
    logInfo(
      '🕒 Timezone initialized: ${now.timeZoneName}, offset: ${now.timeZoneOffset}',
    );
    logInfo('🎯 WorkManager started! Task: $task - Time: $now');

    try {
      final prayerService = PrayerTimesService();
      final scheduler = PrayerNotificationScheduler();
      final settingsService = SettingsService();

      // Load per-prayer settings
      final settings = await settingsService.getPrayerNotificationSettings();

      final cachedCoords = await prayerService.getCachedCoordinates();
      if (cachedCoords == null) {
        logWarning('لا توجد إحداثيات محفوظة، لا يمكن جدولة الصلاة');
        return Future.value(false);
      }

      final List<LocalPrayerTimes> upcomingDaysTimes = [];

      for (int i = 0; i < NotificationConstants.scheduleDaysAhead; i++) {
        final date = now.add(Duration(days: i));
        final times = await prayerService.getPrayerTimesForDate(
          cachedCoords,
          date,
        );
        upcomingDaysTimes.add(times);
      }

      await scheduler.scheduleAll(upcomingDaysTimes, settings);

      logSuccess(
        'تمت جدولة مواقيت الصلاة لـ ${NotificationConstants.scheduleDaysAhead} أيام بنجاح في الخلفية - ${DateTime.now()}',
      );
      return Future.value(true);
    } catch (e, s) {
      logError('خطأ في WorkManager', e, s);
      return Future.value(false);
    }
  });
}
