// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/hadith_model.dart';

class HadithService {
  static const String apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';
  static const int _timeoutSeconds = 30;
  static const int _maxConcurrentRequests = 3;

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
}

// Top-level function for compute
Map<String, dynamic> _decodeJson(String body) =>
    json.decode(body) as Map<String, dynamic>;
