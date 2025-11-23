import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HadithStorageService {
  static const String _savedHadithsKey = 'saved_hadiths';

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
}
