import 'package:quran/quran.dart' as quran;
import '../model/search_model.dart';

class QuranSearchService {
  /// إزالة التشكيل من النصوص العربية
  String normalizeArabic(String input) {
    final diacritics = RegExp(r'[\u0617-\u061A\u064B-\u0652]');
    final additionalMarks = RegExp(r'[\u0653-\u0658\u0670\u0671\u06D6-\u06ED]');
    final quranSymbols = RegExp(r'[\u06DD-\u06ED]');
    return input
        .replaceAll(diacritics, '')
        .replaceAll(additionalMarks, '')
        .replaceAll(quranSymbols, '');
  }

  /// البحث في القرآن
  /// partial = true -> البحث الجزئي داخل الكلمة
  /// partial = false -> البحث عن الكلمة بالكامل
  List<SearchResult> search(String keyword, {bool partial = true}) {
    if (keyword.trim().isEmpty) return [];

    final normalizedKeyword = normalizeArabic(keyword.trim());
    final results = <SearchResult>[];

    // 1. البحث في أسماء السور
    for (int surah = 1; surah <= 114; surah++) {
      final surahName = quran.getSurahNameArabic(surah);
      final normalizedSurahName = normalizeArabic(surahName);

      if (normalizedSurahName.contains(normalizedKeyword)) {
        results.add(
          SearchResult(
            surahNumber: surah,
            verseNumber: 0,
            surahName: surahName,
            ayahText: '',
            isSurah: true,
          ),
        );
      }
    }

    // 2. البحث في الآيات
    for (int surah = 1; surah <= 114; surah++) {
      final totalAyahs = quran.getVerseCount(surah);

      for (int verse = 1; verse <= totalAyahs; verse++) {
        final ayah = quran.getVerse(surah, verse);
        final normalizedAyah = normalizeArabic(ayah);

        bool matches;
        if (partial) {
          matches = normalizedAyah.contains(normalizedKeyword);
        } else {
          final words = normalizedAyah.split(RegExp(r'\s+'));
          matches = words.contains(normalizedKeyword);
        }

        if (matches) {
          results.add(
            SearchResult(
              surahNumber: surah,
              verseNumber: verse,
              surahName: quran.getSurahNameArabic(surah),
              ayahText: ayah,
            ),
          );
        }
      }
    }

    return results;
  }
}
