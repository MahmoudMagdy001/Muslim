import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_book_entity.dart';

part 'hadith_book_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class HadithBookModel with _$HadithBookModel {
  const HadithBookModel._();

  const factory HadithBookModel({
    required String id,
    required String bookName,
    required String writerName,
    required String hadithCount,
    required String chapterCount,
    required String writerDeath,
    required String bookSlug,
  }) = _HadithBookModel;

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

  HadithBookEntity toEntity() => HadithBookEntity(
    id: id,
    bookName: bookName,
    writerName: writerName,
    hadithCount: hadithCount,
    chapterCount: chapterCount,
    writerDeath: writerDeath,
    bookSlug: bookSlug,
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
