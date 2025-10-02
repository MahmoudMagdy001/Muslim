import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../names_of_allah/view/names_of_allah_screen.dart';
import '../../../prayer_times/view/prayer_times_view.dart';
import '../../../sebha/view/sebha_view.dart';
import 'dashboard_grid.dart';
import 'feature_card.dart';

class LayoutContent extends StatelessWidget {
  const LayoutContent(this.scaffoldContext, this.theme, {super.key});

  final BuildContext scaffoldContext;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      PrayerTimesView(scaffoldContext: scaffoldContext, theme: theme),
      DashboardGrid(theme: theme),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              FeatureCard(
                label: 'اسماء الله الحسنى',
                image: 'assets/images/allah.png',
                onTap: () =>
                    navigateWithTransition(context, const NamesOfAllahScreen()),
                theme: theme,
              ),
              FeatureCard(
                label: 'السبحه',
                image: 'assets/images/seb7a.png',
                onTap: () => navigateWithTransition(context, const SebhaView()),
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
