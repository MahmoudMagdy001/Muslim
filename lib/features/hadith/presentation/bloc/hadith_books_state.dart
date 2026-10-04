import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_book_entity.dart';

part 'hadith_books_state.freezed.dart';

enum HadithBooksStatus { initial, loading, success, failure }

enum RandomHadithStatus { initial, loading, success, failure }

@freezed
abstract class HadithBooksState with _$HadithBooksState {
  const factory HadithBooksState({
    @Default(HadithBooksStatus.initial) HadithBooksStatus status,
    @Default([]) List<HadithBookEntity> books,
    @Default(RandomHadithStatus.initial)
    RandomHadithStatus randomHadithStatus,
    Map<String, dynamic>? randomHadithData,
    @Default('') String searchText,
    String? errorMessage,
  }) = _HadithBooksState;
}
