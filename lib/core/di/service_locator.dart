// ponytail: consolidated DI setup into a single clean file without split modules
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_audio_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_audio_data_source_impl.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_local_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_remote_data_source.dart';
import 'package:muslim/features/azkar/data/repositories/azkar_repository_impl.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';
import 'package:muslim/features/azkar/domain/usecases/clear_azkar_count_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/get_azkar_audio_stream_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/get_azkar_content_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/get_azkar_count_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/get_azkar_list_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/get_current_audio_state_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/play_azkar_audio_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/save_azkar_count_usecase.dart';
import 'package:muslim/features/azkar/domain/usecases/stop_azkar_audio_usecase.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_audio_cubit.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_local_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_remote_data_source.dart';
import 'package:muslim/features/hadith/data/repositories/hadith_repository_impl.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/domain/usecases/get_chapters_of_book_use_case.dart';
import 'package:muslim/features/hadith/domain/usecases/get_hadith_books_use_case.dart';
import 'package:muslim/features/hadith/domain/usecases/get_hadiths_of_chapter_use_case.dart';
import 'package:muslim/features/hadith/domain/usecases/get_random_hadith_use_case.dart';
import 'package:muslim/features/hadith/domain/usecases/get_saved_hadiths_use_case.dart';
import 'package:muslim/features/hadith/domain/usecases/toggle_save_hadith_use_case.dart';
import 'package:muslim/features/hadith/presentation/cubit/chapter_of_book_cubit.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_books_cubit.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_cubit.dart';
import 'package:muslim/features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import 'package:muslim/features/names_of_allah/data/repositories/names_of_allah_repository_impl.dart';
import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import 'package:muslim/features/names_of_allah/domain/usecases/get_names_of_allah_use_case.dart';
import 'package:muslim/features/names_of_allah/presentation/cubit/names_of_allah_cubit.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_notification_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_notification_repository_impl.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:muslim/features/prayer_times/domain/usecases/calculate_next_prayer_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/cancel_all_notifications_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/get_cached_coordinates_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/get_notification_settings_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/get_prayer_times_for_date_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/schedule_notifications_usecase.dart';
import 'package:muslim/features/prayer_times/domain/usecases/set_prayer_enabled_usecase.dart';
import 'package:muslim/features/qiblah/data/datasources/qiblah_local_data_source.dart';
import 'package:muslim/features/qiblah/data/repositories/qiblah_repository_impl.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';
import 'package:muslim/features/qiblah/domain/usecases/get_qiblah_stream_usecase.dart';
import 'package:muslim/features/qiblah/presentation/cubit/qiblah_cubit.dart';
import 'package:muslim/features/quran/repository/quran_repository.dart';
import 'package:muslim/features/quran/repository/quran_repository_impl.dart';
import 'package:muslim/features/quran/repository/tafsir_repository.dart';
import 'package:muslim/features/quran/service/bookmarks_service.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/sebha/data/datasources/sebha_local_data_source.dart';
import 'package:muslim/features/sebha/data/repositories/sebha_repository_impl.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:muslim/features/sebha/domain/usecases/delete_custom_zikr_use_case.dart';
import 'package:muslim/features/sebha/domain/usecases/get_custom_azkar_use_case.dart';
import 'package:muslim/features/sebha/domain/usecases/save_custom_zikr_use_case.dart';
import 'package:muslim/features/sebha/domain/usecases/update_custom_zikr_use_case.dart';
import 'package:muslim/features/sebha/presentation/cubit/sebha_cubit.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:muslim/features/settings/view_model/periodic_reminder/periodic_reminder_cubit.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository_impl.dart';
import 'package:muslim/features/surahs_list/service/search_service.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';
import 'package:muslim/features/zakat/data/repositories/zakat_repository_impl.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:muslim/features/zakat/domain/usecases/get_gold_price_use_case.dart';
import 'package:muslim/features/zakat/presentation/cubit/zakat_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services & Data Sources
  getIt
    ..registerLazySingleton<http.Client>(http.Client.new)
    ..registerLazySingleton<SettingsService>(SettingsService.new)
    ..registerLazySingleton<AudioPlayer>(AudioPlayer.new)
    ..registerLazySingleton<QuranService>(() => QuranService(getIt<AudioPlayer>()))
    ..registerLazySingleton<BookmarksService>(BookmarksService.new)
    ..registerLazySingleton<QuranSearchService>(QuranSearchService.new)
    ..registerLazySingleton<LocationService>(LocationService.new)
    ..registerLazySingleton<HadithLocalDataSource>(() => const HadithLocalDataSourceImpl())
    ..registerLazySingleton<HadithRemoteDataSource>(() => HadithRemoteDataSourceImpl(client: getIt<http.Client>()))
    ..registerLazySingleton<AzkarLocalDataSource>(AzkarLocalDataSourceImpl.new)
    ..registerLazySingleton<AzkarRemoteDataSource>(AzkarRemoteDataSourceImpl.new)
    ..registerLazySingleton<AzkarAudioDataSource>(() => AzkarAudioDataSourceImpl(getIt<AudioPlayer>()))
    ..registerLazySingleton<SebhaLocalDataSource>(SebhaLocalDataSourceImpl.new)
    ..registerLazySingleton<ZakatRemoteDataSource>(() => ZakatRemoteDataSourceImpl(client: getIt<http.Client>()))
    ..registerLazySingleton<QiblahLocalDataSource>(QiblahLocalDataSourceImpl.new)
    ..registerLazySingleton<NamesOfAllahLocalDataSource>(NamesOfAllahLocalDataSourceImpl.new)
    ..registerLazySingleton<PrayerTimesLocalDataSource>(PrayerTimesLocalDataSourceImpl.new)
    ..registerLazySingleton<PrayerNotificationLocalDataSource>(PrayerNotificationLocalDataSourceImpl.new)

  // Repositories
    ..registerLazySingleton<PrayerTimesRepository>(() => PrayerTimesRepositoryImpl(dataSource: getIt<PrayerTimesLocalDataSource>()))
    ..registerLazySingleton<PrayerNotificationRepository>(() => PrayerNotificationRepositoryImpl(localDataSource: getIt<PrayerNotificationLocalDataSource>(), settingsService: getIt<SettingsService>()))
    ..registerLazySingleton<QuranRepository>(() => QuranRepositoryImpl(getIt<QuranService>()))
    ..registerLazySingleton<TafsirRepository>(TafsirRepository.new)
    ..registerLazySingleton<SurahsListRepository>(SurahsListRepositoryImpl.new)
    ..registerLazySingleton<AzkarRepository>(() => AzkarRepositoryImpl(getIt<AzkarRemoteDataSource>(), getIt<AzkarLocalDataSource>(), getIt<AzkarAudioDataSource>()))
    ..registerLazySingleton<HadithRepository>(() => HadithRepositoryImpl(remoteDataSource: getIt<HadithRemoteDataSource>(), localDataSource: getIt<HadithLocalDataSource>()))
    ..registerLazySingleton<SebhaRepository>(() => SebhaRepositoryImpl(localDataSource: getIt<SebhaLocalDataSource>()))
    ..registerLazySingleton<ZakatRepository>(() => ZakatRepositoryImpl(remoteDataSource: getIt<ZakatRemoteDataSource>()))
    ..registerLazySingleton<QiblahRepository>(() => QiblahRepositoryImpl(localDataSource: getIt<QiblahLocalDataSource>()))
    ..registerLazySingleton<NamesOfAllahRepository>(() => NamesOfAllahRepositoryImpl(localDataSource: getIt<NamesOfAllahLocalDataSource>()))

  // Use Cases
    ..registerLazySingleton<GetAzkarListUseCase>(() => GetAzkarListUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<GetAzkarContentUseCase>(() => GetAzkarContentUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<SaveAzkarCountUseCase>(() => SaveAzkarCountUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<GetAzkarCountUseCase>(() => GetAzkarCountUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<ClearAzkarCountUseCase>(() => ClearAzkarCountUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<PlayAzkarAudioUseCase>(() => PlayAzkarAudioUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<StopAzkarAudioUseCase>(() => StopAzkarAudioUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<GetAzkarAudioStreamUseCase>(() => GetAzkarAudioStreamUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<GetCurrentAudioStateUseCase>(() => GetCurrentAudioStateUseCase(getIt<AzkarRepository>()))
    ..registerLazySingleton<GetHadithBooksUseCase>(() => GetHadithBooksUseCase(getIt<HadithRepository>()))
    ..registerLazySingleton<GetChaptersOfBookUseCase>(() => GetChaptersOfBookUseCase(getIt<HadithRepository>()))
    ..registerLazySingleton<GetHadithsOfChapterUseCase>(() => GetHadithsOfChapterUseCase(getIt<HadithRepository>()))
    ..registerLazySingleton<GetRandomHadithUseCase>(() => GetRandomHadithUseCase(getIt<HadithRepository>()))
    ..registerLazySingleton<GetSavedHadithsUseCase>(() => GetSavedHadithsUseCase(getIt<HadithRepository>()))
    ..registerLazySingleton<ToggleSaveHadithUseCase>(() => ToggleSaveHadithUseCase(getIt<HadithRepository>()))
    ..registerLazySingleton<GetCustomAzkarUseCase>(() => GetCustomAzkarUseCase(getIt<SebhaRepository>()))
    ..registerLazySingleton<SaveCustomZikrUseCase>(() => SaveCustomZikrUseCase(getIt<SebhaRepository>()))
    ..registerLazySingleton<UpdateCustomZikrUseCase>(() => UpdateCustomZikrUseCase(getIt<SebhaRepository>()))
    ..registerLazySingleton<DeleteCustomZikrUseCase>(() => DeleteCustomZikrUseCase(getIt<SebhaRepository>()))
    ..registerLazySingleton<GetGoldPriceUseCase>(() => GetGoldPriceUseCase(getIt<ZakatRepository>()))
    ..registerLazySingleton<GetQiblahStreamUseCase>(() => GetQiblahStreamUseCase(getIt<QiblahRepository>()))
    ..registerLazySingleton<GetNamesOfAllahUseCase>(() => GetNamesOfAllahUseCase(getIt<NamesOfAllahRepository>()))
    ..registerLazySingleton<GetPrayerTimesUseCase>(() => GetPrayerTimesUseCase(getIt<PrayerTimesRepository>()))
    ..registerLazySingleton<GetPrayerTimesForDateUseCase>(() => GetPrayerTimesForDateUseCase(getIt<PrayerTimesRepository>()))
    ..registerLazySingleton<GetCachedCoordinatesUseCase>(() => GetCachedCoordinatesUseCase(getIt<PrayerTimesRepository>()))
    ..registerLazySingleton<CalculateNextPrayerUseCase>(CalculateNextPrayerUseCase.new)
    ..registerLazySingleton<ScheduleNotificationsUseCase>(() => ScheduleNotificationsUseCase(getIt<PrayerNotificationRepository>()))
    ..registerLazySingleton<CancelAllNotificationsUseCase>(() => CancelAllNotificationsUseCase(getIt<PrayerNotificationRepository>()))
    ..registerLazySingleton<GetNotificationSettingsUseCase>(() => GetNotificationSettingsUseCase(getIt<PrayerNotificationRepository>()))
    ..registerLazySingleton<SetPrayerEnabledUseCase>(() => SetPrayerEnabledUseCase(getIt<PrayerNotificationRepository>()))

  // Cubits
    ..registerFactory<AzkarCubit>(() => AzkarCubit(getIt<GetAzkarListUseCase>(), getIt<GetAzkarContentUseCase>(), getIt<SaveAzkarCountUseCase>(), getIt<GetAzkarCountUseCase>(), getIt<ClearAzkarCountUseCase>()))
    ..registerLazySingleton<AzkarAudioCubit>(() => AzkarAudioCubit(getIt<PlayAzkarAudioUseCase>(), getIt<StopAzkarAudioUseCase>(), getIt<GetAzkarAudioStreamUseCase>(), getIt<GetCurrentAudioStateUseCase>()))
    ..registerFactory<HadithBooksCubit>(() => HadithBooksCubit(getHadithBooksUseCase: getIt<GetHadithBooksUseCase>(), getRandomHadithUseCase: getIt<GetRandomHadithUseCase>()))
    ..registerFactory<ChapterOfBookCubit>(() => ChapterOfBookCubit(getIt<GetChaptersOfBookUseCase>()))
    ..registerFactory<HadithCubit>(() => HadithCubit(getHadithsOfChapterUseCase: getIt<GetHadithsOfChapterUseCase>(), getSavedHadithsUseCase: getIt<GetSavedHadithsUseCase>(), toggleSaveHadithUseCase: getIt<ToggleSaveHadithUseCase>()))
    ..registerFactory<SebhaCubit>(() => SebhaCubit(getCustomAzkarUseCase: getIt<GetCustomAzkarUseCase>(), saveCustomZikrUseCase: getIt<SaveCustomZikrUseCase>(), updateCustomZikrUseCase: getIt<UpdateCustomZikrUseCase>(), deleteCustomZikrUseCase: getIt<DeleteCustomZikrUseCase>()))
    ..registerFactory<ZakatCubit>(() => ZakatCubit(getGoldPriceUseCase: getIt<GetGoldPriceUseCase>()))
    ..registerFactory<QiblahCubit>(() => QiblahCubit(getQiblahStreamUseCase: getIt<GetQiblahStreamUseCase>(), locationService: getIt<LocationService>()))
    ..registerFactory<NamesOfAllahCubit>(() => NamesOfAllahCubit(getNamesOfAllahUseCase: getIt<GetNamesOfAllahUseCase>()))
    ..registerLazySingleton<PeriodicReminderCubit>(PeriodicReminderCubit.new);
}
