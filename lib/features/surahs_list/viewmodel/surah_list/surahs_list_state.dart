import 'package:equatable/equatable.dart';

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
  List<Object?> get props => [
    status,
    message,
    allSurahs,
    filteredSurahs,
    searchText,
    searchResults,
  ];
}
