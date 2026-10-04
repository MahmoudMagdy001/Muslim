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
import 'package:muslim/features/azkar/presentation/bloc/azkar_audio_bloc.dart';
import 'package:muslim/features/azkar/presentation/bloc/azkar_bloc.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_local_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_remote_data_source.dart';
import 'package:muslim/features/hadith/data/repositories/hadith_repository_impl.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/bloc/chapter_of_book_bloc.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_bloc.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_books_bloc.dart';
import 'package:muslim/features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import 'package:muslim/features/names_of_allah/data/repositories/names_of_allah_repository_impl.dart';
import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import 'package:muslim/features/names_of_allah/presentation/bloc/names_of_allah_bloc.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_notification_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_notification_repository_impl.dart';
import 'package:muslim/features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:muslim/features/prayer_times/domain/usecases/calculate_next_prayer_usecase.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_bloc.dart';
import 'package:muslim/features/qiblah/data/datasources/qiblah_local_data_source.dart';
import 'package:muslim/features/qiblah/data/repositories/qiblah_repository_impl.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';
import 'package:muslim/features/qiblah/presentation/bloc/qiblah_bloc.dart';
import 'package:muslim/features/quran/data/repositories/tafsir_repository.dart';
import 'package:muslim/features/quran/data/services/bookmarks_service.dart';
import 'package:muslim/features/quran/data/services/quran_service.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/last_played/last_played_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_bloc.dart';
import 'package:muslim/features/sebha/data/datasources/sebha_local_data_source.dart';
import 'package:muslim/features/sebha/data/repositories/sebha_repository_impl.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:muslim/features/sebha/presentation/bloc/sebha_bloc.dart';
import 'package:muslim/features/settings/data/services/settings_service.dart';
import 'package:muslim/features/settings/presentation/bloc/font_size/font_size_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/language/language_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/periodic_reminder/periodic_reminder_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/reciter/reciter_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/theme/theme_bloc.dart';
import 'package:muslim/features/surahs_list/data/repositories/surahs_list_repository.dart';
import 'package:muslim/features/surahs_list/data/repositories/surahs_list_repository_impl.dart';
import 'package:muslim/features/surahs_list/data/services/search_service.dart';
import 'package:muslim/features/surahs_list/presentation/bloc/surahs_list_bloc.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';
import 'package:muslim/features/zakat/data/repositories/zakat_repository_impl.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:muslim/features/zakat/presentation/bloc/zakat_bloc.dart';

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
    ..registerLazySingleton<TafsirRepository>(() => TafsirRepository(client: getIt<http.Client>()))
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
