import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/quran/presentation/models/quran_reader_settings.dart';
import 'package:quran/quran.dart' as quran;

/// Luxury ornamental header displayed when a new Surah begins on a Mushaf page
class SurahHeaderBanner extends StatelessWidget {
  const SurahHeaderBanner({
    required this.surahNumber,
    required this.readerTheme,
    super.key,
  });

  final int surahNumber;
  final QuranReaderTheme readerTheme;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final surahName = isArabic
        ? quran.getSurahNameArabic(surahNumber)
        : quran.getSurahName(surahNumber);
    final verseCount = quran.getVerseCount(surahNumber);
    final isMeccan = quran.getPlaceOfRevelation(surahNumber).toLowerCase().contains('makk');

    final locationText = isArabic
        ? (isMeccan ? 'مكية' : 'مدنية')
        : (isMeccan ? 'Meccan' : 'Medinan');

    final verseCountText = isArabic
        ? '${convertToArabicNumbers(verseCount.toString())} آيات'
        : '$verseCount verses';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: readerTheme == QuranReaderTheme.emeraldNight
                ? [
                    const Color(0xFF1B3D34),
                    const Color(0xFF132B25),
                  ]
                : [
                    const Color(0xFF143B33),
                    const Color(0xFF1B4E44),
                  ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: readerTheme.surahHeaderBorder.withValues(alpha: 0.8),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Right badge: Verses count
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: const Color(0xFFC59F48).withValues(alpha: 0.4),
                  width: 0.6,
                ),
              ),
              child: Text(
                verseCountText,
                style: GoogleFonts.cairo(
                  fontSize: 10.5.sp,
                  color: const Color(0xFFF1E4C3),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Center: Surah Name with calligraphy feel
            Expanded(
              child: Text(
                isArabic ? 'سُورَةُ $surahName' : 'Surah $surahName',
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFE082),
                  height: 1.4,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),

            // Left badge: Place of revelation
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: const Color(0xFFC59F48).withValues(alpha: 0.4),
                  width: 0.6,
                ),
              ),
              child: Text(
                locationText,
                style: GoogleFonts.cairo(
                  fontSize: 10.5.sp,
                  color: const Color(0xFFF1E4C3),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
