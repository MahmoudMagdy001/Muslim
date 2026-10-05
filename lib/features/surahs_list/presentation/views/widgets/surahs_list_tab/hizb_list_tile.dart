import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/surahs_list/data/models/hizb_model.dart';
import 'package:quran/quran.dart' as quran;

/// Modern Islamic Luxury Tile for presenting a Hizb in the list
class HizbListTile extends StatelessWidget {
  const HizbListTile({
    required this.hizb,
    required this.onTap,
    super.key,
  });

  final HizbModel hizb;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;
    final colors = context.colors;
    final startSurahName = hizb.getStartSurahName(isArabic: isArabic);
    final endSurahName = hizb.getEndSurahName(isArabic: isArabic);
    final pageNumber = quran.getPageNumber(hizb.startSurah, hizb.startAyah);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: context.radius.mdBorder,
        border: Border.all(
          color: colors.border,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: colors.isDark ? 0.25 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.mdBorder,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                // Hizb Number Badge with Islamic star marker
                SizedBox(
                  width: 44.r,
                  height: 44.r,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/quran/marker.png',
                        width: 44.r,
                        height: 44.r,
                        cacheWidth: 132,
                        cacheHeight: 132,
                        color: colors.secondary,
                      ),
                      Text(
                        isArabic
                            ? convertToArabicNumbers(hizb.number.toString())
                            : hizb.number.toString(),
                        style: GoogleFonts.cairo(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.hizbNumberLabel(hizb.number),
                        style: GoogleFonts.amiri(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        isArabic
                            ? '$startSurahName: ${convertToArabicNumbers(hizb.startAyah.toString())} - $endSurahName: ${convertToArabicNumbers(hizb.endAyah.toString())}'
                            : '$startSurahName: ${hizb.startAyah} - $endSurahName: ${hizb.endAyah}',
                        style: context.typography.bodySmall.copyWith(
                          color: colors.textSecondary,
                          fontSize: 11.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Page number chip & arrow
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: colors.border,
                      width: 0.6,
                    ),
                  ),
                  child: Text(
                    isArabic
                        ? 'ص ${convertToArabicNumbers(pageNumber.toString())}'
                        : 'p. $pageNumber',
                    style: GoogleFonts.cairo(
                      fontSize: 10.5.sp,
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: colors.textSecondary.withValues(alpha: 0.4),
                  size: 13.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
