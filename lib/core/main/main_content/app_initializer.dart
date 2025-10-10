import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer {
  AppInitializer(this.prefs);

  final SharedPreferences prefs;

  Future<void> initialize() async {
    await _initializeAudioBackground();
    await _initializeNotifications();
    await _requestPermissions();
    await _scheduleHourlyReminder();
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

  Locale getInitialLanguage() {
    final langCode = prefs.getString('appLanguage') ?? 'en';
    return Locale(langCode);
  }

  Future<void> _initializeAudioBackground() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.muslim.audio',
      androidNotificationChannelName: 'تشغيل التلاوة',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'drawable/ic_muslim_logo',
    );
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      // أيقونة التطبيق الافتراضية
      'resource://drawable/ic_muslim_logo', // اللوجو بتاعك
      [
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
      ],
    );
  }

  Future<void> _requestPermissions() async {
    try {
      await _checkLocationPermission();
      await _checkNotificationPermission();
      await checkBatteryOptimization();
    } catch (e) {
      debugPrint('Permission request error: $e');
    }
  }

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> checkBatteryOptimization() async {
    try {
      final isDisabled =
          await DisableBatteryOptimization.isBatteryOptimizationDisabled;

      if (isDisabled == false) {
        // التطبيق Optimized → نفتح إعدادات البطارية
        await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
      } else {
        debugPrint('✅ التطبيق غير محسن (Unrestricted)');
      }
    } catch (e) {
      debugPrint('⚠️ خطأ في التحقق من Battery Optimization: $e');
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
