import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_audio_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_audio_data_source_impl.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_local_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_remote_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_local_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_remote_data_source.dart';
import 'package:muslim/features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_notification_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/qiblah/data/datasources/qiblah_local_data_source.dart';
import 'package:muslim/features/quran/service/bookmarks_service.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/sebha/data/datasources/sebha_local_data_source.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:muslim/features/surahs_list/service/search_service.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';

void registerDataSources(GetIt getIt) {
  getIt
    // ── Core Services ──────────────────────────────────────────────────
    ..registerLazySingleton<http.Client>(http.Client.new)
    ..registerLazySingleton<SettingsService>(SettingsService.new)
    ..registerLazySingleton<AudioPlayer>(AudioPlayer.new)
    ..registerLazySingleton<QuranService>(
      () => QuranService(getIt<AudioPlayer>()),
    )
    ..registerLazySingleton<BookmarksService>(BookmarksService.new)
    ..registerLazySingleton<QuranSearchService>(QuranSearchService.new)
    ..registerLazySingleton<LocationService>(LocationService.new)
    // ── Data Sources ───────────────────────────────────────────────────
    ..registerLazySingleton<HadithLocalDataSource>(
      () => const HadithLocalDataSourceImpl(),
    )
    ..registerLazySingleton<HadithRemoteDataSource>(
      () => HadithRemoteDataSourceImpl(client: getIt<http.Client>()),
    )
    ..registerLazySingleton<AzkarLocalDataSource>(
      AzkarLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<AzkarRemoteDataSource>(
      AzkarRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<AzkarAudioDataSource>(
      () => AzkarAudioDataSourceImpl(getIt<AudioPlayer>()),
    )
    ..registerLazySingleton<SebhaLocalDataSource>(
      SebhaLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<ZakatRemoteDataSource>(
      () => ZakatRemoteDataSourceImpl(client: getIt<http.Client>()),
    )
    ..registerLazySingleton<QiblahLocalDataSource>(
      QiblahLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<NamesOfAllahLocalDataSource>(
      () => const NamesOfAllahLocalDataSourceImpl(),
    )
    // ── Prayer Times Services ──────────────────────────────────────────
    ..registerLazySingleton<PrayerTimesLocalDataSource>(
      PrayerTimesLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<PrayerNotificationLocalDataSource>(
      PrayerNotificationLocalDataSourceImpl.new,
    );
}
