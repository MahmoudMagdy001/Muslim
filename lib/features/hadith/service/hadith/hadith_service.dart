// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/di/service_locator.dart';
import '../../model/hadith_model.dart';
import 'hadith_storage_service.dart';

class HadithService {
  static const String apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';
  static const int _timeoutSeconds = 30;
  static const int _maxConcurrentRequests = 3;

  HadithStorageService get _storage => getIt<HadithStorageService>();

  Future<List<HadithModel>> fetchHadithsForChapter({
    required String bookSlug,
    required String chapterNumber,
  }) async {
    try {
      final firstPageUrl = _buildApiUrl(bookSlug, chapterNumber, 1);
      final firstResponse = await http
          .get(firstPageUrl)
          .timeout(const Duration(seconds: _timeoutSeconds));

      if (firstResponse.statusCode != 200) {
        throw Exception('Failed to load hadiths: ${firstResponse.statusCode}');
      }

      // Use compute for JSON decoding
      final firstData = await compute(_decodeJson, firstResponse.body);
      final totalPages = firstData['hadiths']['last_page'] ?? 1;
      final List firstHadiths = firstData['hadiths']['data'] ?? [];

      final allHadiths = <HadithModel>[
        ...firstHadiths.map(
          (e) => HadithModel.fromJson(e as Map<String, dynamic>),
        ),
      ];

      if (totalPages > 1) {
        // تحميل الصفحات المتبقية بشكل متوازي مع تحديد عدد الطلبات المتزامنة
        await _fetchRemainingPages(
          bookSlug,
          chapterNumber,
          totalPages,
          allHadiths,
        );
      }

      return allHadiths;
    } catch (e) {
      if (e is http.ClientException ||
          e.toString().contains('SocketException') ||
          e is TimeoutException) {
        return [];
      }
      throw Exception('Failed to load hadiths: $e');
    }
  }

