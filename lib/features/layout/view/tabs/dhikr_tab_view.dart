import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/azkar/presentation/views/azkar_view.dart';
import 'package:muslim/features/sebha/presentation/views/sebha_view.dart';

class DhikrTabView extends StatelessWidget {
  const DhikrTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colors = context.colors;

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
            indicatorColor: colors.secondary,
            indicatorWeight: 3,
            labelColor: colors.secondary,
            unselectedLabelColor: Colors.white70,
            labelStyle: context.typography.titleSmall.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
            unselectedLabelStyle: context.typography.titleSmall.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
            ),
            tabs: [
              Tab(
                text: isArabic ? 'أذكار المسلم' : 'Azkar',
                icon: Icon(Icons.auto_stories_rounded, size: 20.r),
              ),
              Tab(
                text: isArabic ? 'السبحة الإلكترونية' : 'Digital Tasbih',
                icon: Icon(Icons.fingerprint_rounded, size: 20.r),
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
