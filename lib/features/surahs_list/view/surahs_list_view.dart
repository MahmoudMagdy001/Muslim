import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/quran/view/bookmarks_view.dart';
import 'package:muslim/features/quran/viewmodel/last_played_cubit/last_played.dart';
import 'package:muslim/features/surahs_list/model/quran_view_type.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/surah_list_tab.dart';
import 'package:muslim/features/surahs_list/viewmodel/surah_list/surahs_list_cubit.dart';
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = getIt<SurahListCubit>();
            unawaited(cubit.loadSurahs());
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = getIt<LastPlayedCubit>();
            unawaited(cubit.initialize());
            return cubit;
          },
        ),
      ],
      child: Builder(
        builder: (context) => DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(localizations.quranText),
              actions: [
                IconButton(
                  onPressed: () => unawaited(
                    AppTourHelper.showQuranTour(context, force: true),
                  ),
                  icon: const Icon(Icons.explore_outlined),
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
                  icon: const Icon(Icons.bookmarks_rounded),
                  tooltip: localizations.bookmarksText,
                ),
                SizedBox(width: 8.toW),
              ],
              bottom: TabBar(
                key: AppTourKeys.quranTabKey,
                labelColor: context.theme.colorScheme.secondary,
                unselectedLabelColor: Colors.white,
                onTap: (index) {
                  final viewType = QuranViewType.values[index];
                  context.read<SurahListCubit>().changeViewType(viewType);
                },
                tabs: [
                  Tab(text: localizations.surahsText),
                  Tab(text: localizations.juzText),
                  Tab(text: localizations.hizbText),
                ],
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
