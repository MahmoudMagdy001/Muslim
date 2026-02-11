/// Strongly-typed enum representing the five daily prayers.
///
/// Replaces raw string prayer names throughout the prayer_times feature.
enum PrayerType {
  fajr('Fajr', 'الفجر', 1),
  dhuhr('Dhuhr', 'الظهر', 2),
  asr('Asr', 'العصر', 3),
  maghrib('Maghrib', 'المغرب', 4),
  isha('Isha', 'العشاء', 5);

  const PrayerType(this.id, this.arabicName, this.notificationIndex);

  /// English identifier used in maps and persistence (e.g. 'Fajr').
  final String id;

  /// Arabic display name (e.g. 'الفجر').
  final String arabicName;

  /// Unique index (1-5) used for notification ID generation.
  final int notificationIndex;

  /// Resolve a [PrayerType] from its [id] string.
  /// Returns `null` if no match is found.
  static PrayerType? fromId(String id) {
    for (final type in values) {
      if (type.id == id) return type;
    }
    return null;
  }

  /// Returns the localized display name based on [isArabic].
  String displayName({required bool isArabic}) => isArabic ? arabicName : id;
}
