import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../names_of_allah/view/names_of_allah_screen.dart';
import '../../../prayer_times/view/prayer_times_view.dart';
import '../../../sebha/view/sebha_view.dart';
import 'dashboard_list.dart';
import 'feature_card.dart';
import 'zakat_card_widget.dart';

class LayoutContent extends StatelessWidget {
  const LayoutContent(
    this.scaffoldContext,
    this.theme, {
    required this.localizations,
    super.key,
  });

  final BuildContext scaffoldContext;
  final ThemeData theme;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      // عرض أوقات الصلاة
      PrayerTimesView(
        scaffoldContext: scaffoldContext,
        theme: theme,
        localizations: localizations,
      ),

      // محتوى الداشبورد
      DashboardGrid(theme: theme, localizations: localizations),

      // الأقسام الإضافية (أسماء الله – السبحة )
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: <Widget>[
              FeatureCard(
                label: localizations.namesOfAllah,
                image: 'assets/images/allah.png',
                onTap: () =>
                    navigateWithTransition(context, const NamesOfAllahScreen()),
                theme: theme,
              ),
              FeatureCard(
                label: localizations.sebha,
                image: 'assets/images/seb7a.png',
                onTap: () => navigateWithTransition(context, const SebhaView()),
                theme: theme,
              ),
            ],
          ),
        ),
      ),

      SliverToBoxAdapter(
        child: ZakatCardWidget(theme: theme, localizations: localizations),
      ),
    ],
  );
}
