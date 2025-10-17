import 'package:intl/intl.dart';

String convertToArabicNumbers(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', ','];
  String result = input;
  for (int i = 0; i < english.length; i++) {
    result = result.replaceAll(english[i], arabic[i]);
  }
  return result;
}

String getArabicMonthName(int month) {
  switch (month) {
    case 1:
      return 'محرم';
    case 2:
      return 'صفر';
    case 3:
      return 'ربيع الأول';
    case 4:
      return 'ربيع الآخر';
    case 5:
      return 'جمادى الأولى';
    case 6:
      return 'جمادى الآخرة';
    case 7:
      return 'رجب';
    case 8:
      return 'شعبان';
    case 9:
      return 'رمضان';
    case 10:
      return 'شوال';
    case 11:
      return 'ذو القعدة';
    case 12:
      return 'ذو الحجة';
    default:
      return '';
  }
}

String formatTo12Hour(String time24) {
  try {
    final date = DateFormat('HH:mm').parse(time24);
    final formatted = DateFormat('hh:mm a').format(date);
    return convertToArabicNumbers(
      formatted.replaceAll('AM', 'ص').replaceAll('PM', 'م'),
    );
  } catch (e) {
    return time24;
  }
}
