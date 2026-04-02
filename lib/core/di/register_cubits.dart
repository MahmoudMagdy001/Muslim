import 'package:get_it/get_it.dart';

import '../../core/service/location_service.dart';
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
import '../../features/hadith/domain/usecases/get_chapters_of_book_use_case.dart';
import '../../features/hadith/domain/usecases/get_hadith_books_use_case.dart';
import '../../features/hadith/domain/usecases/get_hadiths_of_chapter_use_case.dart';
import '../../features/hadith/domain/usecases/get_random_hadith_use_case.dart';
import '../../features/hadith/domain/usecases/get_saved_hadiths_use_case.dart';
import '../../features/hadith/domain/usecases/toggle_save_hadith_use_case.dart';
import '../../features/hadith/presentation/cubit/chapter_of_book_cubit.dart';
import '../../features/hadith/presentation/cubit/hadith_books_cubit.dart';
import '../../features/hadith/presentation/cubit/hadith_cubit.dart';
import '../../features/names_of_allah/domain/usecases/get_names_of_allah_use_case.dart';
import '../../features/names_of_allah/presentation/cubit/names_of_allah_cubit.dart';
import '../../features/qiblah/domain/usecases/get_qiblah_stream_usecase.dart';
import '../../features/qiblah/presentation/cubit/qiblah_cubit.dart';
import '../../features/sebha/domain/usecases/delete_custom_zikr_use_case.dart';
import '../../features/sebha/domain/usecases/get_custom_azkar_use_case.dart';
import '../../features/sebha/domain/usecases/save_custom_zikr_use_case.dart';
import '../../features/sebha/domain/usecases/update_custom_zikr_use_case.dart';
import '../../features/sebha/presentation/cubit/sebha_cubit.dart';
import '../../features/settings/view_model/periodic_reminder/periodic_reminder_cubit.dart';
import '../../features/zakat/domain/usecases/get_gold_price_use_case.dart';
import '../../features/zakat/presentation/cubit/zakat_cubit.dart';

void registerCubits(GetIt getIt) {
  getIt
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
    )
    ..registerLazySingleton<PeriodicReminderCubit>(
      () => PeriodicReminderCubit(),
    );
}
