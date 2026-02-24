import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

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
      final prayerDataSource = PrayerTimesLocalDataSourceImpl();
      final notificationDataSource = PrayerNotificationLocalDataSourceImpl();
      final settingsService = SettingsService();

      // Load per-prayer settings
      final settings = await settingsService.getPrayerNotificationSettings();

      final cachedCoords = await prayerDataSource.getCachedCoordinates();
      if (cachedCoords == null) {
        logWarning('لا توجد إحداثيات محفوظة، لا يمكن جدولة الصلاة');
        return Future.value(false);
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
      return Future.value(true);
    } catch (e, s) {
      logError('خطأ في WorkManager', e, s);
      return Future.value(false);
    }
  });
}
