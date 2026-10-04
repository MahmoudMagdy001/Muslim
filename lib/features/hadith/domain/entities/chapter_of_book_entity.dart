import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_of_book_entity.freezed.dart';

@freezed
abstract class ChapterOfBookEntity with _$ChapterOfBookEntity {
  const factory ChapterOfBookEntity({
    required String id,
    required String chapterNameAr,
    required String chapterNameEn,
    required String chapterNumber,
  }) = _ChapterOfBookEntity;
}
