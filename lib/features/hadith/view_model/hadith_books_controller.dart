import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../model/hadith_book_model.dart';
import '../helper/hadith_helper.dart';

class HadithBooksController extends ChangeNotifier {
  HadithBooksController() {
    _booksFuture = _fetchBooks();
  }
  final String _apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  late Future<List<HadithBookModel>> _booksFuture;
  Future<List<HadithBookModel>> get booksFuture => _booksFuture;

  String _searchText = '';
  String get searchText => _searchText;

  void refreshBooks() {
    _booksFuture = _fetchBooks();
    notifyListeners();
  }

  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<List<HadithBookModel>> _fetchBooks() async {
    try {
      final url = Uri.parse('https://hadithapi.com/api/books?apiKey=$_apiKey');
      final response = await http.get(url).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> booksJson = data['books'] as List<dynamic>? ?? [];
        return booksJson
            .map(
              (json) => HadithBookModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception('فشل في جلب الكتب: ${response.statusCode}');
      }
    } catch (e) {
      if (e is http.ClientException ||
          e.toString().contains('SocketException') ||
          e is TimeoutException) {
        return [];
      }
      rethrow;
    }
  }

  List<HadithBookModel> filterBooks(
    List<HadithBookModel> books,
    String languageCode,
  ) {
    if (_searchText.trim().isEmpty) return books;

    final query = _searchText.trim().toLowerCase();
    final isArabicUI = languageCode == 'ar';

    return books.where((b) {
      // الاسم والكاتب حسب لغة الواجهة
      final name = isArabicUI
          ? (booksArabic[b.bookName] ?? b.bookName)
          : b.bookName;
      final writer = isArabicUI
          ? (writersArabic[b.writerName] ?? b.writerName)
          : b.writerName;

      // تحويلهم لـ lowercase للمقارنة غير الحساسة للحروف
      final nameLower = name.toLowerCase();
      final writerLower = writer.toLowerCase();

      return nameLower.contains(query) || writerLower.contains(query);
    }).toList();
  }
}
