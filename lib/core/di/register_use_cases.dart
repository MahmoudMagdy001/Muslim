import 'package:get_it/get_it.dart';

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
import '../../features/hadith/domain/repositories/hadith_repository.dart';
import '../../features/hadith/domain/usecases/get_chapters_of_book_use_case.dart';
import '../../features/hadith/domain/usecases/get_hadith_books_use_case.dart';
import '../../features/hadith/domain/usecases/get_hadiths_of_chapter_use_case.dart';
import '../../features/hadith/domain/usecases/get_random_hadith_use_case.dart';
import '../../features/hadith/domain/usecases/get_saved_hadiths_use_case.dart';
import '../../features/hadith/domain/usecases/toggle_save_hadith_use_case.dart';
import '../../features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import '../../features/names_of_allah/domain/usecases/get_names_of_allah_use_case.dart';
import '../../features/prayer_times/domain/repositories/prayer_notification_repository.dart';
import '../../features/prayer_times/domain/repositories/prayer_times_repository.dart';
import '../../features/prayer_times/domain/usecases/calculate_next_prayer_usecase.dart';
import '../../features/prayer_times/domain/usecases/cancel_all_notifications_usecase.dart';
import '../../features/prayer_times/domain/usecases/get_cached_coordinates_usecase.dart';
import '../../features/prayer_times/domain/usecases/get_notification_settings_usecase.dart';
import '../../features/prayer_times/domain/usecases/get_prayer_times_for_date_usecase.dart';
import '../../features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import '../../features/prayer_times/domain/usecases/schedule_notifications_usecase.dart';
import '../../features/prayer_times/domain/usecases/set_prayer_enabled_usecase.dart';
import '../../features/qiblah/domain/repositories/qiblah_repository.dart';
import '../../features/qiblah/domain/usecases/get_qiblah_stream_usecase.dart';
import '../../features/sebha/domain/repositories/sebha_repository.dart';
import '../../features/sebha/domain/usecases/delete_custom_zikr_use_case.dart';
import '../../features/sebha/domain/usecases/get_custom_azkar_use_case.dart';
import '../../features/sebha/domain/usecases/save_custom_zikr_use_case.dart';
import '../../features/sebha/domain/usecases/update_custom_zikr_use_case.dart';
import '../../features/zakat/domain/repositories/zakat_repository.dart';
import '../../features/zakat/domain/usecases/get_gold_price_use_case.dart';

void registerUseCases(GetIt getIt) {
  getIt
    // ── Azkar Use Cases ────────────────────────────────────────────────
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
    // ── Hadith Use Cases ───────────────────────────────────────────────
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
    // ── Sebha Use Cases ────────────────────────────────────────────────
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
    // ── Other Use Cases ────────────────────────────────────────────────
    ..registerLazySingleton<GetGoldPriceUseCase>(
      () => GetGoldPriceUseCase(getIt<ZakatRepository>()),
    )
    ..registerLazySingleton<GetQiblahStreamUseCase>(
      () => GetQiblahStreamUseCase(getIt<QiblahRepository>()),
    )
    ..registerLazySingleton<GetNamesOfAllahUseCase>(
      () => GetNamesOfAllahUseCase(getIt<NamesOfAllahRepository>()),
    )
    // ── Prayer Times Use Cases ─────────────────────────────────────────
    ..registerLazySingleton<GetPrayerTimesUseCase>(
      () => GetPrayerTimesUseCase(getIt<PrayerTimesRepository>()),
    )
    ..registerLazySingleton<GetPrayerTimesForDateUseCase>(
      () => GetPrayerTimesForDateUseCase(getIt<PrayerTimesRepository>()),
    )
    ..registerLazySingleton<GetCachedCoordinatesUseCase>(
      () => GetCachedCoordinatesUseCase(getIt<PrayerTimesRepository>()),
    )
    ..registerLazySingleton<CalculateNextPrayerUseCase>(
      () => CalculateNextPrayerUseCase(),
    )
    ..registerLazySingleton<ScheduleNotificationsUseCase>(
      () => ScheduleNotificationsUseCase(getIt<PrayerNotificationRepository>()),
    )
    ..registerLazySingleton<CancelAllNotificationsUseCase>(
      () =>
          CancelAllNotificationsUseCase(getIt<PrayerNotificationRepository>()),
    )
    ..registerLazySingleton<GetNotificationSettingsUseCase>(
      () =>
          GetNotificationSettingsUseCase(getIt<PrayerNotificationRepository>()),
    )
    ..registerLazySingleton<SetPrayerEnabledUseCase>(
      () => SetPrayerEnabledUseCase(getIt<PrayerNotificationRepository>()),
    );
}
