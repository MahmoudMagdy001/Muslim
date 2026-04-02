import 'package:flutter/material.dart';

/// Centralized notification constants for periodic Islamic reminders.
abstract final class PeriodicReminderConstants {
  // ── Channel ──────────────────────────────────────────────────────────
  static const String reminderChannelKey = 'periodic_islamic_reminder';
  static const String reminderChannelName = 'تذكير إسلامي دوري';
  static const String reminderChannelDescription =
      'إشعارات تذكير إسلامية دورية مع صوت مخصص';
  static const Color reminderChannelColor = Color(0xFF2E7D32);
  static const String reminderSoundSource = 'resource://raw/salah';
  static const String notificationIcon = 'resource://drawable/ic_muslim_logo';

  // ── Notification ID ──────────────────────────────────────────────────
  static const int periodicReminderNotificationId = 888888;

  // ── WorkManager Constants ────────────────────────────────────────────
  static const String workManagerUniqueId = 'periodic_reminder_workmanager';
  static const String workManagerTaskName = 'periodicReminderRescheduleTask';

  // ── Default Settings ─────────────────────────────────────────────────
  static const int defaultIntervalMinutes = 15;
  static const bool defaultEnabled = false;

  // ── Available Intervals ──────────────────────────────────────────────
  static const List<int> availableIntervals = [5, 10, 15, 30];

  // ── Islamic Reminder Messages ───────────────────────────────────────
  static const List<Map<String, String>> reminderMessages = [
    {'title': 'سبحان الله', 'body': 'قُلْ سُبْحَانَ اللَّهِ وَبِحَمْدِهِ'},
    {'title': 'الحمد لله', 'body': 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ'},
    {'title': 'الله أكبر', 'body': 'اللَّهُ أَكْبَرُ كَبِيرًا'},
    {'title': 'أستغفر الله', 'body': 'أَسْتَغْفِرُ اللَّهَ العَظِيمَ'},
    {
      'title': 'لا إله إلا الله',
      'body': 'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
    },
    {
      'title': 'الصلاة على النبي',
      'body': 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ',
    },
    {
      'title': 'ذكر الله',
      'body': 'وَاذْكُرُوا اللَّهَ كَثِيرًا لَّعَلَّكُمْ تُفْلِحُونَ',
    },
    {'title': 'الدعاء', 'body': 'ادْعُوا رَبَّكُمْ تَضَرُّعًا وَخُفْيَةً'},
  ];
}
