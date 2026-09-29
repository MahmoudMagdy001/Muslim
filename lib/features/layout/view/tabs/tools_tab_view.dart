import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/hadith/presentation/views/hadith_books_view.dart';
import 'package:muslim/features/names_of_allah/presentation/views/names_of_allah_screen.dart';
import 'package:muslim/features/qiblah/presentation/views/qiblah_view.dart';
import 'package:muslim/features/settings/view/settings_view.dart';
import 'package:muslim/features/zakat/presentation/views/zakat_view.dart';

class ToolsTabView extends StatelessWidget {
  const ToolsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colors = context.colors;

    final toolItems = [
      _ServiceItem(
        title: isArabic ? 'اتجاه القبلة' : 'Qiblah Direction',
        subtitle: isArabic
            ? 'بوصلة دقيقة لتحديد اتجاه الكعبة المشرفة'
            : 'Accurate compass pointing towards the Kaaba',
        asset: 'assets/home/qibla.png',
        route: const QiblahView(),
      ),
      _ServiceItem(
        title: isArabic ? 'الأحاديث النبوية الشريفة' : 'Prophetic Hadiths',
        subtitle: isArabic
            ? 'صحيح البخاري، مسلم، والكتب الستة'
            : 'Sahih Bukhari, Muslim, and Hadith collections',
        asset: 'assets/home/hadith.png',
        route: const HadithBooksView(),
      ),
      _ServiceItem(
        title: isArabic ? 'أسماء الله الحسنى' : '99 Names of Allah',
        subtitle: isArabic
            ? 'معاني ودلالات أسماء الله وفضلها'
            : 'Meanings and reflections of divine names',
        asset: 'assets/home/allah_Names.png',
        route: const NamesOfAllahScreen(),
      ),
      _ServiceItem(
        title: isArabic ? 'حاسبة الزكاة' : 'Zakat Calculator',
        subtitle: isArabic
            ? 'حساب زكاة المال، الذهب، والفضة بدقة'
            : 'Calculate wealth, gold, and silver zakat accurately',
        asset: 'assets/home/img_zakah.png',
        route: const ZakatView(),
      ),
      _ServiceItem(
        title: isArabic ? 'إعدادات التطبيق' : 'App Settings',
        subtitle: isArabic
            ? 'المظهر، حجم الخط، القارئ المفضل، والإشعارات'
            : 'Theme, font size, default reciter, and reminders',
        iconData: Icons.settings_rounded,
        route: const SettingsView(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'الخدمات الإسلامية' : 'Islamic Tools'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => unawaited(
              AppTourHelper.showHomeTour(context, force: true),
            ),
            icon: const Icon(Icons.explore_outlined),
            tooltip: isArabic ? 'جولة في التطبيق' : 'App Tour',
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        itemCount: toolItems.length,
        itemBuilder: (context, index) {
          final item = toolItems[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
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
                        item.route,
                        type: TransitionType.fade,
                      ),
                    );
                  },
                  borderRadius: context.radius.mdBorder,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.r,
                          height: 48.r,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: colors.surfaceVariant,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: colors.border,
                              width: 0.6,
                            ),
                          ),
                          child: item.asset != null
                              ? Image.asset(
                                  item.asset!,
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Icon(
                                            Icons.apps_rounded,
                                            color: colors.secondary,
                                            size: 22.r,
                                          ),
                                )
                              : Icon(
                                  item.iconData ?? Icons.widgets_rounded,
                                  color: colors.secondary,
                                  size: 24.r,
                                ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.title,
                                style: context.typography.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                item.subtitle,
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
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.r,
                          color: colors.textSecondary.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({
    required this.title,
    required this.subtitle,
    required this.route,
    this.asset,
    this.iconData,
  });

  final String title;
  final String subtitle;
  final Widget route;
  final String? asset;
  final IconData? iconData;
}
