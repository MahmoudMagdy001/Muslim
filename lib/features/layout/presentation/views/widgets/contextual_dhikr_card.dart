import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/azkar/presentation/views/azkar_view.dart';

class ContextualDhikrCard extends StatelessWidget {
  const ContextualDhikrCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colors = context.colors;

    String title;
    String badgeText;
    String subtitle;

    if (hour >= 4 && hour < 12) {
      title = isArabic ? 'أذكار الصباح' : 'Morning Azkar';
      badgeText = isArabic ? 'وقت الصباح المستحب' : 'Recommended: Morning';
      subtitle = isArabic
          ? 'حصن نفسك ليوم مبارك بذكر الله'
          : 'Fortify your day with morning remembrance';
    } else if (hour >= 12 && hour < 20) {
      title = isArabic ? 'أذكار المساء' : 'Evening Azkar';
      badgeText = isArabic ? 'وقت المساء المستحب' : 'Recommended: Evening';
      subtitle = isArabic
          ? 'أمسينا وأمسى الملك لله وحده'
          : 'Evening peace through divine remembrance';
    } else {
      title = isArabic ? 'أذكار النوم والمساء' : 'Night Azkar & Istighfar';
      badgeText = isArabic ? 'سكينة الليل' : 'Nightly Serenity';
      subtitle = isArabic
          ? 'باسمك ربي وضعت جنبي وبك أرفعه'
          : 'Rest in tranquility and divine protection';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: context.radius.lgBorder,
          color: colors.surface,
          border: Border.all(
            color: colors.border,
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  const AzkarView(),
                  type: TransitionType.fade,
                ),
              );
            },
            borderRadius: context.radius.lgBorder,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  // Icon badge frame
                  Container(
                    width: 52.r,
                    height: 52.r,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: colors.secondary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: colors.secondary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Image.asset(
                      'assets/home/azkar.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.brightness_5_rounded,
                        color: colors.secondary,
                        size: 24.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),

                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: colors.secondary.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                badgeText,
                                style: context.typography.caption.copyWith(
                                  color: colors.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.5.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          title,
                          style: context.typography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typography.bodySmall.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Action Button
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      isArabic ? 'اقرأ' : 'Read',
                      style: context.typography.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
