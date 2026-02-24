class HadithEntity {
  const HadithEntity({
    required this.id,
    required this.hadithNumber,
    required this.hadithArabic,
    required this.headingArabic,
    required this.headingEnglish,
    required this.hadithEnglish,
    required this.status,
  });

  final String id;
  final String hadithNumber;
  final String hadithArabic;
  final String hadithEnglish;
  final String headingArabic;
  final String headingEnglish;
  final String status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HadithEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
