  import '../../../core/utils/format_helper.dart';

String formatTimeLeft(Duration timeLeft) {
    if (timeLeft.isNegative) return convertToArabicNumbers('00:00:00');
    final h = timeLeft.inHours.toString().padLeft(2, '0');
    final m = timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0');
    return convertToArabicNumbers('$h:$m:$s');
  }