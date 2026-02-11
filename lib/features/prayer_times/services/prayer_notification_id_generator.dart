import '../models/prayer_type.dart';

/// Generates unique, deterministic notification IDs for prayer notifications.
///
/// Format: YYYYMMDD + prayer index (1-5).
/// Example: Fajr on 2024-01-15 → 202401151
class PrayerNotificationIdGenerator {
  /// Generates a unique notification ID based on [date] and [prayer].
  int generate(DateTime date, PrayerType prayer) {
    final dateStr =
        '${date.year}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}';

    return int.parse('$dateStr${prayer.notificationIndex}');
  }
}
