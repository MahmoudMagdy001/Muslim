import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_chapters_of_book_use_case.dart';
import 'chapter_of_book_state.dart';

class ChapterOfBookCubit extends Cubit<ChapterOfBookState> {
  ChapterOfBookCubit(this.getChaptersOfBookUseCase)
    : super(const ChapterOfBookState());

  final GetChaptersOfBookUseCase getChaptersOfBookUseCase;

  Future<void> loadChapters(String bookSlug) async {
    if (state.status == ChapterOfBookStatus.initial) {
      emit(state.copyWith(status: ChapterOfBookStatus.loading));
    }

    final result = await getChaptersOfBookUseCase(
      GetChaptersOfBookParams(bookSlug: bookSlug),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChapterOfBookStatus.failure,
          errorMessage: 'Failed to load chapters for book $bookSlug',
        ),
      ),
      (chapters) => emit(
        state.copyWith(status: ChapterOfBookStatus.success, chapters: chapters),
      ),
    );
  }

  void updateSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }
}
