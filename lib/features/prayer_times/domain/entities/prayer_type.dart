import 'package:muslim/l10n/app_localizations.dart';

/// Strongly-typed enum representing the daily prayers.
///
/// Replaces raw string prayer names throughout the prayer_times feature.
enum PrayerType {
  fajr('Fajr', 'الفجر', 1),
  sunrise('Sunrise', 'الشروق', 6, hasAzan: false),
  dhuhr('Dhuhr', 'الظهر', 2),
  asr('Asr', 'العصر', 3),
  maghrib('Maghrib', 'المغرب', 4),
  isha('Isha', 'العشاء', 5),
  jumuah('Jumuah', 'الجمعة', 7, hasAzan: false);

  const PrayerType(this.id, this.arabicName, this.notificationIndex, {this.hasAzan = true});

  /// English identifier used in maps and persistence (e.g. 'Fajr').
  final String id;

  /// Arabic display name (e.g. 'الفجر').
  final String arabicName;

  /// Unique index used for notification ID generation.
  final int notificationIndex;

  /// Whether this prayer has an azan (call to prayer).
  ///
  /// Sunrise does not have an azan and should not trigger notifications.
  final bool hasAzan;

  /// Resolve a [PrayerType] from its [id] string.
  /// Returns `null` if no match is found.
  static PrayerType? fromId(String id) {
    for (final type in values) {
      if (type.id == id) return type;
    }
    return null;
  }

  /// Returns the localized display name using AppLocalizations.
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case PrayerType.fajr:
        return l10n.fajr;
      case PrayerType.sunrise:
        return l10n.sunrise;
      case PrayerType.dhuhr:
        return l10n.dhuhr;
      case PrayerType.asr:
        return l10n.asr;
      case PrayerType.maghrib:
        return l10n.maghrib;
      case PrayerType.isha:
        return l10n.isha;
      case PrayerType.jumuah:
        return l10n.jumuah;
    }
  }

  /// Returns the localized display name based on [isArabic].
  String displayName({bool isArabic = true}) => isArabic ? arabicName : id;
}
