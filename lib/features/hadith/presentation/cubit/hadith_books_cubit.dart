import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_hadith_books_use_case.dart';
import '../../domain/usecases/get_random_hadith_use_case.dart';
import 'hadith_books_state.dart';

class HadithBooksCubit extends Cubit<HadithBooksState> {
  HadithBooksCubit({
    required this.getHadithBooksUseCase,
    required this.getRandomHadithUseCase,
  }) : super(const HadithBooksState()) {
    loadBooks();
    loadRandomHadith();
  }

  final GetHadithBooksUseCase getHadithBooksUseCase;
  final GetRandomHadithUseCase getRandomHadithUseCase;

  Future<void> loadBooks() async {
    if (state.status == HadithBooksStatus.initial) {
      emit(state.copyWith(status: HadithBooksStatus.loading));
    }

    final result = await getHadithBooksUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HadithBooksStatus.failure,
          errorMessage: 'Failed to load books',
        ),
      ),
      (books) =>
          emit(state.copyWith(status: HadithBooksStatus.success, books: books)),
    );
  }

  Future<void> loadRandomHadith() async {
    emit(state.copyWith(randomHadithStatus: RandomHadithStatus.loading));

    final result = await getRandomHadithUseCase(NoParams());
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

  void updateSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }
}
