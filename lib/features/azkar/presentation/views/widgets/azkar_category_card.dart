import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/presentation/views/azkar_details_view.dart';

class AzkarCategoryCard extends StatefulWidget {
  const AzkarCategoryCard({
    required this.category,
    required this.count,
    required this.items,
    required this.onTap,
    required this.index,
    super.key,
  });

  final String category;
  final int count;
  final List<AzkarEntity> items;
  final VoidCallback onTap;
  final int index;

  @override
  State<AzkarCategoryCard> createState() => _AzkarCategoryCardState();
}

class _AzkarCategoryCardState extends State<AzkarCategoryCard> {
  late ThemeData _cachedTheme;
  late bool _isArabic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isArabic = Localizations.localeOf(context).languageCode == 'ar';
    _cachedTheme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Theme(
      data: _cachedTheme,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 8.h),
        child: Material(
            color: colors.surface,
            borderRadius: context.radius.mdBorder,
            elevation: 1,
            shadowColor: Colors.black.withValues(
              alpha: colors.isDark ? 0.2 : 0.03,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.mdBorder,
              side: BorderSide(
                color: colors.border,
                width: 0.8,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            iconColor: colors.secondary,
            collapsedIconColor: colors.textSecondary,
            title: Row(
              children: [
                // Category index emblem with Islamic star marker
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
                        _isArabic
                            ? convertToArabicNumbers(widget.index.toString())
                            : widget.index.toString(),
                        style: context.typography.titleSmall.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.category,
                    style: context.typography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    _isArabic
                        ? '${convertToArabicNumbers(widget.count.toString())} ذكر'
                        : '${widget.count} items',
                    style: context.typography.caption.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
            expandedAlignment: Alignment.centerLeft,
            children: widget.items.map((item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      unawaited(
                        navigateWithTransition<void>(
                          context,
                          AzkarDetailsView(azkar: item),
                          type: TransitionType.fade,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(10.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: context.typography.body.copyWith(
                                color: colors.textPrimary,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 13.r,
                            color: colors.textSecondary.withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )).toList(),
          ),
        ),
      ),
    );
  }
}
