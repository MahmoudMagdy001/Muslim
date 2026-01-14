import 'package:flutter/material.dart';

import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer_times/presentation/views/prayer_times_view.dart';
import 'daily_verse_card.dart';
import 'dashboard_list.dart';

class LayoutContent extends StatelessWidget {
  const LayoutContent(
    this.scaffoldContext, {
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final BuildContext scaffoldContext;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: PrayerTimesView(
          scaffoldContext: scaffoldContext,
          localizations: localizations,
        ),
      ),
      SliverToBoxAdapter(child: DashboardGrid(localizations: localizations)),
      SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 8.toH),
        sliver: const SliverToBoxAdapter(child: DailyVerseCard()),
      ),
    ],
  );
}
