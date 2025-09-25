class AyahBookmark {
  AyahBookmark({
    required this.surahNumber,
    required this.ayahNumber,
    required this.timestampMs,
    required this.ayahText,
  });

  factory AyahBookmark.fromJson(Map<String, dynamic> json) => AyahBookmark(
    surahNumber: json['surah'] as int,
    ayahNumber: json['ayah'] as int,
    timestampMs: json['ts'] as int,
    ayahText: json['ayahText'] as String,
  );

  final int surahNumber;
  final int ayahNumber;
  final int timestampMs;
  final String ayahText;

  Map<String, dynamic> toJson() => {
    'surah': surahNumber,
    'ayah': ayahNumber,
    'ts': timestampMs,
    'ayahText': ayahText,
  };
}
