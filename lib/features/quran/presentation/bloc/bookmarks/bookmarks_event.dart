import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmarks_event.freezed.dart';

@freezed
sealed class BookmarksEvent with _$BookmarksEvent {
  const factory BookmarksEvent.load() = BookmarksLoad;
  const factory BookmarksEvent.addBookmark({
    required int surah,
    required int ayah,
    required String ayahText,
  }) = BookmarksAddBookmark;
  const factory BookmarksEvent.removeBookmark({
    required int surah,
    required int ayah,
  }) = BookmarksRemoveBookmark;
}
