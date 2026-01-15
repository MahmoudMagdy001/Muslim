import 'package:flutter/material.dart';

import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer_times/view/prayer_times_view.dart';
import 'dashboard_list.dart';
import 'zakat_card_widget.dart';

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
        padding: .symmetric(vertical: 8.toH, horizontal: 8.toW),
        sliver: SliverToBoxAdapter(
          child: ZakatCardWidget(localizations: localizations),
        ),
      ),
      SliverToBoxAdapter(
        child: DashboardGrid( localizations: localizations),
      ),
    ],
  );
}
