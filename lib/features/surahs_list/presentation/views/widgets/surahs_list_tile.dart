import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/surahs_list/data/models/surahs_list_model.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({
    required this.surah,
    required this.onTap,
    super.key,
  });

  final SurahsListModel surah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;
    final colors = context.colors;

    final isMeccan = surah.locationArabic.contains('مك') ||
        surah.locationArabic.toLowerCase().contains('makk');

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.mdBorder,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // Surah Number Emblem with Islamic star marker
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
                            ? convertToArabicNumbers(surah.number.toString())
                            : surah.number.toString(),
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

                // Surah Name and Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        surah.surahName,
                        style: context.typography.titleMedium.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 1.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: isMeccan
                                  ? colors.secondary.withValues(alpha: 0.12)
                                  : colors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              surah.locationArabic,
                              style: context.typography.caption.copyWith(
                                color: isMeccan ? colors.secondary : colors.primary,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            l10n.versesCount(surah.ayahCount),
                            style: context.typography.bodySmall.copyWith(
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
      ),
    );
  }
}
