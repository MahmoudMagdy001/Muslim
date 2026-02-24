import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../features/prayer_times/data/datasources/prayer_work_manager_data_source.dart';
import '../../../features/prayer_times/presentation/helper/notification_channel_factory.dart';
import '../../../features/prayer_times/presentation/helper/notification_constants.dart';
import '../../../features/settings/service/settings_service.dart';
import '../../service/permissions_sevice.dart';
import '../../utils/app_logger.dart';

class AppInitializer {
  AppInitializer(this.prefs);

  final SettingsService _settingsService = SettingsService();

  final SharedPreferences prefs;

  Future<void> initialize() async {
    // Critical initialization
    await requestAllPermissions();

    // Non-critical initialization (Fire and forget, or handle errors silently)
    // executed after the first frame to not block startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeBackgroundTasks();
    });
  }

  Future<void> _initializeBackgroundTasks() async {
    try {
      await Future.wait([
        _initializeNotifications(),
        workManagerNotify(),
        _initializeAudioBackground(),
        _scheduleQuranReminders(),
      ]);
    } catch (e) {
      logError('Background initialization error', e);
    }
  }

  double getInitialFontSize() => prefs.getDouble('fontSize') ?? 18.0;

  ThemeMode getInitialThemeMode() {
    final themeText = prefs.getString('themeMode');
    if (themeText?.contains('dark') ?? false) {
      return ThemeMode.dark;
    } else if (themeText?.contains('light') ?? false) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> workManagerNotify() async {
    logInfo('بدأ جدولة الاشعارات ف الخلفيه');

    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      NotificationConstants.workManagerUniqueId,
      NotificationConstants.workManagerTaskName,
      frequency: NotificationConstants.workManagerFrequency,
      initialDelay: NotificationConstants.workManagerInitialDelay,
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }

  Locale getInitialLanguage() {
    final langCode = prefs.getString('appLanguage') ?? 'ar';
    return Locale(langCode);
  }

  Future<void> _initializeAudioBackground() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.muslim.audio',
      androidNotificationChannelName: 'تشغيل التلاوة',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'drawable/ic_muslim_logo',
      androidShowNotificationBadge: true,
    );
  }

  /// Initializes notification channels using [NotificationChannelFactory]
  /// to avoid duplication with WorkManager.
  Future<void> _initializeNotifications() async {
    await AwesomeNotifications()
        .initialize(NotificationConstants.notificationIcon, [
          NotificationChannel(
            channelKey: 'quran_channel',
            channelName: 'Quran Reminders',
            channelDescription: 'Reminders to read Quran',
            defaultColor: const Color(0xFF33A1E0),
            importance: NotificationImportance.High,
            channelShowBadge: true,
            icon: NotificationConstants.notificationIcon,
          ),
          createPrayerChannel(),
        ]);
  }

  Future<void> _scheduleQuranReminders() async {
    final enabled = await _settingsService.getQuranNotificationsEnabled();
    if (!enabled) {
      logInfo('🚫 الإشعارات معطلة، لن يتم جدولة أي إشعار');
      await AwesomeNotifications().cancelSchedulesByChannelKey('quran_channel');
      return;
    }

    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey('quran_channel');

      final DateTime now = DateTime.now();
      final DateTime firstNotification = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour + 1,
      );

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'quran_channel',
          title: '📖 تذكير بقراءة القرآن',
          body: 'لا تنس وردك من القرآن الكريم 🌿',
        ),
        schedule: NotificationAndroidCrontab.hourly(
          referenceDateTime: firstNotification,
          allowWhileIdle: true,
        ),
      );
    } catch (e) {
      logError('خطأ أثناء جدولة الإشعارات', e);
    }
  }
}
