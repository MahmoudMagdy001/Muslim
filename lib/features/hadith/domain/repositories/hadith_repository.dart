import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/chapter_of_book_entity.dart';
import '../entities/hadith_book_entity.dart';
import '../entities/hadith_entity.dart';

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
