import '../../../core/utils/format_helper.dart';

String formatTimeLeft(Duration timeLeft) {
  if (timeLeft.isNegative) return '0 ثانية';

  final h = timeLeft.inHours;
  final m = timeLeft.inMinutes.remainder(60);
  final s = timeLeft.inSeconds.remainder(60);

  final parts = <String>[];

  if (h > 0) parts.add('${convertToArabicNumbers(h.toString())} ساعة');
  if (m > 0) parts.add('${convertToArabicNumbers(m.toString())} دقيقة');
  if (s > 0) parts.add('${convertToArabicNumbers(s.toString())} ثانية');

  return parts.join(' و ');
}
