import '../../model/bookmark_model.dart';

enum BookmarksStatus { initial, loading, ready, error }

class BookmarksState {
  const BookmarksState({
    this.status = BookmarksStatus.initial,
    this.bookmarks = const [],
    this.message,
  });

  final BookmarksStatus status;
  final List<AyahBookmark> bookmarks;
  final String? message;

  BookmarksState copyWith({
    BookmarksStatus? status,
    List<AyahBookmark>? bookmarks,
    String? message,
  }) => BookmarksState(
    status: status ?? this.status,
    bookmarks: bookmarks ?? this.bookmarks,
    message: message ?? this.message,
  );
}
