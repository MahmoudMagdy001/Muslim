import '../../domain/entities/chapter_of_book_entity.dart';

class ChapterOfBookModel extends ChapterOfBookEntity {
  const ChapterOfBookModel({
    required super.id,
    required super.chapterNameAr,
    required super.chapterNumber,
    required super.chapterNameEn,
  });

  factory ChapterOfBookModel.fromJson(Map<String, dynamic> json) =>
      ChapterOfBookModel(
        id: json['id'].toString(),
        chapterNameAr: json['chapterArabic']?.toString() ?? '',
        chapterNameEn: json['chapterEnglish']?.toString() ?? '',
        chapterNumber: json['chapterNumber']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'chapterArabic': chapterNameAr,
    'chapterEnglish': chapterNameEn,
    'chapterNumber': chapterNumber,
  };
}
