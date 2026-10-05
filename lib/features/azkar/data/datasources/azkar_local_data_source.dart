import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:muslim/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AzkarLocalDataSource {
  Future<Map<String, dynamic>> loadAzkarFromAssets();
  Future<Map<String, dynamic>?> getAzkarContent(String sourceUrl);
  Future<void> cacheAzkarContent(String sourceUrl, Map<String, dynamic> data);
  Future<void> saveCount(String sourceUrl, int index, int count);
  Future<int?> getCount(String sourceUrl, int index);
  Future<void> clearIfNewDay();
}

class AzkarLocalDataSourceImpl implements AzkarLocalDataSource {
  static const String _lastUpdateDateKey = 'azkar_last_update_date';
  static const String _azkarCountPrefix = 'azkar_count_';
  static const String _azkarContentCachePrefix = 'azkar_cached_content_';

  Map<String, dynamic>? _cache;
  Map<String, dynamic>? _bundledContentCache;
  final Map<String, Map<String, dynamic>> _memoryContentCache = {};

  @override
  Future<Map<String, dynamic>> loadAzkarFromAssets() async {
    // ponytail: return cached map to avoid re-parsing JSON on every view mount
    if (_cache != null) return _cache!;
    try {
      final response = await rootBundle.loadString(
        'assets/json/zekr.json',
      );
      _cache = json.decode(response) as Map<String, dynamic>;
      return _cache!;
    } on Object catch (_) {
      throw const CacheException('Failed to load azkar from cache');
    }
  }

  @override
  Future<Map<String, dynamic>?> getAzkarContent(String sourceUrl) async {
    // 1. Check in-memory cache
    if (_memoryContentCache.containsKey(sourceUrl)) {
      return _memoryContentCache[sourceUrl];
    }

    try {
      // 2. Check bundled local assets (hisn_muslim_content.json)
      _bundledContentCache ??= await _loadBundledContent();
      if (_bundledContentCache != null) {
        final id = _extractIdFromUrl(sourceUrl);
        if (id != null && _bundledContentCache!.containsKey(id)) {
          final content = _bundledContentCache![id] as Map<String, dynamic>;
          _memoryContentCache[sourceUrl] = content;
          return content;
        }
      }

      // 3. Check persistent SharedPreferences cache
      final prefs = await SharedPreferences.getInstance();
      final key = '$_azkarContentCachePrefix${_generateKey(sourceUrl, 0)}';
      final cachedJsonStr = prefs.getString(key);
      if (cachedJsonStr != null) {
        final decoded = json.decode(cachedJsonStr) as Map<String, dynamic>;
        _memoryContentCache[sourceUrl] = decoded;
        return decoded;
      }
    } on Object catch (_) {
      // Ignore cache lookup errors, fallback to remote
    }
    return null;
  }

  @override
  Future<void> cacheAzkarContent(
    String sourceUrl,
    Map<String, dynamic> data,
  ) async {
    try {
      _memoryContentCache[sourceUrl] = data;
      final prefs = await SharedPreferences.getInstance();
      final key = '$_azkarContentCachePrefix${_generateKey(sourceUrl, 0)}';
      await prefs.setString(key, json.encode(data));
    } on Object catch (_) {
      // Cache saving error shouldn't crash the app
    }
  }

  Future<Map<String, dynamic>?> _loadBundledContent() async {
    try {
      final raw = await rootBundle.loadString(
        'assets/json/hisn_muslim_content.json',
      );
      return json.decode(raw) as Map<String, dynamic>;
    } on Object catch (_) {
      return null;
    }
  }

  String? _extractIdFromUrl(String url) {
    final regExp = RegExp(r'/(\d+)\.json');
    final match = regExp.firstMatch(url);
    if (match != null) {
      return match.group(1);
    }
    final fallback = RegExp(r'(\d+)').firstMatch(url);
    return fallback?.group(1);
  }

  @override
  Future<void> saveCount(String sourceUrl, int index, int count) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _generateKey(sourceUrl, index);
      await prefs.setInt(key, count);
    } on Object catch (_) {
      throw const CacheException('Failed to save azkar count');
    }
  }

  @override
  Future<int?> getCount(String sourceUrl, int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _generateKey(sourceUrl, index);
      return prefs.getInt(key);
    } on Object catch (_) {
      throw const CacheException('Failed to get azkar count');
    }
  }

  @override
  Future<void> clearIfNewDay() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = _getTodayString();
      final lastUpdate = prefs.getString(_lastUpdateDateKey);

      if (lastUpdate != today) {
        // Clear all Azkar counts
        final keys = prefs.getKeys();
        final azkarKeys = keys
            .where((k) => k.startsWith(_azkarCountPrefix))
            .toList();

        for (final key in azkarKeys) {
          await prefs.remove(key);
        }

        await prefs.setString(_lastUpdateDateKey, today);
      }
    } on Object catch (_) {
      throw const CacheException('Failed to clear azkar counts');
    }
  }

  String _generateKey(String sourceUrl, int index) {
    // Sanitize URL to use as part of the key
    final sanitizedUrl = sourceUrl.replaceAll(RegExp('[^a-zA-Z0-9]'), '_');
    return '$_azkarCountPrefix${sanitizedUrl}_$index';
  }

  String _getTodayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
