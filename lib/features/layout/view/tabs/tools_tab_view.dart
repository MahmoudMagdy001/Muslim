import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
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
    final isDark = context.theme.brightness == Brightness.dark;

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
        padding: EdgeInsets.symmetric(horizontal: 14.toW, vertical: 12.toH),
        itemCount: toolItems.length,
        itemBuilder: (context, index) {
          final item = toolItems[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 10.toH),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF182421) : Colors.white,
                borderRadius: BorderRadius.circular(16.toR),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF253531)
                      : const Color(0xFFE2EBE8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
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
                  borderRadius: BorderRadius.circular(16.toR),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.toW,
                      vertical: 14.toH,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50.toW,
                          height: 50.toH,
                          padding: EdgeInsets.all(8.toR),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : const Color(0xFFF0F5F3),
                            borderRadius: BorderRadius.circular(14.toR),
                          ),
                          child: item.asset != null
                              ? Image.asset(
                                  item.asset!,
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.apps_rounded),
                                )
                              : Icon(
                                  item.iconData ?? Icons.widgets_rounded,
                                  color: const Color(0xFFD4AF37),
                                  size: 26,
                                ),
                        ),
                        SizedBox(width: 14.toW),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.title,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF192522),
                                ),
                              ),
                              SizedBox(height: 3.toH),
                              Text(
                                item.subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF5D716C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.toW),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: isDark
                              ? Colors.white54
                              : const Color(0xFF8BA09B),
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
