import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/layout/presentation/views/widgets/contextual_dhikr_card.dart';
import 'package:muslim/features/layout/presentation/views/widgets/continue_reading_card.dart';
import 'package:muslim/features/layout/presentation/views/widgets/daily_verse_card.dart';
import 'package:muslim/features/layout/presentation/views/widgets/quick_tools_row.dart';
import 'package:muslim/features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:muslim/features/settings/presentation/views/settings_view.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.appName,
          style: context.typography.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
            icon: const Icon(Icons.settings_outlined),
            tooltip: localization.settingsButton,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Builder(
          builder: (scaffoldContext) => CustomScrollView(
            slivers: [
              // 1. Celestial Prayer Times Hero Banner
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: AppTourKeys.prayerTimesKey,
                  child: const PrayerTimesView(),
                ),
              ),

              SliverPadding(padding: EdgeInsets.only(top: 8.h)),

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
                padding: EdgeInsets.symmetric(vertical: 8.h),
                sliver: const SliverToBoxAdapter(child: DailyVerseCard()),
              ),

              SliverPadding(padding: EdgeInsets.only(bottom: 20.h)),
            ],
          ),
        ),
      ),
    );
  }
}
