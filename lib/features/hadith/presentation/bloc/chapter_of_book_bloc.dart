import 'package:muslim/core/bloc/safe_bloc.dart';

import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/bloc/chapter_of_book_event.dart';
import 'package:muslim/features/hadith/presentation/bloc/chapter_of_book_state.dart';

export 'chapter_of_book_event.dart';
export 'chapter_of_book_state.dart';

class ChapterOfBookBloc extends SafeBloc<ChapterOfBookEvent, ChapterOfBookState> {
  ChapterOfBookBloc(this.repository)
    : super(const ChapterOfBookState()) {
    on<ChapterOfBookLoadChapters>(_onLoadChapters);
    on<ChapterOfBookUpdateSearchText>(_onUpdateSearchText);
  }

  final HadithRepository repository;

  Future<void> _onLoadChapters(
    ChapterOfBookLoadChapters event,
    Emitter<ChapterOfBookState> emit,
  ) async {
    emit(state.copyWith(status: ChapterOfBookStatus.loading));

    final result = await repository.getChaptersOfBook(event.bookSlug);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChapterOfBookStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (chapters) => emit(
        state.copyWith(status: ChapterOfBookStatus.success, chapters: chapters),
      ),
    );
  }

  void _onUpdateSearchText(
    ChapterOfBookUpdateSearchText event,
    Emitter<ChapterOfBookState> emit,
  ) {
    emit(state.copyWith(searchText: event.text));
  }

  // Convenience methods
  Future<void> loadChapters(String bookSlug) async =>
      safeAdd(ChapterOfBookEvent.loadChapters(bookSlug));
  void updateSearchText(String text) =>
      safeAdd(ChapterOfBookEvent.updateSearchText(text));
}
