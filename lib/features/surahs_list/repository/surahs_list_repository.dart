import 'package:muslim/features/surahs_list/model/surahs_list_model.dart';

abstract class SurahsListRepository {
  Future<List<SurahsListModel>> getAllSurahs({bool isArabic = true});
  Future<void> saveLastSurah(int surah, {int lastAyah = 1});
  Future<int> getLastSurah();
  Future<int> getLastAyah();
}
