class SearchResult {
  SearchResult({
    required this.surahNumber,
    required this.verseNumber,
    required this.surahName,
    required this.ayahText,
    this.isSurah = false,
  });
  final int surahNumber;
  final int verseNumber;
  final String surahName;
  final String ayahText;
  final bool isSurah;
}
