import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/failures.dart';
import '../models/chapter_of_book_model.dart';
import '../models/hadith_book_model.dart';
import '../models/hadith_model.dart';

abstract class HadithRemoteDataSource {
  Future<List<HadithBookModel>> fetchBooks();
  Future<List<ChapterOfBookModel>> fetchChapters(String bookSlug);
  Future<List<HadithModel>> fetchHadithsForChapter({
    required String bookSlug,
    required String chapterNumber,
  });
  Future<Map<String, dynamic>> fetchRandomHadithPage(
    String bookSlug,
    String chapterNumber,
  );
  Future<Map<String, dynamic>> fetchSpecificHadithPage(
    String bookSlug,
    String chapterNumber,
    int page,
  );
}

class HadithRemoteDataSourceImpl implements HadithRemoteDataSource {
  const HadithRemoteDataSourceImpl({required this.client});
  final http.Client client;

  static const String apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';
  static const int _timeoutSeconds = 30;
  static const int _maxConcurrentRequests = 3;

  @override
  Future<List<HadithBookModel>> fetchBooks() async {
    final url = Uri.parse('https://hadithapi.com/api/books?apiKey=$apiKey');
    final response = await client
        .get(url)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List booksJson = (data['books'] as List?) ?? [];
      return booksJson
          .map((json) => HadithBookModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    throw const ServerFailure('Failed to fetch books');
  }

  @override
  Future<List<ChapterOfBookModel>> fetchChapters(String bookSlug) async {
    final url = Uri.parse(
      'https://hadithapi.com/api/$bookSlug/chapters?apiKey=$apiKey',
    );
    final response = await client
        .get(url)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List chaptersJson = (data['chapters'] as List?) ?? [];
      return chaptersJson
          .map(
            (json) => ChapterOfBookModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    }
    throw const ServerFailure('Failed to fetch chapters');
  }

  Uri _buildApiUrl(
    String bookSlug,
    String chapterNumber,
    int page,
  ) => Uri.parse(
    'https://hadithapi.com/api/hadiths/?apiKey=$apiKey&book=$bookSlug&chapter=$chapterNumber&page=$page',
  );

  @override
  Future<List<HadithModel>> fetchHadithsForChapter({
    required String bookSlug,
    required String chapterNumber,
  }) async {
    final firstPageUrl = _buildApiUrl(bookSlug, chapterNumber, 1);
    final firstResponse = await client
        .get(firstPageUrl)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (firstResponse.statusCode != 200) {
      throw ServerFailure(
        'Failed to load hadiths: ${firstResponse.statusCode}',
      );
    }

    final firstData = await compute(_decodeJson, firstResponse.body);
    final hadithsMap = firstData['hadiths'] as Map<String, dynamic>? ?? {};
    final int totalPages = (hadithsMap['last_page'] as int?) ?? 1;
    final List firstHadiths = (hadithsMap['data'] as List?) ?? [];

    final allHadiths = <HadithModel>[
      ...firstHadiths.map(
        (e) => HadithModel.fromJson(e as Map<String, dynamic>),
      ),
    ];

    if (totalPages > 1) {
      await _fetchRemainingPages(
        bookSlug,
        chapterNumber,
        totalPages,
        allHadiths,
      );
    }

    return allHadiths;
  }

  Future<void> _fetchRemainingPages(
    String bookSlug,
    String chapterNumber,
    int totalPages,
    List<HadithModel> allHadiths,
  ) async {
    final remainingPages = List.generate(totalPages - 1, (i) => i + 2);

    for (var i = 0; i < remainingPages.length; i += _maxConcurrentRequests) {
      final chunk = remainingPages.sublist(
        i,
        i + _maxConcurrentRequests > remainingPages.length
            ? remainingPages.length
            : i + _maxConcurrentRequests,
      );

      final requests = chunk
          .map(
            (page) => client
                .get(_buildApiUrl(bookSlug, chapterNumber, page))
                .timeout(const Duration(seconds: _timeoutSeconds)),
          )
          .toList();

      final responses = await Future.wait(requests);

      for (final response in responses) {
        if (response.statusCode == 200) {
          final data = await compute(_decodeJson, response.body);
          final hadithsMap = data['hadiths'] as Map<String, dynamic>? ?? {};
          final List hadithsJson = (hadithsMap['data'] as List?) ?? [];
          allHadiths.addAll(
            hadithsJson
                .map((e) => HadithModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        }
      }

      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  Future<Map<String, dynamic>> fetchRandomHadithPage(
    String bookSlug,
    String chapterNumber,
  ) async {
    final firstPageUrl = _buildApiUrl(bookSlug, chapterNumber, 1);
    final firstPageResponse = await client
        .get(firstPageUrl)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (firstPageResponse.statusCode != 200) {
      throw const ServerFailure('Failed to fetch hadiths for random hadith');
    }

    final firstPageData = await compute(_decodeJson, firstPageResponse.body);
    final hadithsMap = firstPageData['hadiths'] as Map<String, dynamic>? ?? {};
    final int totalPages = (hadithsMap['last_page'] as int?) ?? 1;

    return {'firstPageData': firstPageData, 'totalPages': totalPages};
  }

  @override
  Future<Map<String, dynamic>> fetchSpecificHadithPage(
    String bookSlug,
    String chapterNumber,
    int page,
  ) async {
    final targetPageUrl = _buildApiUrl(bookSlug, chapterNumber, page);
    final targetPageResponse = await client
        .get(targetPageUrl)
        .timeout(const Duration(seconds: _timeoutSeconds));
    if (targetPageResponse.statusCode != 200) {
      throw const ServerFailure('Failed to fetch random page of hadiths');
    }
    return await compute(_decodeJson, targetPageResponse.body);
  }
}

Map<String, dynamic> _decodeJson(String body) =>
    json.decode(body) as Map<String, dynamic>;
