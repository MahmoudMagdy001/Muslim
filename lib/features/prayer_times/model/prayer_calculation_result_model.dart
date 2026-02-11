import 'package:equatable/equatable.dart';

import '../models/prayer_type.dart';

/// Result of calculating the next/previous prayer from [LocalPrayerTimes].
class PrayerCalculationResult extends Equatable {
  const PrayerCalculationResult({
    required this.nextPrayer,
    required this.nextPrayerDateTime,
    required this.previousPrayerDateTime,
    required this.timeLeft,
    required this.areAllPrayersFinished,
  });

  final PrayerType nextPrayer;
  final DateTime nextPrayerDateTime;
  final DateTime previousPrayerDateTime;
  final Duration timeLeft;
  final bool areAllPrayersFinished;

  @override
  List<Object?> get props => [
    nextPrayer,
    nextPrayerDateTime,
    previousPrayerDateTime,
    timeLeft,
    areAllPrayersFinished,
  ];
}
