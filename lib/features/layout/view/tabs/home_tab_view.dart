import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/layout/view/widgets/contextual_dhikr_card.dart';
import 'package:muslim/features/layout/view/widgets/continue_reading_card.dart';
import 'package:muslim/features/layout/view/widgets/daily_verse_card.dart';
import 'package:muslim/features/layout/view/widgets/quick_tools_row.dart';
import 'package:muslim/features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:muslim/features/settings/view/settings_view.dart';
import 'package:muslim/l10n/app_localizations.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.appName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => unawaited(
              AppTourHelper.showHomeTour(context, force: true),
            ),
            icon: const Icon(Icons.explore_outlined),
            tooltip: localization.tourServicesTitle,
          ),
          IconButton(
            key: AppTourKeys.settingsKey,
            onPressed: () => unawaited(
              navigateWithTransition<void>(context, const SettingsView()),
            ),
            icon: const Icon(Icons.settings_rounded),
            tooltip: localization.settingsButton,
          ),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) => CustomScrollView(
            slivers: [
              // 1. Celestial Prayer Times Hero Banner
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: AppTourKeys.prayerTimesKey,
                  child: PrayerTimesView(
                    scaffoldContext: scaffoldContext,
                    localizations: localization,
                  ),
                ),
              ),

              SliverPadding(padding: EdgeInsets.only(top: 8.toH)),

              // 2. 1-Tap "Continue Reading" Quran Hero Card
              const SliverToBoxAdapter(
                child: ContinueReadingCard(),
              ),

              // 3. Contextual Time-of-Day Dhikr Card (Morning / Evening / Sleep)
              const SliverToBoxAdapter(
                child: ContextualDhikrCard(),
              ),

              // 4. Quick Islamic Tools Row (Qiblah, Hadith, Names, Zakat)
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: AppTourKeys.servicesKey,
                  child: const QuickToolsRow(),
                ),
              ),

              // 5. Daily Verse & Reflection Banner
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.toH),
                sliver: const SliverToBoxAdapter(child: DailyVerseCard()),
              ),

              SliverPadding(padding: EdgeInsets.only(bottom: 16.toH)),
            ],
          ),
        ),
      ),
    );
  }
}
