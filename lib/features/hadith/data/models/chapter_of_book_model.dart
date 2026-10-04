import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/chapter_of_book_entity.dart';

part 'chapter_of_book_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class ChapterOfBookModel with _$ChapterOfBookModel {
  const ChapterOfBookModel._();

  const factory ChapterOfBookModel({
    required String id,
    required String chapterNameAr,
    required String chapterNumber,
    required String chapterNameEn,
  }) = _ChapterOfBookModel;

  factory ChapterOfBookModel.fromJson(Map<String, dynamic> json) =>
      ChapterOfBookModel(
        id: json['id'].toString(),
        chapterNameAr: json['chapterArabic']?.toString() ?? '',
        chapterNameEn: json['chapterEnglish']?.toString() ?? '',
        chapterNumber: json['chapterNumber']?.toString() ?? '',
      );

  ChapterOfBookEntity toEntity() => ChapterOfBookEntity(
    id: id,
    chapterNameAr: chapterNameAr,
    chapterNameEn: chapterNameEn,
    chapterNumber: chapterNumber,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'chapterArabic': chapterNameAr,
    'chapterEnglish': chapterNameEn,
    'chapterNumber': chapterNumber,
  };
}
