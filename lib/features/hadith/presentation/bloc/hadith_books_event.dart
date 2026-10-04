import 'package:freezed_annotation/freezed_annotation.dart';

part 'hadith_books_event.freezed.dart';

@freezed
sealed class HadithBooksEvent with _$HadithBooksEvent {
  const factory HadithBooksEvent.loadBooks() = HadithBooksLoadBooks;
  const factory HadithBooksEvent.loadRandomHadith() = HadithBooksLoadRandomHadith;
  const factory HadithBooksEvent.updateSearchText(String text) = HadithBooksUpdateSearchText;
}
