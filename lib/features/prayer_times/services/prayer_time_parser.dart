/// Parses prayer time strings (e.g. '05:23') into [DateTime] objects.
class PrayerTimeParser {
  /// Parses a 24-hour time string and combines it with [date].
  ///
  /// Example: parse('05:23', DateTime(2024, 1, 15)) → DateTime(2024, 1, 15, 5, 23).
  /// Returns `null` if the format is invalid.
  DateTime? parse(String timeStr, DateTime date) {
    if (timeStr == '--:--') return null;

    final parts = timeStr.split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
