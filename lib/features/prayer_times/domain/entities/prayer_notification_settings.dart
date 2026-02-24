import 'package:equatable/equatable.dart';

import 'prayer_type.dart';

/// Per-prayer notification enable/disable settings.
///
/// Each of the five daily prayers has its own toggle, allowing
/// the user to selectively enable or disable notifications.
class PrayerNotificationSettings extends Equatable {
  const PrayerNotificationSettings({
    this.fajrEnabled = true,
    this.dhuhrEnabled = true,
    this.asrEnabled = true,
    this.maghribEnabled = true,
    this.ishaEnabled = true,
    this.jumuahEnabled = true,
  });

  final bool fajrEnabled;
  final bool dhuhrEnabled;
  final bool asrEnabled;
  final bool maghribEnabled;
  final bool ishaEnabled;
  final bool jumuahEnabled;

  /// Check whether notifications are enabled for the given [type].
  bool isEnabled(PrayerType type) => switch (type) {
    PrayerType.fajr => fajrEnabled,
    PrayerType.sunrise => false, // Sunrise has no azan
    PrayerType.dhuhr => dhuhrEnabled,
    PrayerType.asr => asrEnabled,
    PrayerType.maghrib => maghribEnabled,
    PrayerType.isha => ishaEnabled,
    PrayerType.jumuah => jumuahEnabled,
  };

  /// Returns a copy with the [enabled] flag set for [type].
  PrayerNotificationSettings copyWithPrayer(
    PrayerType type, {
    required bool enabled,
  }) => switch (type) {
    PrayerType.fajr => copyWith(fajrEnabled: enabled),
    PrayerType.sunrise => this, // Sunrise has no azan — no-op
    PrayerType.dhuhr => copyWith(dhuhrEnabled: enabled),
    PrayerType.asr => copyWith(asrEnabled: enabled),
    PrayerType.maghrib => copyWith(maghribEnabled: enabled),
    PrayerType.isha => copyWith(ishaEnabled: enabled),
    PrayerType.jumuah => copyWith(jumuahEnabled: enabled),
  };

  PrayerNotificationSettings copyWith({
    bool? fajrEnabled,
    bool? dhuhrEnabled,
    bool? asrEnabled,
    bool? maghribEnabled,
    bool? ishaEnabled,
    bool? jumuahEnabled,
  }) => PrayerNotificationSettings(
    fajrEnabled: fajrEnabled ?? this.fajrEnabled,
    dhuhrEnabled: dhuhrEnabled ?? this.dhuhrEnabled,
    asrEnabled: asrEnabled ?? this.asrEnabled,
    maghribEnabled: maghribEnabled ?? this.maghribEnabled,
    ishaEnabled: ishaEnabled ?? this.ishaEnabled,
    jumuahEnabled: jumuahEnabled ?? this.jumuahEnabled,
  );

  @override
  List<Object?> get props => [
    fajrEnabled,
    dhuhrEnabled,
    asrEnabled,
    maghribEnabled,
    ishaEnabled,
    jumuahEnabled,
  ];
}
