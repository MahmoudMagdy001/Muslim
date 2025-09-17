import '../model/surahs_list_model.dart';

abstract class SurahsListRepository {
  Future<List<SurahsListModel>> getAllSurahs();
  Future<void> saveLastSurah(int surah, {int lastAyah = 1});
  Future<int> getLastSurah();
  Future<int> getLastAyah();
}
