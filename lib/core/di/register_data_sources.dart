import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import '../../core/service/location_service.dart';
import '../../features/azkar/data/datasources/azkar_audio_data_source.dart';
import '../../features/azkar/data/datasources/azkar_audio_data_source_impl.dart';
import '../../features/azkar/data/datasources/azkar_local_data_source.dart';
import '../../features/azkar/data/datasources/azkar_remote_data_source.dart';
import '../../features/hadith/data/datasources/hadith_local_data_source.dart';
import '../../features/hadith/data/datasources/hadith_remote_data_source.dart';
import '../../features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import '../../features/prayer_times/services/prayer_calculator_service.dart';
import '../../features/prayer_times/services/prayer_notification_canceler.dart';
import '../../features/prayer_times/services/prayer_notification_scheduler.dart';
import '../../features/prayer_times/services/prayer_times_service.dart';
import '../../features/qiblah/data/datasources/qiblah_local_data_source.dart';
import '../../features/quran/service/bookmarks_service.dart';
import '../../features/quran/service/quran_service.dart';
import '../../features/sebha/data/datasources/sebha_local_data_source.dart';
import '../../features/settings/service/settings_service.dart';
import '../../features/surahs_list/service/search_service.dart';
import '../../features/zakat/data/datasources/zakat_remote_data_source.dart';

void registerDataSources(GetIt getIt) {
  getIt
    // ── Core Services ──────────────────────────────────────────────────
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton<SettingsService>(() => SettingsService())
    ..registerLazySingleton<AudioPlayer>(() => AudioPlayer())
    ..registerLazySingleton<QuranService>(
      () => QuranService(getIt<AudioPlayer>()),
    )
    ..registerLazySingleton<BookmarksService>(() => BookmarksService())
    ..registerLazySingleton<QuranSearchService>(() => QuranSearchService())
    ..registerLazySingleton<LocationService>(() => LocationService())
    // ── Data Sources ───────────────────────────────────────────────────
    ..registerLazySingleton<HadithLocalDataSource>(
      () => const HadithLocalDataSourceImpl(),
    )
    ..registerLazySingleton<HadithRemoteDataSource>(
      () => HadithRemoteDataSourceImpl(client: getIt<http.Client>()),
    )
    ..registerLazySingleton<AzkarLocalDataSource>(
      () => AzkarLocalDataSourceImpl(),
    )
    ..registerLazySingleton<AzkarRemoteDataSource>(
      () => AzkarRemoteDataSourceImpl(),
    )
    ..registerLazySingleton<AzkarAudioDataSource>(
      () => AzkarAudioDataSourceImpl(getIt<AudioPlayer>()),
    )
    ..registerLazySingleton<SebhaLocalDataSource>(
      () => SebhaLocalDataSourceImpl(),
    )
    ..registerLazySingleton<ZakatRemoteDataSource>(
      () => ZakatRemoteDataSourceImpl(client: getIt<http.Client>()),
    )
    ..registerLazySingleton<QiblahLocalDataSource>(
      () => QiblahLocalDataSourceImpl(),
    )
    ..registerLazySingleton<NamesOfAllahLocalDataSource>(
      () => const NamesOfAllahLocalDataSourceImpl(),
    )
    // ── Prayer Times Services ──────────────────────────────────────────
    ..registerLazySingleton<PrayerTimesService>(() => PrayerTimesService())
    ..registerLazySingleton<PrayerCalculatorService>(
      () => PrayerCalculatorService(),
    )
    ..registerLazySingleton<PrayerNotificationScheduler>(
      () => PrayerNotificationScheduler(),
    )
    ..registerLazySingleton<PrayerNotificationCanceler>(
      () => PrayerNotificationCanceler(),
    );
}
