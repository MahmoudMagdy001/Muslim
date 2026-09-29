import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';

class NameOfAllahCard extends StatelessWidget {
  const NameOfAllahCard({
    required this.data,
    required this.index,
    required this.isSharing,
    required this.onShare,
    super.key,
  });

  final NameOfAllahEntity data;
  final int index;
  final bool isSharing;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;
    final colors = context.colors;

    final name = isArabic ? data.name : data.nameTranslation;
    final text = isArabic ? data.text : data.textTranslation;

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              // Index Emblem with Islamic star background
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
                          ? convertToArabicNumbers((index + 1).toString())
                          : (index + 1).toString(),
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

              // Name & Meaning
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: context.typography.titleLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${l10n.meaningLabel}: $text',
                      style: context.typography.bodySmall.copyWith(
                        color: colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              if (isSharing)
                SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.r,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.secondary),
                  ),
                )
              else
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    color: colors.secondary,
                    size: 20.r,
                  ),
                  onPressed: onShare,
                  tooltip: isArabic ? 'مشاركة' : 'Share',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
