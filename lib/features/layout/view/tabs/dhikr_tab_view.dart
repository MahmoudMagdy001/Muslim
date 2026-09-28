import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/azkar/presentation/views/azkar_view.dart';
import 'package:muslim/features/sebha/presentation/views/sebha_view.dart';

class DhikrTabView extends StatelessWidget {
  const DhikrTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? 'الأذكار والتسبيح' : 'Dhikr & Tasbih'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => unawaited(
                AppTourHelper.showAzkarTour(context, force: true),
              ),
              icon: const Icon(Icons.explore_outlined),
              tooltip: isArabic ? 'جولة الأذكار' : 'Dhikr Tour',
            ),
          ],
          bottom: TabBar(
            indicatorColor: const Color(0xFFD4AF37),
            indicatorWeight: 3,
            labelColor: const Color(0xFFD4AF37),
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                text: isArabic ? 'أذكار المسلم' : 'Azkar',
                icon: const Icon(Icons.auto_stories_rounded, size: 20),
              ),
              Tab(
                text: isArabic ? 'السبحة الإلكترونية' : 'Digital Tasbih',
                icon: const Icon(Icons.fingerprint_rounded, size: 20),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AzkarView(showAppBar: false),
            SebhaView(showAppBar: false),
          ],
        ),
      ),
    );
  }
}
