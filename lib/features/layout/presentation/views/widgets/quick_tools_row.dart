import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/widgets/section_header.dart';
import 'package:muslim/features/hadith/presentation/views/hadith_books_view.dart';
import 'package:muslim/features/names_of_allah/presentation/views/names_of_allah_screen.dart';
import 'package:muslim/features/qiblah/presentation/views/qiblah_view.dart';
import 'package:muslim/features/zakat/presentation/views/zakat_view.dart';

class QuickToolsRow extends StatelessWidget {
  const QuickToolsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colors = context.colors;

    final tools = [
      _ToolItem(
        title: isArabic ? 'القبلة' : 'Qiblah',
        asset: 'assets/home/qibla.png',
        route: const QiblahView(),
      ),
      _ToolItem(
        title: isArabic ? 'الحديث' : 'Hadith',
        asset: 'assets/home/hadith.png',
        route: const HadithBooksView(),
      ),
      _ToolItem(
        title: isArabic ? 'أسماء الله' : '99 Names',
        asset: 'assets/home/allah_Names.png',
        route: const NamesOfAllahScreen(),
      ),
      _ToolItem(
        title: isArabic ? 'الزكاة' : 'Zakat',
        asset: 'assets/home/img_zakah.png',
        route: const ZakatView(),
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: isArabic ? 'خدمات إسلامية سريعة' : 'Quick Islamic Tools',
            padding: EdgeInsets.symmetric(vertical: 4.h),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              for (final tool in tools)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: context.radius.mdBorder,
                        border: Border.all(
                          color: colors.border,
                          width: 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: colors.isDark ? 0.2 : 0.03,
                            ),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
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
                                tool.route,
                                type: TransitionType.fade,
                              ),
                            );
                          },
                          borderRadius: context.radius.mdBorder,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 12.h,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 44.r,
                                  height: 44.r,
                                  padding: EdgeInsets.all(7.r),
                                  decoration: BoxDecoration(
                                    color: colors.surfaceVariant,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: colors.border,
                                      width: 0.6,
                                    ),
                                  ),
                                  child: Image.asset(
                                    tool.asset,
                                    fit: BoxFit.contain,
                                    cacheWidth: 88,
                                    cacheHeight: 88,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(
                                          Icons.star_rounded,
                                          size: 22.r,
                                          color: colors.secondary,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  tool.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: context.typography.titleSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolItem {
  const _ToolItem({
    required this.title,
    required this.asset,
    required this.route,
  });

  final String title;
  final String asset;
  final Widget route;
}
