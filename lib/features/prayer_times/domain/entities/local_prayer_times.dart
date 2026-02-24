import 'package:equatable/equatable.dart';

import 'prayer_type.dart';

/// Local prayer times for a single day.
///
/// Times are stored as 24-hour formatted strings (e.g. '05:23').
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
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String city;
  final DateTime date;

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
  ];
}
