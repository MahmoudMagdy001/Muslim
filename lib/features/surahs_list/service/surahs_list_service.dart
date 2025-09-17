import 'package:quran/quran.dart' as quran;

class SurahsListService {
  String getSurahNameArabic(int surahNumber) =>
      quran.getSurahNameArabic(surahNumber);

  int getVerseCount(int surahNumber) => quran.getVerseCount(surahNumber);

  String getPlaceOfRevelation(int surahNumber) =>
      quran.getPlaceOfRevelation(surahNumber);

  String getLocationArabic(String location) =>
      location == 'Makkah' ? 'مكية' : 'مدنية';
}
