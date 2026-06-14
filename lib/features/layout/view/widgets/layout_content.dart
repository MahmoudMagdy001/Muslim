import 'package:flutter/material.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/layout/view/widgets/daily_verse_card.dart';
import 'package:muslim/features/layout/view/widgets/dashboard_list.dart';
import 'package:muslim/features/layout/view/widgets/zakat_card_widget.dart';
import 'package:muslim/features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:muslim/l10n/app_localizations.dart';

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
      SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 8.toH, horizontal: 8.toW),
        sliver: SliverToBoxAdapter(
          child: ZakatCardWidget(localizations: localizations),
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
