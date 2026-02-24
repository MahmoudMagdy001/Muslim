import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class HadithLocalDataSource {
  Future<List<Map<String, dynamic>>> loadSavedHadiths();
  Future<void> saveHadith(Map<String, dynamic> hadithData);
  Future<void> removeHadith(String hadithId);

  Future<void> saveRandomHadith(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getRandomHadith();

  Future<void> saveCachedBooks(List<dynamic> books);
  Future<List<dynamic>?> getCachedBooks();

  Future<void> saveCachedChapters(String bookSlug, List<dynamic> chapters);
  Future<List<dynamic>?> getCachedChapters(String bookSlug);
}

class HadithLocalDataSourceImpl implements HadithLocalDataSource {
  const HadithLocalDataSourceImpl();

  static const String _savedHadithsKey = 'saved_hadiths';
  static const String _randomHadithKey = 'random_hadith';
  static const String _cachedBooksKey = 'cached_hadith_books';
  static const String _cachedChaptersPrefix = 'cached_hadith_chapters_';

  @override
  Future<List<Map<String, dynamic>>> loadSavedHadiths() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_savedHadithsKey);

    if (saved == null) return [];

    return List<Map<String, dynamic>>.from(json.decode(saved));
  }

  @override
  Future<void> saveHadith(Map<String, dynamic> hadithData) async {
    final savedList = await loadSavedHadiths();
    savedList.add(hadithData);
    await _persistSavedHadiths(savedList);
  }

  @override
  Future<void> removeHadith(String hadithId) async {
    final savedList = await loadSavedHadiths();
    savedList.removeWhere((h) => h['id'].toString() == hadithId);
    await _persistSavedHadiths(savedList);
  }

  Future<void> _persistSavedHadiths(
    List<Map<String, dynamic>> savedList,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedHadithsKey, json.encode(savedList));
  }

  @override
  Future<void> saveRandomHadith(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    };
    await prefs.setString(_randomHadithKey, json.encode(cacheData));
  }

  @override
  Future<Map<String, dynamic>?> getRandomHadith() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_randomHadithKey);
    if (saved == null) return null;

    try {
      final Map<String, dynamic> cacheData = json.decode(saved);
      final timestamp = DateTime.parse(cacheData['timestamp']);
      final now = DateTime.now();

      if (timestamp.year == now.year &&
          timestamp.month == now.month &&
          timestamp.day == now.day) {
        return Map<String, dynamic>.from(cacheData['data']);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<void> saveCachedBooks(List<dynamic> books) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cachedBooksKey, json.encode(books));
  }

  @override
  Future<List<dynamic>?> getCachedBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_cachedBooksKey);
    if (saved == null) return null;
    return json.decode(saved) as List<dynamic>;
  }

  @override
  Future<void> saveCachedChapters(
    String bookSlug,
    List<dynamic> chapters,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_cachedChaptersPrefix$bookSlug',
      json.encode(chapters),
    );
  }

  @override
  Future<List<dynamic>?> getCachedChapters(String bookSlug) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('$_cachedChaptersPrefix$bookSlug');
    if (saved == null) return null;
    return json.decode(saved) as List<dynamic>;
  }
}
