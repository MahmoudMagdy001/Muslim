import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/extensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../quran/service/quran_service.dart';
import '../../quran/viewmodel/last_played_cubit/last_played.dart';
import '../repository/surahs_list_repository_impl.dart';
import '../service/search_service.dart';
import '../viewmodel/surah_list/surahs_list_cubit.dart';
import 'widgets/bookmark_tab/bookmark_tab.dart';
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
          create: (context) => SurahListCubit(
            surahRepository: SurahsListRepositoryImpl(),
            searchService: QuranSearchService(),
          )..loadSurahs(isArabic: isArabic),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(localizations.quranText),
            bottom: TabBar(
              labelColor: context.theme.colorScheme.secondary,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: localizations.surahsText),
                Tab(text: localizations.bookmarksText),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                BlocProvider(
                  create: (context) =>
                      LastPlayedCubit(QuranService())..initialize(),
                  child: SurahListTab(
                    selectedReciter: selectedReciter,
                    isArabic: isArabic,
                    localizations: localizations,
                  ),
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
