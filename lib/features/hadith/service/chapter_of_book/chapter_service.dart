import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/chapter_of_book_model.dart';

class ChapterOfBookService {
  const ChapterOfBookService();
  static const String apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  Future<List<ChapterOfBookModel>> fetchChapters(String bookSlug) async {
    try {
      final url = Uri.parse(
        'https://hadithapi.com/api/$bookSlug/chapters?apiKey=$apiKey',
      );
      final response = await http.get(url).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('فشل التحميل: ${response.statusCode}');
      }

      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> chaptersJson =
          data['chapters'] as List<dynamic>? ?? [];

      return chaptersJson
          .map((e) => ChapterOfBookModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is http.ClientException ||
          e.toString().contains('SocketException')) {
        return [];
      }
      rethrow;
    }
  }
}
