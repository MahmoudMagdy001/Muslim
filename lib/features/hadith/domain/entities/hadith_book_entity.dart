import 'package:freezed_annotation/freezed_annotation.dart';

part 'hadith_book_entity.freezed.dart';

@freezed
abstract class HadithBookEntity with _$HadithBookEntity {
  const factory HadithBookEntity({
    required String id,
    required String bookName,
    required String writerName,
    required String hadithCount,
    required String chapterCount,
    required String writerDeath,
    required String bookSlug,
  }) = _HadithBookEntity;
}
