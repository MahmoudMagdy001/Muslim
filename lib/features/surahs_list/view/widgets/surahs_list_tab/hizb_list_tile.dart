import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/surahs_list/model/hizb_model.dart';

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
            color: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radius.mdBorder,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
                    ),
                    Text(
                      isArabic
                          ? convertToArabicNumbers(hizb.number.toString())
                          : hizb.number.toString(),
                      style: context.typography.titleSmall.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
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
                      style: context.typography.titleMedium.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
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
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colors.textSecondary.withValues(alpha: 0.5),
                size: 14.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
