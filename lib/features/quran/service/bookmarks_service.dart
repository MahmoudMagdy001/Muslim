import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/bookmark_model.dart';

class BookmarksService {
  static const String _prefsKey = 'ayah_bookmarks_v1';

  Future<List<AyahBookmark>> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString == null || jsonString.isEmpty) return [];

    final List<dynamic> list = json.decode(jsonString);
    return list
        .map((e) => AyahBookmark.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveBookmarks(List<AyahBookmark> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(bookmarks.map((b) => b.toJson()).toList());
    await prefs.setString(_prefsKey, encoded);
    debugPrint(encoded);
  }
}
