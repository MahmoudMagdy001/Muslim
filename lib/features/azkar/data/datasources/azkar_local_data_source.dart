import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failures.dart';

abstract class AzkarLocalDataSource {
  Future<Map<String, dynamic>> loadAzkarFromAssets();
  Future<void> saveCount(String sourceUrl, int index, int count);
  Future<int?> getCount(String sourceUrl, int index);
  Future<void> clearIfNewDay();
}

class AzkarLocalDataSourceImpl implements AzkarLocalDataSource {
  static const String _lastUpdateDateKey = 'azkar_last_update_date';
  static const String _azkarCountPrefix = 'azkar_count_';

  @override
  Future<Map<String, dynamic>> loadAzkarFromAssets() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/zekr.json',
      );
      return json.decode(response) as Map<String, dynamic>;
    } catch (e) {
      throw const CacheFailure('Failed to load azkar from cache');
    }
  }

  @override
  Future<void> saveCount(String sourceUrl, int index, int count) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _generateKey(sourceUrl, index);
      await prefs.setInt(key, count);
    } catch (e) {
      throw const CacheFailure('Failed to save azkar count');
    }
  }

  @override
  Future<int?> getCount(String sourceUrl, int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _generateKey(sourceUrl, index);
      return prefs.getInt(key);
    } catch (e) {
      throw const CacheFailure('Failed to get azkar count');
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
    } catch (e) {
      throw const CacheFailure('Failed to clear azkar counts');
    }
  }

  String _generateKey(String sourceUrl, int index) {
    // Sanitize URL to use as part of the key
    final sanitizedUrl = sourceUrl.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return '$_azkarCountPrefix${sanitizedUrl}_$index';
  }

  String _getTodayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
