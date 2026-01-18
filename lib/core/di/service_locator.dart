import 'package:get_it/get_it.dart';
import '../../features/quran/repository/quran_repository_impl.dart';
import '../../features/quran/service/bookmarks_service.dart';
import '../../features/quran/repository/tafsir_repository.dart';
import '../../features/surahs_list/repository/surahs_list_repository.dart';
import '../../features/surahs_list/repository/surahs_list_repository_impl.dart';
import '../../features/surahs_list/service/search_service.dart';
import '../../features/prayer_times/service/prayer_times_service.dart';
import '../../features/prayer_times/service/prayer_notification_service.dart';
import '../../features/prayer_times/service/prayer_calculator_service.dart';
import '../../features/hadith/service/hadith/hadith_service.dart';
import '../../features/hadith/service/hadith/hadith_storage_service.dart';
import '../../features/quran/service/quran_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  getIt..registerLazySingleton<QuranService>(() => QuranService())
  ..registerLazySingleton<BookmarksService>(() => BookmarksService())
  ..registerLazySingleton<QuranSearchService>(() => QuranSearchService())
  ..registerLazySingleton<PrayerTimesService>(() => PrayerTimesService())
  ..registerLazySingleton<PrayerNotificationService>(
    () => PrayerNotificationService(),
  )
  ..registerLazySingleton<PrayerCalculatorService>(
    () => PrayerCalculatorService(),
  )
  ..registerLazySingleton<HadithService>(() => HadithService())
  ..registerLazySingleton<HadithStorageService>(
    () => HadithStorageService(),
  )

  // Repositories
  ..registerLazySingleton<QuranRepositoryImpl>(() => QuranRepositoryImpl())
  ..registerLazySingleton<TafsirRepository>(() => TafsirRepository())
  ..registerLazySingleton<SurahsListRepository>(
    () => SurahsListRepositoryImpl(),
  );
}
