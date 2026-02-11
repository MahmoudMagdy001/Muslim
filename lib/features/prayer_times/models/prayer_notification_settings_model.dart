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
  });

  final bool fajrEnabled;
  final bool dhuhrEnabled;
  final bool asrEnabled;
  final bool maghribEnabled;
  final bool ishaEnabled;

  /// Check whether notifications are enabled for the given [type].
  bool isEnabled(PrayerType type) => switch (type) {
    PrayerType.fajr => fajrEnabled,
    PrayerType.dhuhr => dhuhrEnabled,
    PrayerType.asr => asrEnabled,
    PrayerType.maghrib => maghribEnabled,
    PrayerType.isha => ishaEnabled,
  };

  /// Returns a copy with the [enabled] flag set for [type].
  PrayerNotificationSettings copyWithPrayer(
    PrayerType type, {
    required bool enabled,
  }) => switch (type) {
    PrayerType.fajr => copyWith(fajrEnabled: enabled),
    PrayerType.dhuhr => copyWith(dhuhrEnabled: enabled),
    PrayerType.asr => copyWith(asrEnabled: enabled),
    PrayerType.maghrib => copyWith(maghribEnabled: enabled),
    PrayerType.isha => copyWith(ishaEnabled: enabled),
  };

  PrayerNotificationSettings copyWith({
    bool? fajrEnabled,
    bool? dhuhrEnabled,
    bool? asrEnabled,
    bool? maghribEnabled,
    bool? ishaEnabled,
  }) => PrayerNotificationSettings(
    fajrEnabled: fajrEnabled ?? this.fajrEnabled,
    dhuhrEnabled: dhuhrEnabled ?? this.dhuhrEnabled,
    asrEnabled: asrEnabled ?? this.asrEnabled,
    maghribEnabled: maghribEnabled ?? this.maghribEnabled,
    ishaEnabled: ishaEnabled ?? this.ishaEnabled,
  );

  @override
  List<Object?> get props => [
    fajrEnabled,
    dhuhrEnabled,
    asrEnabled,
    maghribEnabled,
    ishaEnabled,
  ];
}
