import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/zikr_model.dart';

class SebhaStorageService {
  static const String _customAzkarKey = 'custom_azkar';

  List<ZikrModel>? _cache;

  /// Get all custom azkar from storage (using cache if available)
  Future<List<ZikrModel>> getCustomAzkar() async {
    if (_cache != null) return _cache!;

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_customAzkarKey);

      if (jsonString == null || jsonString.isEmpty) {
        _cache = [];
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      _cache = jsonList
          .map((json) => ZikrModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return _cache!;
    } catch (e) {
      _cache = [];
      return [];
    }
  }

  /// Save a new custom zikr
  Future<bool> saveCustomZikr(ZikrModel zikr) async {
    try {
      final customAzkar = await getCustomAzkar();
      customAzkar.add(zikr);
      _cache = customAzkar; // Update cache
      return await _saveAllCustomAzkar(customAzkar);
    } catch (e) {
      return false;
    }
  }

  /// Update an existing custom zikr
  Future<bool> updateCustomZikr(ZikrModel zikr) async {
    try {
      final customAzkar = await getCustomAzkar();
      final index = customAzkar.indexWhere((z) => z.id == zikr.id);

      if (index == -1) {
        return false;
      }

      customAzkar[index] = zikr;
      _cache = customAzkar; // Update cache
      return await _saveAllCustomAzkar(customAzkar);
    } catch (e) {
      return false;
    }
  }

  /// Delete a custom zikr by ID
  Future<bool> deleteCustomZikr(String id) async {
    try {
      final customAzkar = await getCustomAzkar();
      customAzkar.removeWhere((z) => z.id == id);
      _cache = customAzkar; // Update cache
      return await _saveAllCustomAzkar(customAzkar);
    } catch (e) {
      return false;
    }
  }

  /// Private helper to save all custom azkar
  Future<bool> _saveAllCustomAzkar(List<ZikrModel> azkar) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = azkar.map((z) => z.toJson()).toList();
      final jsonString = json.encode(jsonList);
      return await prefs.setString(_customAzkarKey, jsonString);
    } catch (e) {
      return false;
    }
  }
}