  Future<void> _fetchRemainingPages(
    String bookSlug,
    String chapterNumber,
    int totalPages,
    List<HadithModel> allHadiths,
  ) async {
    final remainingPages = List.generate(totalPages - 1, (i) => i + 2);

    // تقسيم الطلبات إلى مجموعات لتجنب الضغط على الشبكة
    for (var i = 0; i < remainingPages.length; i += _maxConcurrentRequests) {
      final chunk = remainingPages.sublist(
        i,
        i + _maxConcurrentRequests > remainingPages.length
            ? remainingPages.length
            : i + _maxConcurrentRequests,
      );

      final requests = chunk
          .map(
            (page) => http
                .get(_buildApiUrl(bookSlug, chapterNumber, page))
                .timeout(const Duration(seconds: _timeoutSeconds)),
          )
          .toList();

      final responses = await Future.wait(requests);

      for (final response in responses) {
        if (response.statusCode == 200) {
          // Use compute for JSON decoding
          final data = await compute(_decodeJson, response.body);
          final List hadithsJson = data['hadiths']['data'] ?? [];
          allHadiths.addAll(
            hadithsJson
                .map((e) => HadithModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        }
      }

      // إعطاء فرصة للـ UI للتحديث بين المجموعات
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  Uri _buildApiUrl(
    String bookSlug,
    String chapterNumber,
    int page,
  ) => Uri.parse(
    'https://hadithapi.com/api/hadiths/?apiKey=$apiKey&book=$bookSlug&chapter=$chapterNumber&page=$page',
  );

  Future<List<dynamic>> fetchBooks() async {
    final cached = await _storage.getCachedBooks();
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final url = Uri.parse('https://hadithapi.com/api/books?apiKey=$apiKey');
    final response = await http
        .get(url)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List books = data['books'] ?? [];
      await _storage.saveCachedBooks(books);
      return books;
    }
    throw Exception('Failed to fetch books: ${response.statusCode}');
  }

  Future<List<dynamic>> fetchChapters(String bookSlug) async {
    final cached = await _storage.getCachedChapters(bookSlug);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final url = Uri.parse(
      'https://hadithapi.com/api/$bookSlug/chapters?apiKey=$apiKey',
    );
    final response = await http
        .get(url)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List chapters = data['chapters'] ?? [];
      await _storage.saveCachedChapters(bookSlug, chapters);
      return chapters;
    }
    throw Exception(
      'Failed to fetch chapters for $bookSlug: ${response.statusCode}',
    );
  }

  /// Fetches a random hadith.
  /// Returns a Map containing the [HadithModel], book information, and chapter information.
  Future<Map<String, dynamic>> fetchRandomHadith() async {
    // 1. Check Cache for today's hadith
    final cachedHadith = await _storage.getRandomHadith();
    if (cachedHadith != null) {
      try {
        final hadithMap = cachedHadith['hadith'] as Map<String, dynamic>;
        cachedHadith['hadith'] = HadithModel.fromJson(hadithMap);
        return cachedHadith;
      } catch (e) {
        debugPrint('Error parsing cached hadith: $e');
        // If parsing fails, proceed to fetch a new one
      }
    }

    final random = Random();

    // 2. Fetch Books (Cached or Network)
    final List books = await fetchBooks();
    if (books.isEmpty) {
      throw Exception('No books found');
    }

    // Pick a random book that has hadiths
    final validBooks = books.where((b) {
      final count = int.tryParse(b['hadiths_count']?.toString() ?? '0') ?? 0;
      return count > 0;
    }).toList();
    if (validBooks.isEmpty) {
      throw Exception('No books with hadiths found');
    }
    final book = validBooks[random.nextInt(validBooks.length)];
    final bookSlug = book['bookSlug'];
    final bookName = book['bookName'];

    // 3. Fetch Chapters (Cached or Network)
    final List chapters = await fetchChapters(bookSlug);
    if (chapters.isEmpty) {
      throw Exception('No chapters found for book $bookSlug');
    }

    // Pick a random chapter
    final chapter = chapters[random.nextInt(chapters.length)];
    final chapterNumber = chapter['chapterNumber'].toString();
    final chapterNameAr = chapter['chapterArabic'] ?? '';
    final chapterNameEn = chapter['chapterEnglish'] ?? '';

    // 4. Fetch a random page of Hadiths for that chapter
    final firstPageUrl = _buildApiUrl(bookSlug, chapterNumber, 1);
    final firstPageResponse = await http
        .get(firstPageUrl)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (firstPageResponse.statusCode != 200) {
      throw Exception('Failed to fetch hadiths for random hadith');
    }

    final firstPageData = await compute(_decodeJson, firstPageResponse.body);
    final int totalPages = firstPageData['hadiths']['last_page'] ?? 1;

    Map<String, dynamic> targetPageData;
    final int randomPage = random.nextInt(totalPages) + 1;

    if (randomPage == 1) {
      targetPageData = firstPageData;
    } else {
      final targetPageUrl = _buildApiUrl(bookSlug, chapterNumber, randomPage);
      final targetPageResponse = await http
          .get(targetPageUrl)
          .timeout(const Duration(seconds: _timeoutSeconds));
      if (targetPageResponse.statusCode != 200) {
        throw Exception('Failed to fetch random page of hadiths');
      }
      targetPageData = await compute(_decodeJson, targetPageResponse.body);
    }

    final List hadithsJson = targetPageData['hadiths']['data'] ?? [];
    if (hadithsJson.isEmpty) {
      throw Exception('No hadiths found in selected random page');
    }

    // Pick a random hadith from the selected page
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

    // 5. Cache for today - Convert HadithModel to Map for storage
    try {
      final storageMap = Map<String, dynamic>.from(result);
      storageMap['hadith'] = hadith.toJson();
      await _storage.saveRandomHadith(storageMap);
    } catch (e) {
      debugPrint('Error saving random hadith to cache: $e');
    }

    return result;
  }
}

// Top-level function for compute
Map<String, dynamic> _decodeJson(String body) =>
    json.decode(body) as Map<String, dynamic>;
