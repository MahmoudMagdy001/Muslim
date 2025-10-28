import '../../../core/utils/format_helper.dart';

String formatTimeLeft(Duration timeLeft, bool isArabic) {
  if (timeLeft.isNegative) return '0 ثانية';

  final h = timeLeft.inHours;
  final m = timeLeft.inMinutes.remainder(60);
  final s = timeLeft.inSeconds.remainder(60);

  final parts = <String>[];

  if (h > 0) {
    parts.add(
      isArabic ? '${convertToArabicNumbers(h.toString())} ساعة' : '$h hours',
    );
  }
  if (m > 0) {
    parts.add(
      isArabic ? '${convertToArabicNumbers(m.toString())} دقيقة' : '$m minutes',
    );
  }
  if (s > 0) {
    parts.add(
      isArabic ? '${convertToArabicNumbers(s.toString())} ثانية' : '$s seconds',
    );
  }

  return parts.join(isArabic ? ' و ' : ' , ');
}
