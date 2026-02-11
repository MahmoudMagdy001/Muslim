import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../models/azkar_model.dart';
import '../azkar_details_view.dart';

class AzkarCategoryCard extends StatelessWidget {
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
  final List<AzkarModel> items;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Theme(
      data: context.theme.copyWith(
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: context.theme.cardTheme.color,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ExpansionTile(
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
                      isArabic
                          ? convertToArabicNumbers(index.toString())
                          : index.toString(),
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
                category,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '($count)',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          expandedAlignment: Alignment.centerLeft,
          children: items
              .map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.title,
                    style: context.textTheme.bodyMedium,
                    textDirection: TextDirection.rtl,
                  ),
                  onTap: () {
                    navigateWithTransition(
                      context,
                      AzkarDetailsView(azkar: item),
                      type: TransitionType.fade,
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
