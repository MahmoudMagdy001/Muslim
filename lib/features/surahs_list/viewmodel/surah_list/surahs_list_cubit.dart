import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/surahs_list_repository.dart';
import '../../service/search_service.dart';
import 'surahs_list_state.dart';

class SurahListCubit extends Cubit<SurahsListState> {
  SurahListCubit({required this.surahRepository, required this.searchService})
    : super(const SurahsListState()) {
    // _loadSurahs();
  }
  final SurahsListRepository surahRepository;
  final QuranSearchService searchService;

  Timer? _debounceTimer;

  Future<void> loadSurahs({required bool isArabic}) async {
    try {
      emit(state.copyWith(status: SurahsListStatus.loading));
      final allSurahs = await surahRepository.getAllSurahs(isArabic: isArabic);
      emit(
        state.copyWith(
          status: SurahsListStatus.success,
          allSurahs: allSurahs,
          filteredSurahs: allSurahs,
        ),
      );
    } catch (e) {
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
    emit(state.copyWith(searchText: keyword, searchResults: results));
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
