import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/cubit/chapter_of_book_state.dart';

class ChapterOfBookCubit extends Cubit<ChapterOfBookState> {
  ChapterOfBookCubit(this.repository)
    : super(const ChapterOfBookState());

  final HadithRepository repository;

  Future<void> loadChapters(String bookSlug) async {
    if (!isClosed) emit(state.copyWith(status: ChapterOfBookStatus.loading));

    final result = await repository.getChaptersOfBook(bookSlug);
    if (isClosed) return;

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

  void updateSearchText(String text) {
    if (!isClosed) emit(state.copyWith(searchText: text));
  }
}
