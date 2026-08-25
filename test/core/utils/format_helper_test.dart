import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/core/utils/format_helper.dart';

void main() {
  group('FormatHelper Tests', () {
    test('convertToArabicNumbers converts digits and decimal dot correctly', () {
      expect(convertToArabicNumbers('0123456789.'), '٠١٢٣٤٥٦٧٨٩,');
      expect(convertToArabicNumbers('12:30'), '١٢:٣٠');
      expect(convertToArabicNumbers('Test 100'), 'Test ١٠٠');
    });

    test('getArabicMonthName returns correct month name for Hijri months', () {
      expect(getArabicMonthName(1), 'محرم');
      expect(getArabicMonthName(9), 'رمضان');
      expect(getArabicMonthName(12), 'ذو الحجة');
      expect(getArabicMonthName(13), '');
      expect(getArabicMonthName(0), '');
    });

    test('getEnglishHijriMonthName returns correct English names for Hijri months', () {
      expect(getEnglishHijriMonthName(1), 'Muharram');
      expect(getEnglishHijriMonthName(9), 'Ramadan');
      expect(getEnglishHijriMonthName(12), 'Dhul-Hijjah');
      expect(getEnglishHijriMonthName(15), '');
    });

    test('formatTo12Hour formats 24-hour string to English and Arabic 12-hour format', () {
      expect(formatTo12Hour('05:30', isArabic: false), '05:30 AM');
      expect(formatTo12Hour('17:45', isArabic: false), '05:45 PM');
      expect(formatTo12Hour('05:30', isArabic: true), '٠٥:٣٠ ص');
      expect(formatTo12Hour('17:45', isArabic: true), '٠٥:٤٥ م');
      // Invalid format fallback
      expect(formatTo12Hour('invalid', isArabic: false), 'invalid');
    });
  });
}
