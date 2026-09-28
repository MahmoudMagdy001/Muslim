import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/layout/view/tabs/dhikr_tab_view.dart';
import 'package:muslim/features/layout/view/tabs/home_tab_view.dart';
import 'package:muslim/features/layout/view/tabs/tools_tab_view.dart';
import 'package:muslim/features/settings/view_model/rectire/rectire_cubit.dart';
import 'package:muslim/features/surahs_list/view/surahs_list_view.dart';

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final reciter = context.watch<ReciterCubit>().state.selectedReciter;
    final isDark = context.theme.brightness == Brightness.dark;

    final tabs = <Widget>[
      const HomeTabView(),
      SurahsListView(selectedReciter: reciter),
      const DhikrTabView(),
      const ToolsTabView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFFD4AF37).withValues(alpha: 0.22),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFFD4AF37), size: 24);
            }
            return IconThemeData(
              color: isDark ? Colors.white60 : const Color(0xFF5D716C),
              size: 24,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: const Color(0xFFD4AF37),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: context.theme.textTheme.bodyMedium?.fontFamily,
              );
            }
            return TextStyle(
              color: isDark ? Colors.white60 : const Color(0xFF5D716C),
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: context.theme.textTheme.bodyMedium?.fontFamily,
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
          backgroundColor: isDark ? const Color(0xFF141C1A) : Colors.white,
          elevation: 8,
          shadowColor: Colors.black26,
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
    );
  }
}
