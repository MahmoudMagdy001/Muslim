import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_books_state.dart';

class HadithBooksCubit extends Cubit<HadithBooksState> {
  HadithBooksCubit({
    required this.repository,
  }) : super(const HadithBooksState()) {
    unawaited(loadBooks());
    unawaited(loadRandomHadith());
  }

  final HadithRepository repository;

  Future<void> loadBooks() async {
    if (state.status == HadithBooksStatus.initial) {
      emit(state.copyWith(status: HadithBooksStatus.loading));
    }

    final result = await repository.getHadithBooks();
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

  void updateSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }
}
