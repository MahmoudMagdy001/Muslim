import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TafsirRepository {
  /// 🕌 قائمة المفسرين المدعومين
  static const List<Map<String, dynamic>> tafasirList = [
    {'id': 1, 'name_ar': 'تفسير الميسر', 'name_en': 'Tafsir Al-Muyassar'},
    {'id': 4, 'name_ar': 'تفسير ابن كثير', 'name_en': 'Tafsir Ibn Kathir'},
    {'id': 7, 'name_ar': 'تفسير القرطبي', 'name_en': 'Tafsir Al-Qurtubi'},
    {'id': 8, 'name_ar': 'تفسير الطبري', 'name_en': 'Tafsir At-Tabari'},
  ];

  /// ✅ جلب التفسير من API
  Future<String?> fetchTafsirById(int tafsirId, int surah, int ayah) async {
    try {
      final url = Uri.parse(
        'http://api.quran-tafseer.com/tafseer/$tafsirId/$surah/$ayah/$ayah',
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        return 'حدث خطأ أثناء تحميل التفسير (${response.statusCode}).';
      }

      final List<dynamic> data = jsonDecode(response.body);

      if (data.isEmpty) {
        return 'لم يتم العثور على تفسير لهذه الآية.';
      }

      final tafsir = data.first;

      // ignore: avoid_dynamic_calls
      final text = tafsir['text']?.toString().trim() ?? '';
      return text.isNotEmpty ? text : 'لم يتم العثور على تفسير لهذه الآية.';
    } catch (e) {
      debugPrint('===========> $e');
      return 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.';
    }
  }
}
