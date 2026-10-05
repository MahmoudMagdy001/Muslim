import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:muslim/core/bloc/safe_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/features/surahs_list/data/models/hizb_model.dart';
import 'package:muslim/features/surahs_list/data/models/juz_model.dart';
import 'package:muslim/features/surahs_list/data/models/quran_view_type.dart';
import 'package:muslim/features/surahs_list/data/repositories/surahs_list_repository.dart';
import 'package:muslim/features/surahs_list/data/services/search_service.dart';
import 'package:muslim/features/surahs_list/presentation/bloc/surahs_list_event.dart';
import 'package:muslim/features/surahs_list/presentation/bloc/surahs_list_state.dart';
import 'package:quran/quran.dart' as quran;

export 'surahs_list_event.dart';

class SurahListBloc extends SafeBloc<SurahsListEvent, SurahsListState> {
  SurahListBloc({
    SurahsListRepository? surahRepository,
    QuranSearchService? searchService,
  }) : surahRepository = surahRepository ?? getIt<SurahsListRepository>(),
       searchService = searchService ?? getIt<QuranSearchService>(),
       super(const SurahsListState()) {
    on<SurahsListLoadSurahs>(_onLoadSurahs);
    on<SurahsListSearchInQuran>(_onSearchInQuran);
    on<SurahsListChangeViewType>(_onChangeViewType);
    on<SurahsListSaveLastSurah>(_onSaveLastSurah);
  }

  final SurahsListRepository surahRepository;
  final QuranSearchService searchService;

  Timer? _debounceTimer;

  Future<void> _onLoadSurahs(
    SurahsListLoadSurahs event,
    Emitter<SurahsListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SurahsListStatus.loading));
      final allSurahs = await surahRepository.getAllSurahs(isArabic: event.isArabic);

      // Load Juzs
      final allJuzs = List.generate(JuzModel.starts.length, (index) {
        final juzNumber = index + 1;
        final startInfo = JuzModel.starts[index];
        final startSurahNumber = startInfo['surah'] as int;
        final startAyahNumber = startInfo['ayah'] as int;

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
          startSurahName: event.isArabic
              ? quran.getSurahNameArabic(startSurahNumber)
              : quran.getSurahName(startSurahNumber),
          endSurah: endSurahNumber,
          endAyah: endAyahNumber,
          endSurahName: event.isArabic
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
          startSurahName: event.isArabic
              ? quran.getSurahNameArabic(startSurahNumber)
              : quran.getSurahName(startSurahNumber),
          endSurah: endSurahNumber,
          endAyah: endAyahNumber,
          endSurahName: event.isArabic
              ? quran.getSurahNameArabic(endSurahNumber)
              : quran.getSurahName(endSurahNumber),
        );
      });

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
      emit(
        state.copyWith(
          status: SurahsListStatus.error,
          message: 'Failed to load surahs: $e',
        ),
      );
    }
  }

  Future<void> _onSearchInQuran(
    SurahsListSearchInQuran event,
    Emitter<SurahsListState> emit,
  ) async {
    final keyword = event.keyword;
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(searchText: keyword, searchResults: []));
      return;
    }

    try {
      final results = await compute(searchQuranBackground, {
        'keyword': keyword,
        'partial': event.partial,
      });
      emit(state.copyWith(searchText: keyword, searchResults: results));
    } on Object catch (e) {
      debugPrint('Search error: $e');
    }
  }

  void _onChangeViewType(
    SurahsListChangeViewType event,
    Emitter<SurahsListState> emit,
  ) {
    emit(state.copyWith(currentViewType: event.viewType));
  }

  Future<void> _onSaveLastSurah(
    SurahsListSaveLastSurah event,
    Emitter<SurahsListState> emit,
  ) async {
    try {
      await surahRepository.saveLastSurah(event.surah, lastAyah: event.lastAyah);
    } on Object catch (e) {
      debugPrint('Error saving last surah: $e');
    }
  }

  // Convenience methods
  Future<void> loadSurahs({bool isArabic = true}) async =>
      safeAdd(SurahsListEvent.loadSurahs(isArabic: isArabic));

  Future<void> searchInQuran(String keyword, {required bool partial}) async =>
      safeAdd(SurahsListEvent.searchInQuran(keyword: keyword, partial: partial));

  void changeViewType(QuranViewType viewType) =>
      safeAdd(SurahsListEvent.changeViewType(viewType));

  Future<void> saveLastSurah(int surah, {int lastAyah = 1}) async =>
      safeAdd(SurahsListEvent.saveLastSurah(surah: surah, lastAyah: lastAyah));

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
