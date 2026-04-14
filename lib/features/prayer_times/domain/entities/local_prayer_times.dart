import 'package:equatable/equatable.dart';

import 'prayer_type.dart';

/// Local prayer times for a single day.
///
/// Times are stored as 24-hour formatted strings (e.g. '05:23') for display,
/// and as DateTime objects (e.g. DateTime(2026, 4, 10, 5, 23)) for accurate
/// timezone-aware scheduling.
class LocalPrayerTimes extends Equatable {
  const LocalPrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.city,
    required this.date,
    this.fajrDateTime,
    this.sunriseDateTime,
    this.dhuhrDateTime,
    this.asrDateTime,
    this.maghribDateTime,
    this.ishaDateTime,
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String city;
  final DateTime date;

  // DateTime objects for accurate timezone-aware scheduling
  final DateTime? fajrDateTime;
  final DateTime? sunriseDateTime;
  final DateTime? dhuhrDateTime;
  final DateTime? asrDateTime;
  final DateTime? maghribDateTime;
  final DateTime? ishaDateTime;

  /// Get the time string for a specific [PrayerType].
  String timeForPrayer(PrayerType type) => switch (type) {
    PrayerType.fajr => fajr,
    PrayerType.sunrise => sunrise,
    PrayerType.dhuhr => dhuhr,
    PrayerType.asr => asr,
    PrayerType.maghrib => maghrib,
    PrayerType.isha => isha,
    PrayerType.jumuah => dhuhr, // Jumuah uses Dhuhr time
  };

  /// Get the DateTime for a specific [PrayerType] (for accurate scheduling).
  /// Returns null if not available (fallback to parsing from string).
  DateTime? dateTimeForPrayer(PrayerType type) => switch (type) {
    PrayerType.fajr => fajrDateTime,
    PrayerType.sunrise => sunriseDateTime,
    PrayerType.dhuhr => dhuhrDateTime,
    PrayerType.asr => asrDateTime,
    PrayerType.maghrib => maghribDateTime,
    PrayerType.isha => ishaDateTime,
    PrayerType.jumuah => dhuhrDateTime, // Jumuah uses Dhuhr time
  };

  @override
  List<Object?> get props => [
    fajr,
    sunrise,
    dhuhr,
    asr,
    maghrib,
    isha,
    city,
    date,
    fajrDateTime,
    sunriseDateTime,
    dhuhrDateTime,
    asrDateTime,
    maghribDateTime,
    ishaDateTime,
  ];
}
