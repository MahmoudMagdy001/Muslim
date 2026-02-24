import '../../domain/entities/hadith_book_entity.dart';

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
        bookName: json['bookName'] ?? '',
        writerName: json['writerName'] ?? '',
        hadithCount: json['hadiths_count'].toString(),
        chapterCount: json['chapters_count'].toString(),
        writerDeath: json['writerDeath'] ?? '',
        bookSlug: json['bookSlug'] ?? '',
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
