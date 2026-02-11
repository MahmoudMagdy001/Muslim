import 'package:shared_preferences/shared_preferences.dart';

import '../../prayer_times/models/prayer_notification_settings_model.dart';
import '../../prayer_times/models/prayer_type.dart';

/// Centralized settings service for app-wide and prayer-specific settings.
///
/// Consolidates the previously duplicated settings logic from
/// [NotificationSettingsManager] and the old [SettingsService].
class SettingsService {
  static const _quranNotificationsKey = 'quran_notifications';
  static const _autoLocationKey = 'auto_location_enabled';

  // Per-prayer notification keys
  static String _prayerEnabledKey(PrayerType type) =>
      'prayer_notification_${type.id}';
  // ── Quran notifications ────────────────────────────────────────────

  Future<void> setQuranNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quranNotificationsKey, enabled);
  }

  Future<bool> getQuranNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_quranNotificationsKey) ?? true;
  }

  // ── Auto location ─────────────────────────────────────────────────

  Future<void> setAutoLocationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoLocationKey, enabled);
  }

  Future<bool> getAutoLocationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoLocationKey) ?? true;
  }

  // ── Per-prayer notification settings ──────────────────────────────

  /// Loads all per-prayer notification settings in a single read.
  Future<PrayerNotificationSettings> getPrayerNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return PrayerNotificationSettings(
      fajrEnabled: prefs.getBool(_prayerEnabledKey(PrayerType.fajr)) ?? true,
      dhuhrEnabled: prefs.getBool(_prayerEnabledKey(PrayerType.dhuhr)) ?? true,
      asrEnabled: prefs.getBool(_prayerEnabledKey(PrayerType.asr)) ?? true,
      maghribEnabled:
          prefs.getBool(_prayerEnabledKey(PrayerType.maghrib)) ?? true,
      ishaEnabled: prefs.getBool(_prayerEnabledKey(PrayerType.isha)) ?? true,
    );
  }

  /// Sets the notification enabled state for a specific prayer.
  Future<void> setPrayerEnabled(
    PrayerType type, {
    required bool enabled,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prayerEnabledKey(type), enabled);
  }

  /// Checks whether notifications are enabled for a specific prayer.
  Future<bool> isPrayerEnabled(PrayerType type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prayerEnabledKey(type)) ?? true;
  }
}
