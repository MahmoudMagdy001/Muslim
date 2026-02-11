import 'package:adhan/adhan.dart';

import '../model/prayer_times_model.dart';

/// Abstract repository for prayer times data operations.
abstract class PrayerTimesRepository {
  /// Fetches today's prayer times.
  Future<LocalPrayerTimes> getPrayerTimes({required bool isArabic});

  /// Fetches prayer times for a specific [date].
  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  });

  /// Returns the cached user coordinates, or null if not cached.
  Future<Coordinates?> getCachedCoordinates();
}
