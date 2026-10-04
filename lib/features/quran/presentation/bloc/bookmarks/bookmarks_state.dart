import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/quran/data/models/bookmark_model.dart';

part 'bookmarks_state.freezed.dart';

enum BookmarksStatus { initial, loading, ready, error }

@freezed
abstract class BookmarksState with _$BookmarksState {
  const factory BookmarksState({
    @Default(BookmarksStatus.initial) BookmarksStatus status,
    @Default([]) List<AyahBookmark> bookmarks,
    String? message,
  }) = _BookmarksState;
}
