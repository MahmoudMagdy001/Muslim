import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/core/service/periodic_reminder_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'periodic_reminder_repository.freezed.dart';

/// Repository for managing periodic reminder settings persistence.
class PeriodicReminderRepository {
  static const String _enabledKey = 'periodic_reminder_enabled';
  static const String _intervalKey = 'periodic_reminder_interval_minutes';

  /// Loads the saved enabled state.
  Future<bool> getEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey) ??
        PeriodicReminderConstants.defaultEnabled;
  }

  /// Saves the enabled state.
  Future<void> setEnabled({required bool enabled}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, enabled);
  }

  /// Loads the saved interval in minutes.
  Future<int> getIntervalMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_intervalKey) ??
        PeriodicReminderConstants.defaultIntervalMinutes;
  }

  /// Saves the interval in minutes.
  Future<void> setIntervalMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_intervalKey, minutes);
  }

  /// Loads all settings at once.
  Future<PeriodicReminderSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return PeriodicReminderSettings(
      enabled:
          prefs.getBool(_enabledKey) ??
          PeriodicReminderConstants.defaultEnabled,
      intervalMinutes:
          prefs.getInt(_intervalKey) ??
          PeriodicReminderConstants.defaultIntervalMinutes,
    );
  }

  /// Saves all settings at once.
  Future<void> saveSettings(PeriodicReminderSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, settings.enabled);
    await prefs.setInt(_intervalKey, settings.intervalMinutes);
  }
}

/// Immutable settings class for periodic reminders.
@freezed
abstract class PeriodicReminderSettings with _$PeriodicReminderSettings {
  const factory PeriodicReminderSettings({
    @Default(PeriodicReminderConstants.defaultEnabled) bool enabled,
    @Default(PeriodicReminderConstants.defaultIntervalMinutes) int intervalMinutes,
  }) = _PeriodicReminderSettings;
}
