import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_of_book_event.freezed.dart';

@freezed
sealed class ChapterOfBookEvent with _$ChapterOfBookEvent {
  const factory ChapterOfBookEvent.loadChapters(String bookSlug) = ChapterOfBookLoadChapters;
  const factory ChapterOfBookEvent.updateSearchText(String text) = ChapterOfBookUpdateSearchText;
}
