import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/surahs_list_model.dart';
import 'surahs_list_repository.dart';

class SurahsListRepositoryImpl implements SurahsListRepository {
  SurahsListRepositoryImpl();

  @override
  Future<List<SurahsListModel>> getAllSurahs({required bool isArabic}) async =>
      List.generate(114, (index) {
        final surahNumber = index + 1;
        final location = quran.getPlaceOfRevelation(surahNumber);

        return SurahsListModel(
          number: surahNumber,
          surahName: isArabic
              ? quran.getSurahNameArabic(surahNumber)
              : quran.getSurahName(surahNumber),
          ayahCount: quran.getVerseCount(surahNumber),
          // location: location,
          locationArabic: isArabic
              ? location == 'Makkah'
                    ? 'مكية'
                    : 'مدنية'
              : location,
        );
      });

  @override
  Future<void> saveLastSurah(int surah, {int lastAyah = 1}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final futures = [
        prefs.setInt('last_surah_number', surah),
        prefs.setInt('last_ayah_number', lastAyah),
        prefs.setString(
          'last_opened_date',
          DateTime.now().toString().split(' ')[0],
        ),
      ];
      await Future.wait(futures);
    } catch (e) {
      throw Exception('Error saving last surah: $e');
    }
  }

  @override
  Future<int> getLastSurah() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_surah_number') ?? 1;
  }

  @override
  Future<int> getLastAyah() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_ayah_number') ?? 1;
  }
}
