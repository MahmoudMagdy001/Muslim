import 'package:flutter/material.dart';

/// Centralized notification constants for the prayer_times feature.
///
/// Eliminates hardcoded values scattered across services.
abstract final class NotificationConstants {
  // ── Channel ──────────────────────────────────────────────────────────
  static const String prayerChannelKey = 'prayer_reminder';
  static const String prayerChannelName = 'تذكير الصلاة';
  static const String prayerChannelDescription =
      'إشعارات بمواقيت الصلاة وتشغيل الأذان';
  static const Color prayerChannelColor = Color(0xFF33A1E0);
  static const String prayerSoundSource = 'resource://raw/azan';
  static const String notificationIcon = 'resource://drawable/ic_muslim_logo';

  // ── Update reminder ──────────────────────────────────────────────────
  static const int updateNotificationId = 999999;
  static const int updateDelayDays = 3;
  static const int updateHour = 9;

  // ── WorkManager ──────────────────────────────────────────────────────
  static const String workManagerTaskName = 'update_prayer_times_task';
  static const String workManagerUniqueId = 'updatePrayerTimes';
  static const Duration workManagerFrequency = Duration(hours: 12);
  static const Duration workManagerInitialDelay = Duration(minutes: 15);

  // ── Scheduling ───────────────────────────────────────────────────────
  static const int scheduleDaysAhead = 3;
}
