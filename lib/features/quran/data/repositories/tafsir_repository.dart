import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TafsirRepository {
  TafsirRepository({http.Client? client}) : _client = client;

  final http.Client? _client;
  final Map<String, String> _cache = {};

  http.Client get _httpClient => _client ?? http.Client();

  /// 🕌 قائمة المفسرين المدعومين
  static const List<Map<String, dynamic>> tafasirList = [
    {
      'id': 1,
      'slug': 'ar-tafsir-muyassar',
      'name_ar': 'تفسير الميسر',
      'name_en': 'Tafsir Al-Muyassar',
    },
    {
      'id': 4,
      'slug': 'ar-tafsir-ibn-kathir',
      'name_ar': 'تفسير ابن كثير',
      'name_en': 'Tafsir Ibn Kathir',
    },
    {
      'id': 7,
      'slug': 'ar-tafseer-al-qurtubi',
      'name_ar': 'تفسير القرطبي',
      'name_en': 'Tafsir Al-Qurtubi',
    },
    {
      'id': 8,
      'slug': 'ar-tafsir-al-tabari',
      'name_ar': 'تفسير الطبري',
      'name_en': 'Tafsir At-Tabari',
    },
  ];

  static const Map<int, String> _slugMap = {
    1: 'ar-tafsir-muyassar',
    4: 'ar-tafsir-ibn-kathir',
    7: 'ar-tafseer-al-qurtubi',
    8: 'ar-tafsir-al-tabari',
  };

  /// ✅ جلب التفسير من API (مع الدعم الاحتياطي عبر Cloudflare CDN و QuranEnc)
  Future<String?> fetchTafsirById(int tafsirId, int surah, int ayah) async {
    final cacheKey = '$tafsirId-$surah-$ayah';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final slug = _slugMap[tafsirId] ?? 'ar-tafsir-muyassar';

    // 1. الأساسي: Quran.com Cloudflare CDN (HTTPS - فائق السرعة ومتاح عالمياً بدون حجب)
    try {
      final quranCdnUrl = Uri.parse(
        'https://api.qurancdn.com/api/v4/tafsirs/$slug/by_ayah/$surah:$ayah',
      );
      final response = await _httpClient
          .get(quranCdnUrl)
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic> && decoded['tafsir'] is Map) {
          final rawText = (decoded['tafsir'] as Map)['text']?.toString() ?? '';
          final clean = _cleanTafsirText(rawText);
          if (clean.isNotEmpty) {
            _cache[cacheKey] = clean;
            return clean;
          }
        }
      }
    } on Object catch (e) {
      debugPrint('QuranCDN Tafsir error: $e');
    }

    // 2. احتياطي 1: QuranEnc (مجمع الملك فهد - HTTPS)
    if (tafsirId == 1) {
      try {
        final quranEncUrl = Uri.parse(
          'https://quranenc.com/api/v1/translation/aya/arabic_moyassar/$surah/$ayah',
        );
        final response = await _httpClient
            .get(quranEncUrl)
            .timeout(const Duration(seconds: 8));

        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic> && decoded['result'] is Map) {
            final rawText =
                (decoded['result'] as Map)['translation']?.toString() ?? '';
            final clean = _cleanTafsirText(rawText);
            if (clean.isNotEmpty) {
              _cache[cacheKey] = clean;
              return clean;
            }
          }
        }
      } on Object catch (e) {
        debugPrint('QuranEnc fallback error: $e');
      }
    }

    // 3. احتياطي 2: quran-tafseer.com القديم
    try {
      final legacyUrl = Uri.parse(
        'http://api.quran-tafseer.com/tafseer/$tafsirId/$surah/$ayah',
      );
      final response = await _httpClient
          .get(legacyUrl)
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        var text = '';
        if (decoded is Map) {
          text = decoded['text']?.toString().trim() ?? '';
        } else if (decoded is List && decoded.isNotEmpty) {
          final first = decoded.first;
          if (first is Map) {
            text = first['text']?.toString().trim() ?? '';
          }
        }
        final clean = _cleanTafsirText(text);
        if (clean.isNotEmpty) {
          _cache[cacheKey] = clean;
          return clean;
        }
      }
    } on Object catch (e) {
      debugPrint('Legacy Tafsir API error: $e');
    }

    return 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.';
  }

  String _cleanTafsirText(String raw) => raw
      .replaceAll(RegExp('<[^>]*>'), '')
      .replaceAll('&quot;', '"')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
