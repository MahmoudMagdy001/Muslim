import '../models/azkar_model.dart';
import '../services/azkar_service.dart';

abstract class AzkarRepository {
  Future<List<AzkarModel>> getAzkarList();
  Future<List<AzkarContentModel>> getAzkarContent(String url);
}

class AzkarRepositoryImpl implements AzkarRepository {
  AzkarRepositoryImpl(this._service);
  final AzkarService _service;

  @override
  Future<List<AzkarModel>> getAzkarList() async {
    try {
      final json = await _service.loadAzkarFromAssets();
      final List<dynamic> data = json['data'] as List<dynamic>;
      return data
          .map((e) => AzkarModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AzkarContentModel>> getAzkarContent(String url) async {
    try {
      final json = await _service.fetchAzkarContent(url);
      // The API returns a map where the key is the title and value is a list of items
      if (json.isNotEmpty) {
        final List<dynamic> data = json.values.first as List<dynamic>;
        return data
            .map((e) => AzkarContentModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
