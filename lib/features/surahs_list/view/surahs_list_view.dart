import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../repository/surahs_list_repository_impl.dart';
import '../viewmodel/surah_list/surahs_list_cubit.dart';
import 'widgets/bookmark_tab.dart';
import 'widgets/surah_list_tab.dart';

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
          create: (context) =>
              SurahListCubit(surahRepository: SurahsListRepositoryImpl())
                ..loadSurahs(isArabic: isArabic),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(localizations.quranText),
            bottom: TabBar(
              tabs: [
                Tab(text: localizations.surahsText),
                Tab(text: localizations.bookmarksText),
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
                ),
                BookmarksTab(
                  reciter: selectedReciter,
                  localizations: localizations,
                  isArabic: isArabic,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
