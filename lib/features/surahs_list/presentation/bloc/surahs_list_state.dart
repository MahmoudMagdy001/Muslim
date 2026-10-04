import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:muslim/features/surahs_list/data/models/hizb_model.dart';
import 'package:muslim/features/surahs_list/data/models/juz_model.dart';
import 'package:muslim/features/surahs_list/data/models/quran_view_type.dart';
import 'package:muslim/features/surahs_list/data/models/search_model.dart';
import 'package:muslim/features/surahs_list/data/models/surahs_list_model.dart';

part 'surahs_list_state.freezed.dart';

enum SurahsListStatus { initial, loading, success, error }

@freezed
abstract class SurahsListState with _$SurahsListState {
  const factory SurahsListState({
    @Default(SurahsListStatus.initial) SurahsListStatus status,
    String? message,
    @Default([]) List<SurahsListModel> allSurahs,
    @Default([]) List<SurahsListModel> filteredSurahs,
    @Default('') String searchText,
    @Default([]) List<SearchResult> searchResults,
    @Default([]) List<JuzModel> juzs,
    @Default([]) List<HizbModel> hizbs,
    @Default(QuranViewType.surah) QuranViewType currentViewType,
  }) = _SurahsListState;
}
