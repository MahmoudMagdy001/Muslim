import 'package:flutter/foundation.dart';

import '../../model/search_model.dart';
import '../../model/surahs_list_model.dart';

enum SurahsListStatus { initial, loading, success, error }

class SurahsListState {
  const SurahsListState({
    this.status = SurahsListStatus.initial,
    this.message,
    this.allSurahs = const [],
    this.filteredSurahs = const [],
    this.searchText = '',
    this.searchResults = const [],
  });

  final SurahsListStatus status;
  final String? message;
  final List<SurahsListModel> allSurahs;
  final List<SurahsListModel> filteredSurahs;
  final String searchText;
  final List<SearchResult> searchResults;

  SurahsListState copyWith({
    SurahsListStatus? status,
    String? message,
    List<SurahsListModel>? allSurahs,
    List<SurahsListModel>? filteredSurahs,
    String? searchText,
    List<SearchResult>? searchResults,
  }) => SurahsListState(
    status: status ?? this.status,
    message: message ?? this.message,
    allSurahs: allSurahs ?? this.allSurahs,
    filteredSurahs: filteredSurahs ?? this.filteredSurahs,
    searchText: searchText ?? this.searchText,
    searchResults: searchResults ?? this.searchResults,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurahsListState &&
        other.status == status &&
        other.message == message &&
        listEquals(other.allSurahs, allSurahs) &&
        listEquals(other.filteredSurahs, filteredSurahs) &&
        listEquals(other.searchResults, searchResults) &&
        other.searchText == searchText;
  }

  @override
  int get hashCode => Object.hash(
    status,
    message,
    allSurahs,
    filteredSurahs,
    searchResults,
    searchText,
  );
}
