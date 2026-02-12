import '../../../../features/surahs_list/model/hizb_model.dart';
import '../../../../features/surahs_list/model/juz_model.dart';

int getJuzForAyah(int surah, int ayah) {
  for (int i = JuzModel.starts.length - 1; i >= 0; i--) {
    final start = JuzModel.starts[i];
    final startSurah = start['surah'] as int;
    final startAyah = start['ayah'] as int;

    if (surah > startSurah || (surah == startSurah && ayah >= startAyah)) {
      return i + 1;
    }
  }
  return 1; // Default to Juz 1
}

int getHizbForAyah(int surah, int ayah) {
  for (int i = HizbModel.starts.length - 1; i >= 0; i--) {
    final start = HizbModel.starts[i];
    final startSurah = start['surah'] as int;
    final startAyah = start['ayah'] as int;

    if (surah > startSurah || (surah == startSurah && ayah >= startAyah)) {
      return i + 1;
    }
  }
  return 1; // Default to Hizb 1
}
