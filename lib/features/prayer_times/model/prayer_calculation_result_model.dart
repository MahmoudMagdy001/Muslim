class PrayerCalculationResult {
  PrayerCalculationResult({
    required this.nextPrayer,
    required this.nextPrayerDateTime,
    required this.timeLeft,
    required this.areAllPrayersFinished,
  });
  final String nextPrayer;
  final DateTime nextPrayerDateTime;
  final Duration timeLeft;
  final bool areAllPrayersFinished;
}
