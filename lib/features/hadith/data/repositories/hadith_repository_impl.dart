import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_local_data_source.dart';
import 'package:muslim/features/hadith/data/datasources/hadith_remote_data_source.dart';
import 'package:muslim/features/hadith/data/models/chapter_of_book_model.dart';
import 'package:muslim/features/hadith/data/models/hadith_book_model.dart';
import 'package:muslim/features/hadith/data/models/hadith_model.dart';
import 'package:muslim/features/hadith/domain/entities/chapter_of_book_entity.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_book_entity.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';

const List<HadithBookEntity> defaultHadithBooks = [
  HadithBookEntity(
    id: '1',
    bookName: 'Sahih Bukhari',
    writerName: 'Imam Bukhari',
    hadithCount: '7276',
    chapterCount: '99',
    writerDeath: '256 هـ',
    bookSlug: 'sahih-bukhari',
  ),
  HadithBookEntity(
    id: '2',
    bookName: 'Sahih Muslim',
    writerName: 'Imam Muslim',
    hadithCount: '7564',
    chapterCount: '56',
    writerDeath: '261 هـ',
    bookSlug: 'sahih-muslim',
  ),
  HadithBookEntity(
    id: '4',
    bookName: "Jami' Al-Tirmidhi",
    writerName: 'Abu `Isa Muhammad at-Tirmidhi',
    hadithCount: '3956',
    chapterCount: '50',
    writerDeath: '279',
    bookSlug: 'al-tirmidhi',
  ),
  HadithBookEntity(
    id: '5',
    bookName: 'Sunan Abu Dawood',
    writerName: "Imam Abu Dawud Sulayman ibn al-Ash'ath as-Sijistani",
    hadithCount: '5274',
    chapterCount: '43',
    writerDeath: '275',
    bookSlug: 'abu-dawood',
  ),
  HadithBookEntity(
    id: '6',
    bookName: 'Sunan Ibn-e-Majah',
    writerName: 'Imam Muhammad bin Yazid Ibn Majah al-Qazvini',
    hadithCount: '4341',
    chapterCount: '39',
    writerDeath: '273',
    bookSlug: 'ibn-e-majah',
  ),
  HadithBookEntity(
    id: '7',
    bookName: 'Sunan An-Nasa`i',
    writerName: 'Imam Ahmad an-Nasa`i',
    hadithCount: '5761',
    chapterCount: '52',
    writerDeath: '303',
    bookSlug: 'sunan-nasai',
  ),
  HadithBookEntity(
    id: '8',
    bookName: 'Mishkat Al-Masabih',
    writerName: 'Imam Khatib at-Tabrizi',
    hadithCount: '6293',
    chapterCount: '29',
    writerDeath: '741',
    bookSlug: 'mishkat',
  ),
  HadithBookEntity(
    id: '9',
    bookName: 'Musnad Ahmad',
    writerName: 'Imam Ahmad ibn Hanbal',
    hadithCount: '0',
    chapterCount: '14',
    writerDeath: '241',
    bookSlug: 'musnad-ahmad',
  ),
  HadithBookEntity(
    id: '10',
    bookName: 'Al-Silsila Sahiha',
    writerName: 'Allama Muhammad Nasir Uddin Al-Bani',
    hadithCount: '0',
    chapterCount: '28',
    writerDeath: 'October 2, 1999',
    bookSlug: 'al-silsila-sahiha',
  ),
];

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
        final books = cached
            .map(
              (json) => HadithBookModel.fromJson(
                Map<String, dynamic>.from(json as Map),
              ).toEntity(),
            )
            .toList();
        if (books.isNotEmpty) {
          return Right(books);
        }
      }
    } on Object catch (e) {
      debugPrint('Error reading cached books: $e');
    }

    try {
      final books = await remoteDataSource.fetchBooks();
      if (books.isNotEmpty) {
        try {
          await localDataSource.saveCachedBooks(
            books.map((e) => e.toJson()).toList(),
          );
        } on Object catch (_) {}
        return Right(books.map((e) => e.toEntity()).toList());
      }
    } on Object catch (e) {
      debugPrint('Error fetching remote books: $e');
    }

    // Fallback to bundled standard books if network fails
    return const Right(defaultHadithBooks);
  }

  @override
  Future<Either<Failure, List<ChapterOfBookEntity>>> getChaptersOfBook(
    String bookSlug,
  ) async {
    try {
      final cached = await localDataSource.getCachedChapters(bookSlug);
      if (cached != null && cached.isNotEmpty) {
        final chapters = cached
            .map(
              (json) => ChapterOfBookModel.fromJson(
                Map<String, dynamic>.from(json as Map),
              ).toEntity(),
            )
            .toList();
        if (chapters.isNotEmpty) {
          return Right(chapters);
        }
      }
    } on Object catch (e) {
      debugPrint('Error reading cached chapters for $bookSlug: $e');
    }

    try {
      final chapters = await remoteDataSource.fetchChapters(bookSlug);
      try {
        await localDataSource.saveCachedChapters(
          bookSlug,
          chapters.map((e) => e.toJson()).toList(),
        );
      } on Object catch (_) {}
      return Right(chapters.map((e) => e.toEntity()).toList());
    } on Object catch (e) {
      debugPrint('Error fetching remote chapters for $bookSlug: $e');
      return Left(ServerFailure('Failed to load chapters: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HadithEntity>>> getHadithsOfChapter(
    String bookSlug,
    String chapterNumber,
  ) async {
    try {
      final cached = await localDataSource.getCachedHadiths(
        bookSlug,
        chapterNumber,
      );
      if (cached != null && cached.isNotEmpty) {
        final hadiths = cached
            .map(
              (json) => HadithModel.fromJson(
                Map<String, dynamic>.from(json as Map),
              ).toEntity(),
            )
            .toList();
        if (hadiths.isNotEmpty) {
          return Right(hadiths);
        }
      }
    } on Object catch (e) {
      debugPrint('Error reading cached hadiths for $bookSlug/$chapterNumber: $e');
    }

    try {
      final hadiths = await remoteDataSource.fetchHadithsForChapter(
        bookSlug: bookSlug,
        chapterNumber: chapterNumber,
      );
      try {
        await localDataSource.saveCachedHadiths(
          bookSlug,
          chapterNumber,
          hadiths.map((e) => e.toJson()).toList(),
        );
      } on Object catch (_) {}
      return Right(hadiths.map((e) => e.toEntity()).toList());
    } on Object catch (e) {
      debugPrint('Error fetching remote hadiths for $bookSlug/$chapterNumber: $e');
      return Left(ServerFailure('Failed to load hadiths: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getRandomHadith() async {
    try {
      final cachedHadith = await localDataSource.getRandomHadith();
      if (cachedHadith != null) {
        try {
          final hadithMap =
              Map<String, dynamic>.from(cachedHadith['hadith'] as Map);
          cachedHadith['hadith'] =
              HadithModel.fromJson(hadithMap).toEntity();
          return Right(cachedHadith);
        } on Object catch (_) {
          // If parsing fails, proceed to fetch a new one
        }
      }

      final random = Random();

      final booksEither = await getHadithBooks();
      if (booksEither case Left(:final value)) return Left(value);
      final books = booksEither.getOrElse((_) => []);

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
      if (chaptersEither case Left(:final value)) return Left(value);
      final chapters = chaptersEither.getOrElse((_) => []);

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
      final randomPage = random.nextInt(totalPages) + 1;

      if (randomPage == 1) {
        targetPageData = firstPageData as Map<String, dynamic>;
      } else {
        targetPageData = await remoteDataSource.fetchSpecificHadithPage(
          bookSlug,
          chapterNumber,
          randomPage,
        );
      }

      final hadithsMap =
          targetPageData['hadiths'] as Map<String, dynamic>;
      final hadithsJson = hadithsMap['data'] as List? ?? [];
      if (hadithsJson.isEmpty) {
        return const Left(
          ServerFailure('No hadiths found in selected random page'),
        );
      }

      final hadithJson = hadithsJson[random.nextInt(hadithsJson.length)];
      final hadith = HadithModel.fromJson(hadithJson as Map<String, dynamic>);

      final result = {
        'hadith': hadith.toEntity(),
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
      } on Object catch (_) {
        // Ignore cache save error
      }

      return Right(result);
    } on Object catch (_) {
      return const Left(ServerFailure('Failed to fetch random hadith'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getSavedHadiths() async {
    try {
      final saved = await localDataSource.loadSavedHadiths();
      return Right(saved);
    } on Object catch (_) {
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
    } on Object catch (_) {
      return const Left(CacheFailure('Failed to save hadith'));
    }
  }

  @override
  Future<Either<Failure, void>> removeHadith(String hadithId) async {
    try {
      await localDataSource.removeHadith(hadithId);
      return const Right(null);
    } on Object catch (_) {
      return const Left(CacheFailure('Failed to remove hadith'));
    }
  }
}
