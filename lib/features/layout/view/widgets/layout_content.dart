import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../names_of_allah/view/names_of_allah_screen.dart';
import '../../../prayer_times/view/prayer_times_view.dart';
import '../../../sebha/view/sebha_view.dart';
import 'dashboard_list.dart';
import 'feature_card.dart';
import 'zakat_card_widget.dart';

class LayoutContent extends StatefulWidget {
  const LayoutContent(
    this.scaffoldContext,
    this.theme, {
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final BuildContext scaffoldContext;
  final ThemeData theme;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  State<LayoutContent> createState() => _LayoutContentState();
}

class _LayoutContentState extends State<LayoutContent> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      // عرض أوقات الصلاة
      PrayerTimesView(
        scaffoldContext: widget.scaffoldContext,
        theme: widget.theme,
        localizations: widget.localizations,
      ),

      // محتوى الداشبورد
      DashboardGrid(theme: widget.theme, localizations: widget.localizations),

      // أقسام إضافية
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              FeatureCard(
                label: widget.localizations.namesOfAllah,
                image: 'assets/images/allah.png',
                onTap: () =>
                    navigateWithTransition(context, const NamesOfAllahScreen()),
                theme: widget.theme,
              ),
              FeatureCard(
                label: widget.localizations.sebha,
                image: 'assets/images/seb7a.png',
                onTap: () => navigateWithTransition(
                  context,
                  SebhaView(
                    localizations: widget.localizations,
                    isArabic: widget.isArabic,
                  ),
                ),
                theme: widget.theme,
              ),
            ],
          ),
        ),
      ),

      // بطاقة الزكاة
      SliverToBoxAdapter(
        child: ZakatCardWidget(
          theme: widget.theme,
          localizations: widget.localizations,
        ),
      ),

      // آخر استماع - استخدم BlocSelector فقط هنا
    ],
  );
}
