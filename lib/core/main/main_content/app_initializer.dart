import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/prayer_times/service/prayer_times_service.dart';

/// Application initialization and setup
class AppInitializer {
  AppInitializer(this.prefs);
  final SharedPreferences prefs;

  Future<void> initialize() async {
    await _initializeAudioBackground();
    await _initializeNotifications();
    await _handleFirstRunSetup();
    final prayerService = PrayerTimesService();
    await prayerService.schedulePrayerNotifications();
  }

  Future<void> _initializeAudioBackground() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.muslim.audio',
      androidNotificationChannelName: 'تشغيل التلاوة',
      androidNotificationOngoing: true,
    );
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'quran_channel',
        channelName: 'Quran Reminders',
        channelDescription: 'Reminders to read Quran',
        defaultColor: const Color(0xFF33A1E0),
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'prayer_reminder',
        channelName: '⏰ تذكير الصلاة',
        channelDescription: 'إشعارات بمواقيت الصلاة وتشغيل الأذان',
        defaultColor: const Color(0xFF33A1E0),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ]);
  }

  Future<void> _handleFirstRunSetup() async {
    final bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (isFirstRun) {
      await _requestPermissions();
      await _scheduleHourlyReminder();
      await prefs.setBool('isFirstRun', false);
    }
  }

  Future<void> _requestPermissions() async {
    try {
      // Request notification permission
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }

      // Request location permission
      if (await Permission.locationWhenInUse.isDenied) {
        await Permission.locationWhenInUse.request();
      }

      // Android-specific permissions
      if (Platform.isAndroid) {
        await _requestAndroidPermissions();
      }
    } catch (e) {
      debugPrint('Permission request error: $e');
    }
  }

  Future<void> _requestAndroidPermissions() async {
    // Battery optimization
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }
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
