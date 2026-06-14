import 'package:muslim/features/hadith/domain/entities/hadith_book_entity.dart';

class HadithBookModel extends HadithBookEntity {
  const HadithBookModel({
    required super.id,
    required super.bookName,
    required super.writerName,
    required super.hadithCount,
    required super.chapterCount,
    required super.writerDeath,
    required super.bookSlug,
  });

  factory HadithBookModel.fromJson(Map<String, dynamic> json) =>
      HadithBookModel(
        id: json['id'].toString(),
        bookName: json['bookName'] as String? ?? '',
        writerName: json['writerName'] as String? ?? '',
        hadithCount: json['hadiths_count'].toString(),
        chapterCount: json['chapters_count'].toString(),
        writerDeath: json['writerDeath'] as String? ?? '',
        bookSlug: json['bookSlug'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bookName': bookName,
    'writerName': writerName,
    'hadiths_count': hadithCount,
    'chapters_count': chapterCount,
    'writerDeath': writerDeath,
    'bookSlug': bookSlug,
  };
}
