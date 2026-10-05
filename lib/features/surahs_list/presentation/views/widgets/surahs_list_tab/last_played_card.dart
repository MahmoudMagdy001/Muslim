import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/quran/presentation/views/utils/quran_position_helper.dart';
import 'package:quran/quran.dart' as quran;

/// Luxury Modern Islamic Hero Card displaying the user's last read position
class LastPlayedCard extends StatelessWidget {
  const LastPlayedCard({
    required this.lastPlayed,
    required this.navigateToSurah,
    super.key,
  });

  final Map<String, dynamic> lastPlayed;
  final Future<void> Function({required int surah, required int ayah})
  navigateToSurah;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final surahNum = lastPlayed['surah'] as int;
    final verseNum = lastPlayed['verse'] as int;
    final surahName = isArabic
        ? quran.getSurahNameArabic(surahNum)
        : quran.getSurahName(surahNum);
    final juzNum = getJuzForAyah(surahNum, verseNum);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      height: 142.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          colors: colors.isDark
              ? [
                  const Color(0xFF1B453A),
                  const Color(0xFF0F2620),
                ]
              : [
                  const Color(0xFF143B33),
                  const Color(0xFF1E5246),
                ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(
          color: colors.secondary.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: colors.isDark ? 0.35 : 0.15),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decorative Quran image
          PositionedDirectional(
            end: -10.w,
            bottom: -6.h,
            top: -6.h,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/quran/image.png',
                fit: BoxFit.contain,
                cacheHeight: 400,
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Badge: "آخر قراءة"
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: colors.secondary.withValues(alpha: 0.4),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bookmark_added_rounded,
                            size: 13.r,
                            color: const Color(0xFFFFD54F),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            isArabic ? 'آخِـرُ تِـلَاوَةٍ' : 'Last Read',
                            style: GoogleFonts.cairo(
                              color: const Color(0xFFFFE082),
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                // Surah Name in Amiri bold
                Text(
                  isArabic ? 'سُورَةُ $surahName' : 'Surah $surahName',
                  style: GoogleFonts.amiri(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 2.h),

                // Ayah and Juz info
                Text(
                  isArabic
                      ? 'الآيَةُ ${convertToArabicNumbers(verseNum.toString())} • الجُزْءُ ${convertToArabicNumbers(juzNum.toString())}'
                      : 'Verse $verseNum • Juz $juzNum',
                  style: GoogleFonts.cairo(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // Continue Reading Button
                InkWell(
                  onTap: () {
                    unawaited(
                      navigateToSurah(
                        surah: surahNum,
                        ayah: verseNum,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFE082),
                          Color(0xFFC59F48),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC59F48).withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isArabic ? 'تَابِعِ التِّلَاوَة' : 'Continue',
                          style: GoogleFonts.cairo(
                            color: const Color(0xFF143B33),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14.r,
                          color: const Color(0xFF143B33),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
