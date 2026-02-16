import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../quran/view/bookmarks_view.dart';
import '../../quran/viewmodel/last_played_cubit/last_played.dart';
import '../model/quran_view_type.dart';
import '../viewmodel/surah_list/surahs_list_cubit.dart';
import 'widgets/surahs_list_tab/surah_list_tab.dart';

class SurahsListView extends StatelessWidget {
  const SurahsListView({required this.selectedReciter, super.key});
  final String selectedReciter;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final localizations = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SurahListCubit()..loadSurahs(isArabic: isArabic),
        ),
        BlocProvider(create: (context) => LastPlayedCubit()..initialize()),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(localizations.quranText),
            actions: [
              IconButton(
                onPressed: () => navigateWithTransition(
                  type: TransitionType.fade,
                  context,
                  BookmarksView(reciter: selectedReciter, isArabic: isArabic),
                ),
                icon: const Icon(Icons.bookmarks_rounded),
                tooltip: localizations.bookmarksText,
              ),
              SizedBox(width: 8.toW),
            ],
            bottom: TabBar(
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
                  selectedReciter: selectedReciter,
                  isArabic: isArabic,
                  localizations: localizations,
                  forceViewType: QuranViewType.surah,
                ),
                SurahListTab(
                  selectedReciter: selectedReciter,
                  isArabic: isArabic,
                  localizations: localizations,
                  forceViewType: QuranViewType.juz,
                ),
                SurahListTab(
                  selectedReciter: selectedReciter,
                  isArabic: isArabic,
                  localizations: localizations,
                  forceViewType: QuranViewType.hizb,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
