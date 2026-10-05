import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/quran/presentation/views/bookmarks_view.dart';
import 'package:muslim/features/surahs_list/data/models/quran_view_type.dart';
import 'package:muslim/features/surahs_list/presentation/bloc/surahs_list_bloc.dart';
import 'package:muslim/features/surahs_list/presentation/views/widgets/surahs_list_tab/surah_list_tab.dart';
import 'package:muslim/l10n/app_localizations.dart';

class SurahsListView extends StatefulWidget {
  const SurahsListView({required this.selectedReciter, super.key});
  final String selectedReciter;

  @override
  State<SurahsListView> createState() => _SurahsListViewState();
}

class _SurahsListViewState extends State<SurahsListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showQuranTour(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final colors = context.colors;

    return BlocProvider(
      create: (context) {
        final bloc = getIt<SurahListBloc>();
        unawaited(bloc.loadSurahs());
        return bloc;
      },
      child: Builder(
        builder: (context) => DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppBar(
              backgroundColor: colors.isDark ? const Color(0xFF142722) : colors.primary,
              elevation: 2,
              title: Text(
                localizations.quranText,
                style: GoogleFonts.amiri(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFE082),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => unawaited(
                    AppTourHelper.showQuranTour(context, force: true),
                  ),
                  icon: const Icon(Icons.explore_outlined, color: Colors.white),
                  tooltip: localizations.tourQuranTitle,
                ),
                IconButton(
                  key: AppTourKeys.quranBookmarksKey,
                  onPressed: () => unawaited(
                    navigateWithTransition<void>(
                      type: TransitionType.fade,
                      context,
                      BookmarksView(reciter: widget.selectedReciter),
                    ),
                  ),
                  icon: const Icon(Icons.bookmarks_rounded, color: Colors.white),
                  tooltip: localizations.bookmarksText,
                ),
                SizedBox(width: 8.w),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48.h),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: colors.secondary.withValues(alpha: 0.3),
                      width: 0.8,
                    ),
                  ),
                  child: TabBar(
                    key: AppTourKeys.quranTabKey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFE082),
                          Color(0xFFC59F48),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC59F48).withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    labelColor: const Color(0xFF143B33),
                    unselectedLabelColor: Colors.white.withValues(alpha: 0.85),
                    labelStyle: GoogleFonts.cairo(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: GoogleFonts.cairo(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: (index) {
                      final viewType = QuranViewType.values[index];
                      context.read<SurahListBloc>().changeViewType(viewType);
                    },
                    tabs: [
                      Tab(text: localizations.surahsText),
                      Tab(text: localizations.juzText),
                      Tab(text: localizations.hizbText),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  SurahListTab(
                    selectedReciter: widget.selectedReciter,
                    localizations: localizations,
                    forceViewType: QuranViewType.surah,
                  ),
                  SurahListTab(
                    selectedReciter: widget.selectedReciter,
                    localizations: localizations,
                    forceViewType: QuranViewType.juz,
                  ),
                  SurahListTab(
                    selectedReciter: widget.selectedReciter,
                    localizations: localizations,
                    forceViewType: QuranViewType.hizb,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
