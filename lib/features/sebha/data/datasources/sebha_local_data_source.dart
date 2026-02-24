import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/zikr_model.dart';

abstract class SebhaLocalDataSource {
  Future<List<ZikrModel>> getCustomAzkar();
  Future<bool> saveCustomZikr(ZikrModel zikr);
  Future<bool> updateCustomZikr(ZikrModel zikr);
  Future<bool> deleteCustomZikr(String id);
}

class SebhaLocalDataSourceImpl implements SebhaLocalDataSource {
  static const String _customAzkarKey = 'custom_azkar';

  List<ZikrModel>? _cache;

  @override
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
      throw const CacheException();
    }
  }

  @override
  Future<bool> saveCustomZikr(ZikrModel zikr) async {
    try {
      final customAzkar = await getCustomAzkar();
      customAzkar.add(zikr);
      _cache = customAzkar;
      return await _saveAllCustomAzkar(customAzkar);
    } catch (e) {
      throw const CacheException();
    }
  }

  @override
  Future<bool> updateCustomZikr(ZikrModel zikr) async {
    try {
      final customAzkar = await getCustomAzkar();
      final index = customAzkar.indexWhere((z) => z.id == zikr.id);

      if (index == -1) {
        return false;
      }

      customAzkar[index] = zikr;
      _cache = customAzkar;
      return await _saveAllCustomAzkar(customAzkar);
    } catch (e) {
      throw const CacheException();
    }
  }

  @override
  Future<bool> deleteCustomZikr(String id) async {
    try {
      final customAzkar = await getCustomAzkar();
      customAzkar.removeWhere((z) => z.id == id);
      _cache = customAzkar;
      return await _saveAllCustomAzkar(customAzkar);
    } catch (e) {
      throw const CacheException();
    }
  }

  Future<bool> _saveAllCustomAzkar(List<ZikrModel> azkar) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = azkar.map((z) => z.toJson()).toList();
      final jsonString = json.encode(jsonList);
      return await prefs.setString(_customAzkarKey, jsonString);
    } catch (e) {
      throw const CacheException();
    }
  }
}
