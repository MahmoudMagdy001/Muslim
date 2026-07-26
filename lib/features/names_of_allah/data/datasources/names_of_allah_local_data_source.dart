import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/features/names_of_allah/data/models/name_of_allah_model.dart';

abstract class NamesOfAllahLocalDataSource {
  Future<List<NameOfAllahModel>> getNamesOfAllah();
}

class NamesOfAllahLocalDataSourceImpl implements NamesOfAllahLocalDataSource {
  NamesOfAllahLocalDataSourceImpl();

  List<NameOfAllahModel>? _cache;

  @override
  Future<List<NameOfAllahModel>> getNamesOfAllah() async {
    // ponytail: return cached list to avoid re-parsing JSON on every view mount
    if (_cache != null) return _cache!;
    try {
      final response = await rootBundle.loadString(
        'assets/json/names_of_allah.json',
      );
      final data = await json.decode(response);
      _cache = (data as List)
          .map((e) => NameOfAllahModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return _cache!;
    } on Object catch (_) {
      throw const CacheException();
    }
  }
}
