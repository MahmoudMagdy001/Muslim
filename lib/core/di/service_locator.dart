import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import '../../core/service/location_service.dart';
import '../../features/azkar/data/datasources/azkar_audio_data_source.dart';
import '../../features/azkar/data/datasources/azkar_audio_data_source_impl.dart';
import '../../features/azkar/data/datasources/azkar_local_data_source.dart';
import '../../features/azkar/data/datasources/azkar_remote_data_source.dart';
import '../../features/azkar/data/repositories/azkar_repository_impl.dart';
import '../../features/azkar/domain/repositories/azkar_repository.dart';
import '../../features/azkar/domain/usecases/clear_azkar_count_usecase.dart';
import '../../features/azkar/domain/usecases/get_azkar_audio_stream_usecase.dart';
import '../../features/azkar/domain/usecases/get_azkar_content_usecase.dart';
import '../../features/azkar/domain/usecases/get_azkar_count_usecase.dart';
import '../../features/azkar/domain/usecases/get_azkar_list_usecase.dart';
import '../../features/azkar/domain/usecases/get_current_audio_state_usecase.dart';
import '../../features/azkar/domain/usecases/play_azkar_audio_usecase.dart';
import '../../features/azkar/domain/usecases/save_azkar_count_usecase.dart';
import '../../features/azkar/domain/usecases/stop_azkar_audio_usecase.dart';
import '../../features/azkar/presentation/cubit/azkar_audio_cubit.dart';
import '../../features/azkar/presentation/cubit/azkar_cubit.dart';
import '../../features/hadith/data/datasources/hadith_local_data_source.dart';
import '../../features/hadith/data/datasources/hadith_remote_data_source.dart';
import '../../features/hadith/data/repositories/hadith_repository_impl.dart';
import '../../features/hadith/domain/repositories/hadith_repository.dart';
import '../../features/hadith/domain/usecases/get_chapters_of_book_use_case.dart';
import '../../features/hadith/domain/usecases/get_hadith_books_use_case.dart';
import '../../features/hadith/domain/usecases/get_hadiths_of_chapter_use_case.dart';
import '../../features/hadith/domain/usecases/get_random_hadith_use_case.dart';
import '../../features/hadith/domain/usecases/get_saved_hadiths_use_case.dart';
import '../../features/hadith/domain/usecases/toggle_save_hadith_use_case.dart';
import '../../features/hadith/presentation/cubit/chapter_of_book_cubit.dart';
import '../../features/hadith/presentation/cubit/hadith_books_cubit.dart';
import '../../features/hadith/presentation/cubit/hadith_cubit.dart';
import '../../features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import '../../features/names_of_allah/data/repositories/names_of_allah_repository_impl.dart';
import '../../features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import '../../features/names_of_allah/domain/usecases/get_names_of_allah_use_case.dart';
import '../../features/names_of_allah/presentation/cubit/names_of_allah_cubit.dart';
import '../../features/prayer_times/repositories/prayer_notification_repository.dart';
import '../../features/prayer_times/repositories/prayer_notification_repository_impl.dart';
import '../../features/prayer_times/repositories/prayer_times_repository.dart';
import '../../features/prayer_times/repositories/prayer_times_repository_impl.dart';
import '../../features/prayer_times/services/prayer_calculator_service.dart';
import '../../features/prayer_times/services/prayer_notification_canceler.dart';
import '../../features/prayer_times/services/prayer_notification_scheduler.dart';
import '../../features/prayer_times/services/prayer_times_service.dart';
import '../../features/qiblah/data/datasources/qiblah_local_data_source.dart';
import '../../features/qiblah/data/repositories/qiblah_repository_impl.dart';
import '../../features/qiblah/domain/repositories/qiblah_repository.dart';
import '../../features/qiblah/domain/usecases/get_qiblah_stream_usecase.dart';
import '../../features/qiblah/presentation/cubit/qiblah_cubit.dart';
import '../../features/quran/repository/quran_repository.dart';
import '../../features/quran/repository/quran_repository_impl.dart';
import '../../features/quran/repository/tafsir_repository.dart';
import '../../features/quran/service/bookmarks_service.dart';
import '../../features/quran/service/quran_service.dart';
import '../../features/sebha/data/datasources/sebha_local_data_source.dart';
import '../../features/sebha/data/repositories/sebha_repository_impl.dart';
import '../../features/sebha/domain/repositories/sebha_repository.dart';
import '../../features/sebha/domain/usecases/delete_custom_zikr_use_case.dart';
import '../../features/sebha/domain/usecases/get_custom_azkar_use_case.dart';
import '../../features/sebha/domain/usecases/save_custom_zikr_use_case.dart';
import '../../features/sebha/domain/usecases/update_custom_zikr_use_case.dart';
import '../../features/sebha/presentation/cubit/sebha_cubit.dart';
import '../../features/settings/service/settings_service.dart';
import '../../features/surahs_list/repository/surahs_list_repository.dart';
import '../../features/surahs_list/repository/surahs_list_repository_impl.dart';
import '../../features/surahs_list/service/search_service.dart';
import '../../features/zakat/data/datasources/zakat_remote_data_source.dart';
import '../../features/zakat/data/repositories/zakat_repository_impl.dart';
import '../../features/zakat/domain/repositories/zakat_repository.dart';
import '../../features/zakat/domain/usecases/get_gold_price_use_case.dart';
import '../../features/zakat/presentation/cubit/zakat_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ── Core Services ──────────────────────────────────────────────────

  getIt
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton<SettingsService>(() => SettingsService())
    ..registerLazySingleton<AudioPlayer>(() => AudioPlayer())
    ..registerLazySingleton<QuranService>(
      () => QuranService(getIt<AudioPlayer>()),
    )
    ..registerLazySingleton<BookmarksService>(() => BookmarksService())
    ..registerLazySingleton<QuranSearchService>(() => QuranSearchService())
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
    ..registerLazySingleton<LocationService>(() => LocationService())
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
    )
    // ── UseCases ───────────────────────────────────────────────────────
    ..registerLazySingleton<GetAzkarListUseCase>(
      () => GetAzkarListUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<GetAzkarContentUseCase>(
      () => GetAzkarContentUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<SaveAzkarCountUseCase>(
      () => SaveAzkarCountUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<GetAzkarCountUseCase>(
      () => GetAzkarCountUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<ClearAzkarCountUseCase>(
      () => ClearAzkarCountUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<PlayAzkarAudioUseCase>(
      () => PlayAzkarAudioUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<StopAzkarAudioUseCase>(
      () => StopAzkarAudioUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<GetAzkarAudioStreamUseCase>(
      () => GetAzkarAudioStreamUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<GetCurrentAudioStateUseCase>(
      () => GetCurrentAudioStateUseCase(getIt<AzkarRepository>()),
    )
    ..registerLazySingleton<GetHadithBooksUseCase>(
      () => GetHadithBooksUseCase(getIt<HadithRepository>()),
    )
    ..registerLazySingleton<GetChaptersOfBookUseCase>(
      () => GetChaptersOfBookUseCase(getIt<HadithRepository>()),
    )
    ..registerLazySingleton<GetHadithsOfChapterUseCase>(
      () => GetHadithsOfChapterUseCase(getIt<HadithRepository>()),
    )
    ..registerLazySingleton<GetRandomHadithUseCase>(
      () => GetRandomHadithUseCase(getIt<HadithRepository>()),
    )
    ..registerLazySingleton<GetSavedHadithsUseCase>(
      () => GetSavedHadithsUseCase(getIt<HadithRepository>()),
    )
    ..registerLazySingleton<ToggleSaveHadithUseCase>(
      () => ToggleSaveHadithUseCase(getIt<HadithRepository>()),
    )
    ..registerLazySingleton<GetCustomAzkarUseCase>(
      () => GetCustomAzkarUseCase(getIt<SebhaRepository>()),
    )
    ..registerLazySingleton<SaveCustomZikrUseCase>(
      () => SaveCustomZikrUseCase(getIt<SebhaRepository>()),
    )
    ..registerLazySingleton<UpdateCustomZikrUseCase>(
      () => UpdateCustomZikrUseCase(getIt<SebhaRepository>()),
    )
    ..registerLazySingleton<DeleteCustomZikrUseCase>(
      () => DeleteCustomZikrUseCase(getIt<SebhaRepository>()),
    )
    ..registerLazySingleton<GetGoldPriceUseCase>(
      () => GetGoldPriceUseCase(getIt<ZakatRepository>()),
    )
    ..registerLazySingleton<GetQiblahStreamUseCase>(
      () => GetQiblahStreamUseCase(getIt<QiblahRepository>()),
    )
    ..registerLazySingleton<GetNamesOfAllahUseCase>(
      () => GetNamesOfAllahUseCase(getIt<NamesOfAllahRepository>()),
    )
    // ── Cubits ─────────────────────────────────────────────────────────
    ..registerFactory<AzkarCubit>(
      () => AzkarCubit(
        getIt<GetAzkarListUseCase>(),
        getIt<GetAzkarContentUseCase>(),
        getIt<SaveAzkarCountUseCase>(),
        getIt<GetAzkarCountUseCase>(),
        getIt<ClearAzkarCountUseCase>(),
      ),
    )
    ..registerLazySingleton<AzkarAudioCubit>(
      () => AzkarAudioCubit(
        getIt<PlayAzkarAudioUseCase>(),
        getIt<StopAzkarAudioUseCase>(),
        getIt<GetAzkarAudioStreamUseCase>(),
        getIt<GetCurrentAudioStateUseCase>(),
      ),
    )
    ..registerFactory<HadithBooksCubit>(
      () => HadithBooksCubit(
        getHadithBooksUseCase: getIt<GetHadithBooksUseCase>(),
        getRandomHadithUseCase: getIt<GetRandomHadithUseCase>(),
      ),
    )
    ..registerFactory<ChapterOfBookCubit>(
      () => ChapterOfBookCubit(getIt<GetChaptersOfBookUseCase>()),
    )
    ..registerFactory<HadithCubit>(
      () => HadithCubit(
        getHadithsOfChapterUseCase: getIt<GetHadithsOfChapterUseCase>(),
        getSavedHadithsUseCase: getIt<GetSavedHadithsUseCase>(),
        toggleSaveHadithUseCase: getIt<ToggleSaveHadithUseCase>(),
      ),
    )
    ..registerFactory<SebhaCubit>(
      () => SebhaCubit(
        getCustomAzkarUseCase: getIt<GetCustomAzkarUseCase>(),
        saveCustomZikrUseCase: getIt<SaveCustomZikrUseCase>(),
        updateCustomZikrUseCase: getIt<UpdateCustomZikrUseCase>(),
        deleteCustomZikrUseCase: getIt<DeleteCustomZikrUseCase>(),
      ),
    )
    ..registerFactory<ZakatCubit>(
      () => ZakatCubit(getGoldPriceUseCase: getIt<GetGoldPriceUseCase>()),
    )
    ..registerFactory<QiblahCubit>(
      () => QiblahCubit(
        getQiblahStreamUseCase: getIt<GetQiblahStreamUseCase>(),
        locationService: getIt<LocationService>(),
      ),
    )
    ..registerFactory<NamesOfAllahCubit>(
      () => NamesOfAllahCubit(
        getNamesOfAllahUseCase: getIt<GetNamesOfAllahUseCase>(),
      ),
    );
}
