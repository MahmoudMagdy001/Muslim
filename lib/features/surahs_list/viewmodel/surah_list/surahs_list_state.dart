import 'package:equatable/equatable.dart';

import '../../model/hizb_model.dart';
import '../../model/juz_model.dart';
import '../../model/quran_view_type.dart';
import '../../model/search_model.dart';
import '../../model/surahs_list_model.dart';

enum SurahsListStatus { initial, loading, success, error }

class SurahsListState extends Equatable {
  const SurahsListState({
    this.status = SurahsListStatus.initial,
    this.message,
    this.allSurahs = const [],
    this.filteredSurahs = const [],
    this.searchText = '',
    this.searchResults = const [],
    this.juzs = const [],
    this.hizbs = const [],
    this.currentViewType = QuranViewType.surah,
  });

  final SurahsListStatus status;
  final String? message;
  final List<SurahsListModel> allSurahs;
  final List<SurahsListModel> filteredSurahs;
  final String searchText;
  final List<SearchResult> searchResults;
  final List<JuzModel> juzs;
  final List<HizbModel> hizbs;
  final QuranViewType currentViewType;

  SurahsListState copyWith({
    SurahsListStatus? status,
    String? message,
    List<SurahsListModel>? allSurahs,
    List<SurahsListModel>? filteredSurahs,
    String? searchText,
    List<SearchResult>? searchResults,
    List<JuzModel>? juzs,
    List<HizbModel>? hizbs,
    QuranViewType? currentViewType,
  }) => SurahsListState(
    status: status ?? this.status,
    message: message ?? this.message,
    allSurahs: allSurahs ?? this.allSurahs,
    filteredSurahs: filteredSurahs ?? this.filteredSurahs,
    searchText: searchText ?? this.searchText,
    searchResults: searchResults ?? this.searchResults,
    juzs: juzs ?? this.juzs,
    hizbs: hizbs ?? this.hizbs,
    currentViewType: currentViewType ?? this.currentViewType,
  );

  @override
  List<Object?> get props => [
    status,
    message,
    allSurahs,
    filteredSurahs,
    searchText,
    searchResults,
    juzs,
    hizbs,
    currentViewType,
  ];
}
