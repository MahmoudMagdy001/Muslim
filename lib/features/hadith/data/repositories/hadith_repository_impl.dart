import 'dart:math';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/chapter_of_book_entity.dart';
import '../../domain/entities/hadith_book_entity.dart';
import '../../domain/entities/hadith_entity.dart';
import '../../domain/repositories/hadith_repository.dart';
import '../datasources/hadith_local_data_source.dart';
import '../datasources/hadith_remote_data_source.dart';
import '../models/chapter_of_book_model.dart';
import '../models/hadith_book_model.dart';
import '../models/hadith_model.dart';

class HadithRepositoryImpl implements HadithRepository {
  const HadithRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final HadithRemoteDataSource remoteDataSource;
  final HadithLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<HadithBookEntity>>> getHadithBooks() async {
    try {
      final cached = await localDataSource.getCachedBooks();
      if (cached != null && cached.isNotEmpty) {
        return Right(
          cached
              .map(
                (json) =>
                    HadithBookModel.fromJson(json as Map<String, dynamic>),
              )
              .toList(),
        );
      }

      final books = await remoteDataSource.fetchBooks();
      await localDataSource.saveCachedBooks(
        books.map((e) => e.toJson()).toList(),
      );
      return Right(books);
    } catch (e) {
      return const Left(ServerFailure('Failed to load books'));
    }
  }

  @override
  Future<Either<Failure, List<ChapterOfBookEntity>>> getChaptersOfBook(
    String bookSlug,
  ) async {
    try {
      final cached = await localDataSource.getCachedChapters(bookSlug);
      if (cached != null && cached.isNotEmpty) {
        return Right(
          cached
              .map(
                (json) =>
                    ChapterOfBookModel.fromJson(json as Map<String, dynamic>),
              )
              .toList(),
        );
      }

      final chapters = await remoteDataSource.fetchChapters(bookSlug);
      await localDataSource.saveCachedChapters(
        bookSlug,
        chapters.map((e) => e.toJson()).toList(),
      );
      return Right(chapters);
    } catch (e) {
      return Left(ServerFailure('Failed to load chapters for book $bookSlug'));
    }
  }

  @override
  Future<Either<Failure, List<HadithEntity>>> getHadithsOfChapter(
    String bookSlug,
    String chapterNumber,
  ) async {
    try {
      final hadiths = await remoteDataSource.fetchHadithsForChapter(
        bookSlug: bookSlug,
        chapterNumber: chapterNumber,
      );
      return Right(hadiths);
    } catch (e) {
      return const Left(ServerFailure('Failed to load hadiths'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getRandomHadith() async {
    try {
      final cachedHadith = await localDataSource.getRandomHadith();
      if (cachedHadith != null) {
        try {
          final hadithMap = cachedHadith['hadith'] as Map<String, dynamic>;
          cachedHadith['hadith'] = HadithModel.fromJson(hadithMap);
          return Right(cachedHadith);
        } catch (e) {
          // If parsing fails, proceed to fetch a new one
        }
      }

      final random = Random();

      final booksEither = await getHadithBooks();
      if (booksEither.isLeft()) return booksEither.map((r) => {});
      final books = booksEither.getOrElse(() => []);

      final validBooks = books.where((b) {
        final count = int.tryParse(b.hadithCount) ?? 0;
        return count > 0;
      }).toList();
      if (validBooks.isEmpty) {
        return const Left(ServerFailure('No books with hadiths found'));
      }

      final book = validBooks[random.nextInt(validBooks.length)];
      final bookSlug = book.bookSlug;
      final bookName = book.bookName;

      final chaptersEither = await getChaptersOfBook(bookSlug);
      if (chaptersEither.isLeft()) return chaptersEither.map((r) => {});
      final chapters = chaptersEither.getOrElse(() => []);

      if (chapters.isEmpty) {
        return Left(ServerFailure('No chapters found for book $bookSlug'));
      }

      final chapter = chapters[random.nextInt(chapters.length)];
      final chapterNumber = chapter.chapterNumber;
      final chapterNameAr = chapter.chapterNameAr;
      final chapterNameEn = chapter.chapterNameEn;

      final firstPageResponse = await remoteDataSource.fetchRandomHadithPage(
        bookSlug,
        chapterNumber,
      );
      final firstPageData = firstPageResponse['firstPageData'];
      final totalPages = firstPageResponse['totalPages'] as int;

      Map<String, dynamic> targetPageData;
      final int randomPage = random.nextInt(totalPages) + 1;

      if (randomPage == 1) {
        targetPageData = firstPageData;
      } else {
        targetPageData = await remoteDataSource.fetchSpecificHadithPage(
          bookSlug,
          chapterNumber,
          randomPage,
        );
      }

      final Map<String, dynamic> hadithsMap =
          targetPageData['hadiths'] as Map<String, dynamic>;
      final List hadithsJson = hadithsMap['data'] as List? ?? [];
      if (hadithsJson.isEmpty) {
        return const Left(
          ServerFailure('No hadiths found in selected random page'),
        );
      }

      final hadithJson = hadithsJson[random.nextInt(hadithsJson.length)];
      final hadith = HadithModel.fromJson(hadithJson as Map<String, dynamic>);

      final result = {
        'hadith': hadith,
        'bookSlug': bookSlug,
        'bookName': bookName,
        'chapterNumber': chapterNumber,
        'chapterNameAr': chapterNameAr,
        'chapterNameEn': chapterNameEn,
      };

      try {
        final storageMap = Map<String, dynamic>.from(result);
        storageMap['hadith'] = hadith.toJson();
        await localDataSource.saveRandomHadith(storageMap);
      } catch (e) {
        // Ignore cache save error
      }

      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch random hadith'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getSavedHadiths() async {
    try {
      final saved = await localDataSource.loadSavedHadiths();
      return Right(saved);
    } catch (e) {
      return const Left(CacheFailure('Failed to load saved hadiths'));
    }
  }

  @override
  Future<Either<Failure, void>> saveHadith(
    Map<String, dynamic> hadithData,
  ) async {
    try {
      await localDataSource.saveHadith(hadithData);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to save hadith'));
    }
  }

  @override
  Future<Either<Failure, void>> removeHadith(String hadithId) async {
    try {
      await localDataSource.removeHadith(hadithId);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to remove hadith'));
    }
  }
}
