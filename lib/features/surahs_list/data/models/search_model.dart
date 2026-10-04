import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';

@freezed
abstract class SearchResult with _$SearchResult {
  const factory SearchResult({
    required int surahNumber,
    required int verseNumber,
    required String surahName,
    required String ayahText,
    @Default(false) bool isSurah,
  }) = _SearchResult;
}
