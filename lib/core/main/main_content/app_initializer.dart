import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../features/prayer_times/service/work_manager_service.dart';
import '../../service/permissions_sevice.dart';

class AppInitializer {
  AppInitializer(this.prefs);

  final SharedPreferences prefs;

  Future<void> initialize() async {
    await requestAllPermissions();
    Future.wait([
      workManagerNotify(),
      _initializeAudioBackground(),
      _initializeNotifications(),
      _scheduleHourlyReminder(),
    ]);
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
    debugPrint('بدأ جدولة الاشعارات ف الخلفيه');

    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      '001',
      updatePrayerTimesTask,
      frequency: const Duration(hours: 12),
      initialDelay: const Duration(minutes: 15),
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

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications()
        .initialize('resource://drawable/ic_muslim_logo', [
          NotificationChannel(
            channelKey: 'quran_channel',
            channelName: 'Quran Reminders',
            channelDescription: 'Reminders to read Quran',
            defaultColor: const Color(0xFF33A1E0),
            importance: NotificationImportance.High,
            channelShowBadge: true,
            icon: 'resource://drawable/ic_muslim_logo',
          ),
          NotificationChannel(
            channelKey: 'prayer_reminder',
            channelName: 'تذكير الصلاة',
            channelDescription: 'إشعارات بمواقيت الصلاة وتشغيل الأذان',
            defaultColor: const Color(0xFF33A1E0),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
            locked: true,
            defaultRingtoneType: DefaultRingtoneType.Notification,
            soundSource: 'resource://raw/azan',
            icon: 'resource://drawable/ic_muslim_logo',
          ),
        ]);
  }

  Future<void> _scheduleHourlyReminder() async {
    try {
      final timeZone = await AwesomeNotifications()
          .getLocalTimeZoneIdentifier();

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'quran_channel',
          title: '📖 تذكير بقراءة القرآن',
          body: 'لا تنس وردك من القرآن الكريم الآن',
          icon: 'resource://drawable/ic_muslim_logo',
        ),
        schedule: NotificationCalendar(
          minute: 0,
          second: 0,
          repeats: true,
          timeZone: timeZone,
        ),
      );
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }
}
