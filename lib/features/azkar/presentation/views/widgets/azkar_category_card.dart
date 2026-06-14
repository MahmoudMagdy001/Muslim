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
  // Cached once per dependency-change so ThemeData.copyWith() is not called
  // on every rebuild of the ListView that hosts this card.
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
  Widget build(BuildContext context) => Theme(
      data: _cachedTheme,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: context.theme.cardTheme.color,
            borderRadius: BorderRadius.circular(12.r),
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/quran/marker.png',
                        width: 36.w,
                        height: 36.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          _isArabic
                              ? convertToArabicNumbers(widget.index.toString())
                              : widget.index.toString(),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    widget.category,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${widget.count})',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              expandedAlignment: Alignment.centerLeft,
              children: widget.items
                  .map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.title,
                        style: context.textTheme.bodyMedium,
                        textDirection: TextDirection.rtl,
                      ),
                      onTap: () {
                        unawaited(
                          navigateWithTransition<void>(
                            context,
                            AzkarDetailsView(azkar: item),
                            type: TransitionType.fade,
                          ),
                        );
                      },
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
}
