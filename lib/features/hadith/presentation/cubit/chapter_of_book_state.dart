import 'package:equatable/equatable.dart';

import '../../domain/entities/chapter_of_book_entity.dart';

enum ChapterOfBookStatus { initial, loading, success, failure }

class ChapterOfBookState extends Equatable {
  const ChapterOfBookState({
    this.status = ChapterOfBookStatus.initial,
    this.chapters = const [],
    this.searchText = '',
    this.errorMessage,
  });

  final ChapterOfBookStatus status;
  final List<ChapterOfBookEntity> chapters;
  final String searchText;
  final String? errorMessage;

  ChapterOfBookState copyWith({
    ChapterOfBookStatus? status,
    List<ChapterOfBookEntity>? chapters,
    String? searchText,
    String? errorMessage,
  }) => ChapterOfBookState(
    status: status ?? this.status,
    chapters: chapters ?? this.chapters,
    searchText: searchText ?? this.searchText,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, chapters, searchText, errorMessage];
}
