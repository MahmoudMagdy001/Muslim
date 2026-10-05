import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/layout/presentation/views/tabs/dhikr_tab_view.dart';
import 'package:muslim/features/layout/presentation/views/tabs/home_tab_view.dart';
import 'package:muslim/features/layout/presentation/views/tabs/tools_tab_view.dart';
import 'package:muslim/features/quran/presentation/bloc/last_played/last_played_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/reciter/reciter_bloc.dart';
import 'package:muslim/features/surahs_list/presentation/views/surahs_list_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showHomeTour(context));
        unawaited(getIt<LastPlayedBloc>().initialize());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final reciter = context.watch<ReciterBloc>().state.selectedReciter;
    final colors = context.colors;

    final tabs = <Widget>[
      const HomeTabView(),
      SurahsListView(selectedReciter: reciter),
      const DhikrTabView(),
      const ToolsTabView(),
    ];

    return BlocProvider.value(
      value: getIt<LastPlayedBloc>(),
      child: Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(
              color: colors.border,
              width: 0.8,
            ),
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            height: 64.h,
            indicatorColor: colors.secondary.withValues(alpha: 0.16),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(
                  color: colors.secondary,
                  size: 24.r,
                );
              }
              return IconThemeData(
                color: colors.textSecondary,
                size: 24.r,
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(WidgetState.selected)) {
                return context.typography.caption.copyWith(
                  color: colors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.5.sp,
                );
              }
              return context.typography.caption.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              if (_currentIndex != index) {
                setState(() => _currentIndex = index);
              }
            },
            backgroundColor: colors.surface,
            elevation: 0,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: isArabic ? 'الرئيسية' : 'Home',
              ),
              NavigationDestination(
                icon: const Icon(Icons.menu_book_outlined),
                selectedIcon: const Icon(Icons.menu_book_rounded),
                label: isArabic ? 'المصحف' : 'Quran',
              ),
              NavigationDestination(
                icon: const Icon(Icons.auto_stories_outlined),
                selectedIcon: const Icon(Icons.auto_stories_rounded),
                label: isArabic ? 'الأذكار' : 'Dhikr',
              ),
              NavigationDestination(
                icon: const Icon(Icons.grid_view_outlined),
                selectedIcon: const Icon(Icons.grid_view_rounded),
                label: isArabic ? 'الخدمات' : 'Tools',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
