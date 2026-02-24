import 'package:get_it/get_it.dart';

import '../../features/azkar/data/datasources/azkar_audio_data_source.dart';
import '../../features/azkar/data/datasources/azkar_local_data_source.dart';
import '../../features/azkar/data/datasources/azkar_remote_data_source.dart';
import '../../features/azkar/data/repositories/azkar_repository_impl.dart';
import '../../features/azkar/domain/repositories/azkar_repository.dart';
import '../../features/hadith/data/datasources/hadith_local_data_source.dart';
import '../../features/hadith/data/datasources/hadith_remote_data_source.dart';
import '../../features/hadith/data/repositories/hadith_repository_impl.dart';
import '../../features/hadith/domain/repositories/hadith_repository.dart';
import '../../features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import '../../features/names_of_allah/data/repositories/names_of_allah_repository_impl.dart';
import '../../features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import '../../features/prayer_times/repositories/prayer_notification_repository.dart';
import '../../features/prayer_times/repositories/prayer_notification_repository_impl.dart';
import '../../features/prayer_times/repositories/prayer_times_repository.dart';
import '../../features/prayer_times/repositories/prayer_times_repository_impl.dart';
import '../../features/prayer_times/services/prayer_notification_canceler.dart';
import '../../features/prayer_times/services/prayer_notification_scheduler.dart';
import '../../features/prayer_times/services/prayer_times_service.dart';
import '../../features/qiblah/data/datasources/qiblah_local_data_source.dart';
import '../../features/qiblah/data/repositories/qiblah_repository_impl.dart';
import '../../features/qiblah/domain/repositories/qiblah_repository.dart';
import '../../features/quran/repository/quran_repository.dart';
import '../../features/quran/repository/quran_repository_impl.dart';
import '../../features/quran/repository/tafsir_repository.dart';
import '../../features/quran/service/quran_service.dart';
import '../../features/sebha/data/datasources/sebha_local_data_source.dart';
import '../../features/sebha/data/repositories/sebha_repository_impl.dart';
import '../../features/sebha/domain/repositories/sebha_repository.dart';
import '../../features/settings/service/settings_service.dart';
import '../../features/surahs_list/repository/surahs_list_repository.dart';
import '../../features/surahs_list/repository/surahs_list_repository_impl.dart';
import '../../features/zakat/data/datasources/zakat_remote_data_source.dart';
import '../../features/zakat/data/repositories/zakat_repository_impl.dart';
import '../../features/zakat/domain/repositories/zakat_repository.dart';

void registerRepositories(GetIt getIt) {
  getIt
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
    ..registerLazySingleton<QuranRepository>(
      () => QuranRepositoryImpl(getIt<QuranService>()),
    )
    ..registerLazySingleton<TafsirRepository>(() => TafsirRepository())
    ..registerLazySingleton<SurahsListRepository>(
      () => SurahsListRepositoryImpl(),
    )
    ..registerLazySingleton<AzkarRepository>(
      () => AzkarRepositoryImpl(
        getIt<AzkarRemoteDataSource>(),
        getIt<AzkarLocalDataSource>(),
        getIt<AzkarAudioDataSource>(),
      ),
    )
    ..registerLazySingleton<HadithRepository>(
      () => HadithRepositoryImpl(
        remoteDataSource: getIt<HadithRemoteDataSource>(),
        localDataSource: getIt<HadithLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<SebhaRepository>(
      () => SebhaRepositoryImpl(localDataSource: getIt<SebhaLocalDataSource>()),
    )
    ..registerLazySingleton<ZakatRepository>(
      () =>
          ZakatRepositoryImpl(remoteDataSource: getIt<ZakatRemoteDataSource>()),
    )
    ..registerLazySingleton<QiblahRepository>(
      () =>
          QiblahRepositoryImpl(localDataSource: getIt<QiblahLocalDataSource>()),
    )
    ..registerLazySingleton<NamesOfAllahRepository>(
      () => NamesOfAllahRepositoryImpl(
        localDataSource: getIt<NamesOfAllahLocalDataSource>(),
      ),
    );
}
