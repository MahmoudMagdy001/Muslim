class SurahsListModel {
  const SurahsListModel({
    required this.number,
    required this.nameArabic,
    required this.ayahCount,
    required this.location,
    required this.locationArabic,
  });

  final int number;
  final String nameArabic;
  final int ayahCount;
  final String location;
  final String locationArabic;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurahsListModel &&
        other.number == number &&
        other.nameArabic == nameArabic &&
        other.ayahCount == ayahCount &&
        other.location == location &&
        other.locationArabic == locationArabic;
  }

  @override
  int get hashCode =>
      Object.hash(number, nameArabic, ayahCount, location, locationArabic);
}
