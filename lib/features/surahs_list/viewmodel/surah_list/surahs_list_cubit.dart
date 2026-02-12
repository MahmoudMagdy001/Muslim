import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/di/service_locator.dart';
import '../../model/hizb_model.dart';
import '../../model/juz_model.dart';
import '../../model/quran_view_type.dart';
import '../../repository/surahs_list_repository.dart';
import '../../service/search_service.dart';
import 'surahs_list_state.dart';

class SurahListCubit extends Cubit<SurahsListState> {
  SurahListCubit({
    SurahsListRepository? surahRepository,
    QuranSearchService? searchService,
  }) : surahRepository = surahRepository ?? getIt<SurahsListRepository>(),
       searchService = searchService ?? getIt<QuranSearchService>(),
       super(const SurahsListState()) {
    // _loadSurahs();
  }
  final SurahsListRepository surahRepository;
  final QuranSearchService searchService;

  Timer? _debounceTimer;

  Future<void> loadSurahs({required bool isArabic}) async {
    try {
      if (!isClosed) emit(state.copyWith(status: SurahsListStatus.loading));
      final allSurahs = await surahRepository.getAllSurahs(isArabic: isArabic);

      // Load Juzs
      final allJuzs = List.generate(JuzModel.starts.length, (index) {
        final juzNumber = index + 1;
        final startInfo = JuzModel.starts[index];
        final int startSurahNumber = startInfo['surah'];
        final int startAyahNumber = startInfo['ayah'];

        return JuzModel(
          number: juzNumber,
          startSurah: startSurahNumber,
          startAyah: startAyahNumber,
          startSurahName: isArabic
              ? quran.getSurahNameArabic(startSurahNumber)
              : quran.getSurahName(startSurahNumber),
        );
      });

      // Load Hizbs
      final allHizbs = List.generate(HizbModel.starts.length, (index) {
        final hizbNumber = index + 1;
        final startInfo = HizbModel.starts[index];
        final int startSurahNumber = startInfo['surah'];
        final int startAyahNumber = startInfo['ayah'];

        return HizbModel(
          number: hizbNumber,
          startSurah: startSurahNumber,
          startAyah: startAyahNumber,
          startSurahName: isArabic
              ? quran.getSurahNameArabic(startSurahNumber)
              : quran.getSurahName(startSurahNumber),
        );
      });

      if (isClosed) return;

      emit(
        state.copyWith(
          status: SurahsListStatus.success,
          allSurahs: allSurahs,
          filteredSurahs: allSurahs,
          juzs: allJuzs,
          hizbs: allHizbs,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: SurahsListStatus.error,
          message: 'Failed to load surahs: $e',
        ),
      );
    }
  }

  void searchInQuran(String keyword, {required bool partial}) {
    final results = searchService.search(keyword, partial: partial);
    if (!isClosed) {
      emit(state.copyWith(searchText: keyword, searchResults: results));
    }
  }

  void changeViewType(QuranViewType viewType) {
    if (!isClosed) emit(state.copyWith(currentViewType: viewType));
  }

  Future<void> saveLastSurah(int surah, {int lastAyah = 1}) async {
    try {
      await surahRepository.saveLastSurah(surah, lastAyah: lastAyah);
    } catch (e) {
      // يمكن إضافة حالة خطأ إذا لزم الأمر
      debugPrint('Error saving last surah: $e');
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
