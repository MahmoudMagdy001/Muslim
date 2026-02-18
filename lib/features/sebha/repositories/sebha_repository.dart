import '../model/zikr_model.dart';
import '../service/sebha_storage_service.dart';

class SebhaRepository {
  SebhaRepository({SebhaStorageService? service})
    : _service = service ?? SebhaStorageService();

  final SebhaStorageService _service;

  Future<List<ZikrModel>> getCustomAzkar() async {
    try {
      return await _service.getCustomAzkar();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveCustomZikr(ZikrModel zikr) async {
    try {
      return await _service.saveCustomZikr(zikr);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateCustomZikr(ZikrModel zikr) async {
    try {
      return await _service.updateCustomZikr(zikr);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteCustomZikr(String id) async {
    try {
      return await _service.deleteCustomZikr(id);
    } catch (e) {
      rethrow;
    }
  }
}
