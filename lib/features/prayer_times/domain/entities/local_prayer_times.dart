import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';

part 'local_prayer_times.freezed.dart';

@freezed
abstract class LocalPrayerTimes with _$LocalPrayerTimes {
  const LocalPrayerTimes._();

  const factory LocalPrayerTimes({
    required String fajr,
    required String sunrise,
    required String dhuhr,
    required String asr,
    required String maghrib,
    required String isha,
    required String city,
    required DateTime date,
    DateTime? fajrDateTime,
    DateTime? sunriseDateTime,
    DateTime? dhuhrDateTime,
    DateTime? asrDateTime,
    DateTime? maghribDateTime,
    DateTime? ishaDateTime,
  }) = _LocalPrayerTimes;

  String timeForPrayer(PrayerType type) => switch (type) {
    PrayerType.fajr => fajr,
    PrayerType.sunrise => sunrise,
    PrayerType.dhuhr => dhuhr,
    PrayerType.asr => asr,
    PrayerType.maghrib => maghrib,
    PrayerType.isha => isha,
    PrayerType.jumuah => dhuhr,
  };

  DateTime? dateTimeForPrayer(PrayerType type) => switch (type) {
    PrayerType.fajr => fajrDateTime,
    PrayerType.sunrise => sunriseDateTime,
    PrayerType.dhuhr => dhuhrDateTime,
    PrayerType.asr => asrDateTime,
    PrayerType.maghrib => maghribDateTime,
    PrayerType.isha => ishaDateTime,
    PrayerType.jumuah => dhuhrDateTime,
  };
}
