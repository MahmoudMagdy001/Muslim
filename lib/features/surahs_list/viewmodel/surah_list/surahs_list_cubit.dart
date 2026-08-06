import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/features/surahs_list/model/hizb_model.dart';
import 'package:muslim/features/surahs_list/model/juz_model.dart';
import 'package:muslim/features/surahs_list/model/quran_view_type.dart';
import 'package:muslim/features/surahs_list/repository/surahs_list_repository.dart';
import 'package:muslim/features/surahs_list/service/search_service.dart';
import 'package:muslim/features/surahs_list/viewmodel/surah_list/surahs_list_state.dart';
import 'package:quran/quran.dart' as quran;

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

  Future<void> loadSurahs({bool isArabic = true}) async {
    try {
      if (!isClosed) emit(state.copyWith(status: SurahsListStatus.loading));
      final allSurahs = await surahRepository.getAllSurahs(isArabic: isArabic);

      // Load Juzs
      final allJuzs = List.generate(JuzModel.starts.length, (index) {
        final juzNumber = index + 1;
        final startInfo = JuzModel.starts[index];
        final startSurahNumber = startInfo['surah'] as int;
        final startAyahNumber = startInfo['ayah'] as int;

        // Calculate end ayah/surah
        late final int endSurahNumber;
        late final int endAyahNumber;
        if (index < JuzModel.starts.length - 1) {
          final nextStart = JuzModel.starts[index + 1];
          final nextSurah = nextStart['surah'] as int;
          final nextAyah = nextStart['ayah'] as int;
          if (nextAyah == 1) {
            endSurahNumber = nextSurah - 1;
            endAyahNumber = quran.getVerseCount(endSurahNumber);
          } else {
            endSurahNumber = nextSurah;
            endAyahNumber = nextAyah - 1;
          }
        } else {
          endSurahNumber = 114;
          endAyahNumber = quran.getVerseCount(114);
        }

        return JuzModel(
          number: juzNumber,
          startSurah: startSurahNumber,
          startAyah: startAyahNumber,
          startSurahName: isArabic
              ? quran.getSurahNameArabic(startSurahNumber)
              : quran.getSurahName(startSurahNumber),
          endSurah: endSurahNumber,
          endAyah: endAyahNumber,
          endSurahName: isArabic
              ? quran.getSurahNameArabic(endSurahNumber)
              : quran.getSurahName(endSurahNumber),
        );
      });

      // Load Hizbs
      final allHizbs = List.generate(HizbModel.starts.length, (index) {
        final hizbNumber = index + 1;
        final startInfo = HizbModel.starts[index];
        final startSurahNumber = startInfo['surah'] as int;
        final startAyahNumber = startInfo['ayah'] as int;

        // Calculate end ayah/surah
        late final int endSurahNumber;
        late final int endAyahNumber;
        if (index < HizbModel.starts.length - 1) {
          final nextStart = HizbModel.starts[index + 1];
          final nextSurah = nextStart['surah'] as int;
          final nextAyah = nextStart['ayah'] as int;
          if (nextAyah == 1) {
            endSurahNumber = nextSurah - 1;
            endAyahNumber = quran.getVerseCount(endSurahNumber);
          } else {
            endSurahNumber = nextSurah;
            endAyahNumber = nextAyah - 1;
          }
        } else {
          endSurahNumber = 114;
          endAyahNumber = quran.getVerseCount(114);
        }

        return HizbModel(
          number: hizbNumber,
          startSurah: startSurahNumber,
          startAyah: startAyahNumber,
          startSurahName: isArabic
              ? quran.getSurahNameArabic(startSurahNumber)
              : quran.getSurahName(startSurahNumber),
          endSurah: endSurahNumber,
          endAyah: endAyahNumber,
          endSurahName: isArabic
              ? quran.getSurahNameArabic(endSurahNumber)
              : quran.getSurahName(endSurahNumber),
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
    } on Object catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: SurahsListStatus.error,
          message: 'Failed to load surahs: $e',
        ),
      );
    }
  }

  Future<void> searchInQuran(String keyword, {required bool partial}) async {
    if (keyword.trim().isEmpty) {
      if (!isClosed) {
        emit(state.copyWith(searchText: keyword, searchResults: []));
      }
      return;
    }

    try {
      final results = await compute(searchQuranBackground, {
        'keyword': keyword,
        'partial': partial,
      });
      if (!isClosed) {
        emit(state.copyWith(searchText: keyword, searchResults: results));
      }
    } on Object catch (e) {
      debugPrint('Search error: $e');
    }
  }

  void changeViewType(QuranViewType viewType) {
    if (!isClosed) emit(state.copyWith(currentViewType: viewType));
  }

  Future<void> saveLastSurah(int surah, {int lastAyah = 1}) async {
    try {
      await surahRepository.saveLastSurah(surah, lastAyah: lastAyah);
    } on Object catch (e) {
      debugPrint('Error saving last surah: $e');
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
