import 'package:get_it/get_it.dart';

import '../../features/azkar/repositories/azkar_repository.dart';
import '../../features/azkar/services/azkar_audio_service.dart';
import '../../features/azkar/services/azkar_persistence_service.dart';
import '../../features/azkar/services/azkar_service.dart';
import '../../features/azkar/viewmodels/azkar_cubit.dart';
import '../../features/hadith/service/hadith/hadith_service.dart';
import '../../features/hadith/service/hadith/hadith_storage_service.dart';
import '../../features/prayer_times/repositories/prayer_notification_repository.dart';
import '../../features/prayer_times/repositories/prayer_notification_repository_impl.dart';
import '../../features/prayer_times/repositories/prayer_times_repository.dart';
import '../../features/prayer_times/repositories/prayer_times_repository_impl.dart';
import '../../features/prayer_times/services/prayer_calculator_service.dart';
import '../../features/prayer_times/services/prayer_notification_canceler.dart';
import '../../features/prayer_times/services/prayer_notification_scheduler.dart';
import '../../features/prayer_times/services/prayer_times_service.dart';
import '../../features/quran/repository/quran_repository_impl.dart';
import '../../features/quran/repository/tafsir_repository.dart';
import '../../features/quran/service/bookmarks_service.dart';
import '../../features/quran/service/quran_service.dart';
import '../../features/settings/service/settings_service.dart';
import '../../features/surahs_list/repository/surahs_list_repository.dart';
import '../../features/surahs_list/repository/surahs_list_repository_impl.dart';
import '../../features/surahs_list/service/search_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ── Core Services ──────────────────────────────────────────────────
  getIt
    ..registerLazySingleton<SettingsService>(() => SettingsService())
    ..registerLazySingleton<QuranService>(() => QuranService())
    ..registerLazySingleton<BookmarksService>(() => BookmarksService())
    ..registerLazySingleton<QuranSearchService>(() => QuranSearchService())
    ..registerLazySingleton<HadithService>(() => HadithService())
    ..registerLazySingleton<HadithStorageService>(() => HadithStorageService())
    ..registerLazySingleton<AzkarService>(() => AzkarService())
    ..registerLazySingleton<AzkarAudioService>(() => AzkarAudioService())
    ..registerLazySingleton<AzkarPersistenceService>(
      () => AzkarPersistenceService(),
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
    )
    // ── Repositories ───────────────────────────────────────────────────
    ..registerLazySingleton<PrayerTimesRepository>(
      () => PrayerTimesRepositoryImpl(service: getIt<PrayerTimesService>()),
    )
    ..registerLazySingleton<PrayerNotificationRepository>(
      () => PrayerNotificationRepositoryImpl(
        scheduler: getIt<PrayerNotificationScheduler>(),
        canceler: getIt<PrayerNotificationCanceler>(),
        settingsService: getIt<SettingsService>(),
      ),
    )
    ..registerLazySingleton<QuranRepositoryImpl>(() => QuranRepositoryImpl())
    ..registerLazySingleton<TafsirRepository>(() => TafsirRepository())
    ..registerLazySingleton<SurahsListRepository>(
      () => SurahsListRepositoryImpl(),
    )
    ..registerLazySingleton<AzkarRepository>(
      () => AzkarRepositoryImpl(getIt<AzkarService>()),
    )
    ..registerFactory<AzkarCubit>(
      () => AzkarCubit(
        getIt<AzkarRepository>(),
        getIt<AzkarPersistenceService>(),
      ),
    );
}
