// prayer_times_repository_impl.dart
import '../model/prayer_times_model.dart';
import '../service/prayer_times_service.dart';

import 'prayer_times_repository.dart';

class PrayerTimesNewRepositoryImpl implements PrayerTimesRepository {
  PrayerTimesNewRepositoryImpl(this.service);
  final PrayerTimesService service;

  @override
  Future<LocalPrayerTimes> getPrayerTimes() => service.getPrayerTimes();
}
