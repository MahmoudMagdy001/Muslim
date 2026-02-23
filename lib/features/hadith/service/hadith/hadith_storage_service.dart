import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HadithStorageService {
  static const String _savedHadithsKey = 'saved_hadiths';
  static const String _randomHadithKey = 'random_hadith';
  static const String _cachedBooksKey = 'cached_hadith_books';
  static const String _cachedChaptersPrefix = 'cached_hadith_chapters_';

  // ── Saved Hadiths ──────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> loadSavedHadiths() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_savedHadithsKey);

    if (saved == null) return [];

    return List<Map<String, dynamic>>.from(json.decode(saved));
  }

  Future<List<Map<String, dynamic>>> saveHadith(
    Map<String, dynamic> hadithData,
  ) async {
    final savedList = await loadSavedHadiths();
    savedList.add(hadithData);
    await _persistSavedHadiths(savedList);
    return savedList;
  }

  Future<List<Map<String, dynamic>>> removeHadith(String hadithId) async {
    final savedList = await loadSavedHadiths();
    savedList.removeWhere((h) => h['id'].toString() == hadithId);
    await _persistSavedHadiths(savedList);
    return savedList;
  }

  Future<void> _persistSavedHadiths(
    List<Map<String, dynamic>> savedList,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedHadithsKey, json.encode(savedList));
  }

  // ── Hadith of the Day Cache ──────────────────────────────────────────

  Future<void> saveRandomHadith(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    };
    await prefs.setString(_randomHadithKey, json.encode(cacheData));
  }

  Future<Map<String, dynamic>?> getRandomHadith() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_randomHadithKey);
    if (saved == null) return null;

    try {
      final Map<String, dynamic> cacheData = json.decode(saved);
      final timestamp = DateTime.parse(cacheData['timestamp']);
      final now = DateTime.now();

      // Check if it's the same day
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

  // ── Metadata Cache ───────────────────────────────────────────────

  Future<void> saveCachedBooks(List<dynamic> books) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cachedBooksKey, json.encode(books));
  }

  Future<List<dynamic>?> getCachedBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_cachedBooksKey);
    if (saved == null) return null;
    return json.decode(saved) as List<dynamic>;
  }

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

  Future<List<dynamic>?> getCachedChapters(String bookSlug) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('$_cachedChaptersPrefix$bookSlug');
    if (saved == null) return null;
    return json.decode(saved) as List<dynamic>;
  }
}
