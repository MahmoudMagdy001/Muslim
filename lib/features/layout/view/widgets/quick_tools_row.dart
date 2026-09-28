import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/hadith/presentation/views/hadith_books_view.dart';
import 'package:muslim/features/names_of_allah/presentation/views/names_of_allah_screen.dart';
import 'package:muslim/features/qiblah/presentation/views/qiblah_view.dart';
import 'package:muslim/features/zakat/presentation/views/zakat_view.dart';

class QuickToolsRow extends StatelessWidget {
  const QuickToolsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = context.theme.brightness == Brightness.dark;

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
      padding: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 8.toH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.toW, vertical: 4.toH),
            child: Text(
              isArabic ? 'خدمات إسلامية سريعة' : 'Quick Islamic Tools',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF192522),
              ),
            ),
          ),
          SizedBox(height: 6.toH),
          Row(
            children: [
              for (final tool in tools)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.toW),
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
                          borderRadius: BorderRadius.circular(16.toR),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.toW,
                              vertical: 12.toH,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 44.toW,
                                  height: 44.toH,
                                  padding: EdgeInsets.all(6.toR),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.05)
                                        : const Color(0xFFF0F5F3),
                                    borderRadius: BorderRadius.circular(12.toR),
                                  ),
                                  child: Image.asset(
                                    tool.asset,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.star_rounded, size: 24),
                                  ),
                                ),
                                SizedBox(height: 6.toH),
                                Text(
                                  tool.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF192522),
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
