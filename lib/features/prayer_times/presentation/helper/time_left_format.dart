import '../../../../../core/utils/format_helper.dart';

String formatTimeLeft(Duration timeLeft, bool isArabic) {
  if (timeLeft.isNegative) {
    return isArabic ? '٠٠:٠٠:٠٠' : '00:00:00';
  }

  final h = timeLeft.inHours;
  final m = timeLeft.inMinutes.remainder(60);
  final s = timeLeft.inSeconds.remainder(60);

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final digitalTime = '${twoDigits(h)}:${twoDigits(m)}:${twoDigits(s)}';

  if (isArabic) {
    return convertToArabicNumbers(digitalTime);
  }
  return digitalTime;
}
