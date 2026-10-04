import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/chapter_of_book_entity.dart';

part 'chapter_of_book_state.freezed.dart';

enum ChapterOfBookStatus { initial, loading, success, failure }

@freezed
abstract class ChapterOfBookState with _$ChapterOfBookState {
  const factory ChapterOfBookState({
    @Default(ChapterOfBookStatus.initial) ChapterOfBookStatus status,
    @Default([]) List<ChapterOfBookEntity> chapters,
    @Default('') String searchText,
    String? errorMessage,
  }) = _ChapterOfBookState;
}
