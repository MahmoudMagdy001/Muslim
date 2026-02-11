import 'package:equatable/equatable.dart';

import '../models/prayer_type.dart';

/// Local prayer times for a single day.
///
/// Times are stored as 24-hour formatted strings (e.g. '05:23').
class LocalPrayerTimes extends Equatable {
  const LocalPrayerTimes({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.city,
    required this.date,
  });

  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String city;
  final DateTime date;

  /// Get the time string for a specific [PrayerType].
  String timeForPrayer(PrayerType type) => switch (type) {
    PrayerType.fajr => fajr,
    PrayerType.dhuhr => dhuhr,
    PrayerType.asr => asr,
    PrayerType.maghrib => maghrib,
    PrayerType.isha => isha,
  };

  /// Returns a map of prayer type ID → time string.
  ///
  /// Kept for backward compatibility with existing UI code.
  Map<String, String> toMap() => {
    PrayerType.fajr.id: fajr,
    PrayerType.dhuhr.id: dhuhr,
    PrayerType.asr.id: asr,
    PrayerType.maghrib.id: maghrib,
    PrayerType.isha.id: isha,
    'City': city,
    'Date': date.toIso8601String(),
  };

  @override
  List<Object?> get props => [fajr, dhuhr, asr, maghrib, isha, city, date];
}
