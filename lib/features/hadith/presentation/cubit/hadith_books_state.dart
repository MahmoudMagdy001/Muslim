import 'package:equatable/equatable.dart';

import '../../domain/entities/hadith_book_entity.dart';

enum HadithBooksStatus { initial, loading, success, failure }

enum RandomHadithStatus { initial, loading, success, failure }

class HadithBooksState extends Equatable {
  const HadithBooksState({
    this.status = HadithBooksStatus.initial,
    this.randomHadithStatus = RandomHadithStatus.initial,
    this.books = const [],
    this.randomHadithData,
    this.searchText = '',
    this.errorMessage,
  });

  final HadithBooksStatus status;
  final RandomHadithStatus randomHadithStatus;
  final List<HadithBookEntity> books;
  final Map<String, dynamic>? randomHadithData;
  final String searchText;
  final String? errorMessage;

  HadithBooksState copyWith({
    HadithBooksStatus? status,
    RandomHadithStatus? randomHadithStatus,
    List<HadithBookEntity>? books,
    Map<String, dynamic>? randomHadithData,
    String? searchText,
    String? errorMessage,
  }) => HadithBooksState(
    status: status ?? this.status,
    randomHadithStatus: randomHadithStatus ?? this.randomHadithStatus,
    books: books ?? this.books,
    randomHadithData: randomHadithData ?? this.randomHadithData,
    searchText: searchText ?? this.searchText,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    status,
    randomHadithStatus,
    books,
    randomHadithData,
    searchText,
    errorMessage,
  ];
}
