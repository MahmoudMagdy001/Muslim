import 'package:get_it/get_it.dart';

import 'package:muslim/features/azkar/data/datasources/azkar_audio_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_local_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_remote_data_source.dart';
import 'package:muslim/features/azkar/data/repositories/azkar_repository_impl.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_local_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_remote_data_source.dart';
import 'package:muslim/features/hadith/data/repositories/hadith_repository_impl.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import 'package:muslim/features/names_of_allah/data/repositories/names_of_allah_repository_impl.dart';
import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_notification_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_notification_repository_impl.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:muslim/features/qiblah/data/datasources/qiblah_local_data_source.dart';
import 'package:muslim/features/qiblah/data/repositories/qiblah_repository_impl.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';
import 'package:muslim/features/quran/repository/quran_repository.dart';
import 'package:muslim/features/quran/repository/quran_repository_impl.dart';
import 'package:muslim/features/quran/repository/tafsir_repository.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/sebha/data/datasources/sebha_local_data_source.dart';
import 'package:muslim/features/sebha/data/repositories/sebha_repository_impl.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository_impl.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';
import 'package:muslim/features/zakat/data/repositories/zakat_repository_impl.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';

void registerRepositories(GetIt getIt) {
  getIt
    ..registerLazySingleton<PrayerTimesRepository>(
      () => PrayerTimesRepositoryImpl(
        dataSource: getIt<PrayerTimesLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<PrayerNotificationRepository>(
      () => PrayerNotificationRepositoryImpl(
        localDataSource: getIt<PrayerNotificationLocalDataSource>(),
        settingsService: getIt<SettingsService>(),
      ),
    )
    ..registerLazySingleton<QuranRepository>(
      () => QuranRepositoryImpl(getIt<QuranService>()),
    )
    ..registerLazySingleton<TafsirRepository>(TafsirRepository.new)
    ..registerLazySingleton<SurahsListRepository>(
      SurahsListRepositoryImpl.new,
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
