import 'package:muslim/core/bloc/safe_bloc.dart';

import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_books_event.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_books_state.dart';

export 'hadith_books_event.dart';
export 'hadith_books_state.dart';

class HadithBooksBloc extends SafeBloc<HadithBooksEvent, HadithBooksState> {
  HadithBooksBloc({
    required this.repository,
  }) : super(const HadithBooksState()) {
    on<HadithBooksLoadBooks>(_onLoadBooks);
    on<HadithBooksLoadRandomHadith>(_onLoadRandomHadith);
    on<HadithBooksUpdateSearchText>(_onUpdateSearchText);

    safeAdd(const HadithBooksEvent.loadBooks());
    safeAdd(const HadithBooksEvent.loadRandomHadith());
  }

  final HadithRepository repository;

  Future<void> _onLoadBooks(
    HadithBooksLoadBooks event,
    Emitter<HadithBooksState> emit,
  ) async {
    emit(state.copyWith(status: HadithBooksStatus.loading));

    final result = await repository.getHadithBooks();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HadithBooksStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (books) =>
          emit(state.copyWith(status: HadithBooksStatus.success, books: books)),
    );
  }

  Future<void> _onLoadRandomHadith(
    HadithBooksLoadRandomHadith event,
    Emitter<HadithBooksState> emit,
  ) async {
    emit(state.copyWith(randomHadithStatus: RandomHadithStatus.loading));

    final result = await repository.getRandomHadith();

    result.fold(
      (failure) =>
          emit(state.copyWith(randomHadithStatus: RandomHadithStatus.failure)),
      (data) => emit(
        state.copyWith(
          randomHadithStatus: RandomHadithStatus.success,
          randomHadithData: data,
        ),
      ),
    );
  }

  void _onUpdateSearchText(
    HadithBooksUpdateSearchText event,
    Emitter<HadithBooksState> emit,
  ) {
    emit(state.copyWith(searchText: event.text));
  }

  // Convenience methods
  Future<void> loadBooks() async => safeAdd(const HadithBooksEvent.loadBooks());
  Future<void> loadRandomHadith() async => safeAdd(const HadithBooksEvent.loadRandomHadith());
  void updateSearchText(String text) => safeAdd(HadithBooksEvent.updateSearchText(text));
}
