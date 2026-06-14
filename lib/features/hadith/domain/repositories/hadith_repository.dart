import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/hadith/domain/entities/chapter_of_book_entity.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_book_entity.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';

abstract class HadithRepository {
  Future<Either<Failure, List<HadithBookEntity>>> getHadithBooks();

  Future<Either<Failure, List<ChapterOfBookEntity>>> getChaptersOfBook(
    String bookSlug,
  );

  Future<Either<Failure, List<HadithEntity>>> getHadithsOfChapter(
    String bookSlug,
    String chapterNumber,
  );

  Future<Either<Failure, Map<String, dynamic>>> getRandomHadith();

  Future<Either<Failure, List<Map<String, dynamic>>>> getSavedHadiths();

  Future<Either<Failure, void>> saveHadith(Map<String, dynamic> hadithData);

  Future<Either<Failure, void>> removeHadith(String hadithId);
}
