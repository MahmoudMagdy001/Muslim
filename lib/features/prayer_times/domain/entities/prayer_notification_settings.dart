import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';

part 'prayer_notification_settings.freezed.dart';

@freezed
abstract class PrayerNotificationSettings with _$PrayerNotificationSettings {
  const PrayerNotificationSettings._();

  const factory PrayerNotificationSettings({
    @Default(true) bool fajrEnabled,
    @Default(true) bool dhuhrEnabled,
    @Default(true) bool asrEnabled,
    @Default(true) bool maghribEnabled,
    @Default(true) bool ishaEnabled,
    @Default(true) bool jumuahEnabled,
  }) = _PrayerNotificationSettings;

  bool isEnabled(PrayerType type) => switch (type) {
    PrayerType.fajr => fajrEnabled,
    PrayerType.sunrise => false,
    PrayerType.dhuhr => dhuhrEnabled,
    PrayerType.asr => asrEnabled,
    PrayerType.maghrib => maghribEnabled,
    PrayerType.isha => ishaEnabled,
    PrayerType.jumuah => jumuahEnabled,
  };

  PrayerNotificationSettings copyWithPrayer(
    PrayerType type, {
    required bool enabled,
  }) => switch (type) {
    PrayerType.fajr => copyWith(fajrEnabled: enabled),
    PrayerType.sunrise => this,
    PrayerType.dhuhr => copyWith(dhuhrEnabled: enabled),
    PrayerType.asr => copyWith(asrEnabled: enabled),
    PrayerType.maghrib => copyWith(maghribEnabled: enabled),
    PrayerType.isha => copyWith(ishaEnabled: enabled),
    PrayerType.jumuah => copyWith(jumuahEnabled: enabled),
  };
}
