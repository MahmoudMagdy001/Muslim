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
import 'package:muslim/features/azkar/presentation/cubit/azkar_audio_cubit.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_local_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_remote_data_source.dart';
import 'package:muslim/features/hadith/data/repositories/hadith_repository_impl.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/cubit/chapter_of_book_cubit.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_books_cubit.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_cubit.dart';
import 'package:muslim/features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import 'package:muslim/features/names_of_allah/data/repositories/names_of_allah_repository_impl.dart';
import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import 'package:muslim/features/names_of_allah/presentation/cubit/names_of_allah_cubit.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_notification_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_notification_repository_impl.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:muslim/features/prayer_times/domain/usecases/calculate_next_prayer_usecase.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:muslim/features/qiblah/data/datasources/qiblah_local_data_source.dart';
import 'package:muslim/features/qiblah/data/repositories/qiblah_repository_impl.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';
import 'package:muslim/features/qiblah/presentation/cubit/qiblah_cubit.dart';
import 'package:muslim/features/quran/repository/tafsir_repository.dart';
import 'package:muslim/features/quran/service/bookmarks_service.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:muslim/features/quran/viewmodel/last_played_cubit/last_played.dart';
import 'package:muslim/features/quran/viewmodel/quran_player_cubit/quran_player_cubit.dart';
import 'package:muslim/features/sebha/data/datasources/sebha_local_data_source.dart';
import 'package:muslim/features/sebha/data/repositories/sebha_repository_impl.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:muslim/features/sebha/presentation/cubit/sebha_cubit.dart';
import 'package:muslim/features/settings/service/settings_service.dart';
import 'package:muslim/features/settings/view_model/font_size/font_size_cubit.dart';
import 'package:muslim/features/settings/view_model/language/language_cubit.dart';
import 'package:muslim/features/settings/view_model/periodic_reminder/periodic_reminder_cubit.dart';
import 'package:muslim/features/settings/view_model/rectire/rectire_cubit.dart';
import 'package:muslim/features/settings/view_model/theme/theme_cubit.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository_impl.dart';
import 'package:muslim/features/surahs_list/service/search_service.dart';
import 'package:muslim/features/surahs_list/viewmodel/surah_list/surahs_list_cubit.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';
import 'package:muslim/features/zakat/data/repositories/zakat_repository_impl.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
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
    ..registerLazySingleton<TafsirRepository>(TafsirRepository.new)
    ..registerLazySingleton<SurahsListRepository>(SurahsListRepositoryImpl.new)
    ..registerLazySingleton<AzkarRepository>(() => AzkarRepositoryImpl(getIt<AzkarRemoteDataSource>(), getIt<AzkarLocalDataSource>(), getIt<AzkarAudioDataSource>()))
    ..registerLazySingleton<HadithRepository>(() => HadithRepositoryImpl(remoteDataSource: getIt<HadithRemoteDataSource>(), localDataSource: getIt<HadithLocalDataSource>()))
    ..registerLazySingleton<SebhaRepository>(() => SebhaRepositoryImpl(localDataSource: getIt<SebhaLocalDataSource>()))
    ..registerLazySingleton<ZakatRepository>(() => ZakatRepositoryImpl(remoteDataSource: getIt<ZakatRemoteDataSource>()))
    ..registerLazySingleton<QiblahRepository>(() => QiblahRepositoryImpl(localDataSource: getIt<QiblahLocalDataSource>()))
    ..registerLazySingleton<NamesOfAllahRepository>(() => NamesOfAllahRepositoryImpl(localDataSource: getIt<NamesOfAllahLocalDataSource>()))

  // Domain Use Cases (Calculations)
    ..registerLazySingleton<CalculateNextPrayerUseCase>(CalculateNextPrayerUseCase.new)

  // Cubits
    ..registerLazySingleton<PrayerTimesCubit>(PrayerTimesCubit.new)
    ..registerLazySingleton<ThemeCubit>(ThemeCubit.new)
    ..registerLazySingleton<LanguageCubit>(LanguageCubit.new)
    ..registerLazySingleton<FontSizeCubit>(FontSizeCubit.new)
    ..registerLazySingleton<ReciterCubit>(ReciterCubit.new)
    ..registerLazySingleton<BookmarksCubit>(BookmarksCubit.new)
    ..registerFactory<QuranPlayerCubit>(() => QuranPlayerCubit(getIt<QuranService>()))
    ..registerFactory<SurahListCubit>(SurahListCubit.new)
    ..registerFactory<LastPlayedCubit>(LastPlayedCubit.new)
    ..registerFactory<AzkarCubit>(() => AzkarCubit(getIt<AzkarRepository>()))
    ..registerLazySingleton<AzkarAudioCubit>(() => AzkarAudioCubit(getIt<AzkarRepository>()))
    ..registerFactory<HadithBooksCubit>(() => HadithBooksCubit(repository: getIt<HadithRepository>()))
    ..registerFactory<ChapterOfBookCubit>(() => ChapterOfBookCubit(getIt<HadithRepository>()))
    ..registerFactory<HadithCubit>(() => HadithCubit(repository: getIt<HadithRepository>()))
    ..registerFactory<SebhaCubit>(() => SebhaCubit(repository: getIt<SebhaRepository>()))
    ..registerFactory<ZakatCubit>(() => ZakatCubit(repository: getIt<ZakatRepository>()))
    ..registerFactory<QiblahCubit>(() => QiblahCubit(repository: getIt<QiblahRepository>(), locationService: getIt<LocationService>()))
    ..registerFactory<NamesOfAllahCubit>(() => NamesOfAllahCubit(repository: getIt<NamesOfAllahRepository>()))
    ..registerLazySingleton<PeriodicReminderCubit>(PeriodicReminderCubit.new);
}
