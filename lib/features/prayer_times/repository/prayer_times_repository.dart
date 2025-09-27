// prayer_times_repository.dart

import '../model/prayer_times_model.dart';

abstract class PrayerTimesRepository {
  Future<LocalPrayerTimes> getPrayerTimes();
}
