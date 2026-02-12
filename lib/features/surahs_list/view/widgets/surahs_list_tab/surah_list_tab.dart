import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../quran/repository/quran_repository.dart';
import '../../../../quran/view/quran_view.dart';
import '../../../../quran/viewmodel/last_played_cubit/last_played.dart';
import '../../../model/quran_view_type.dart';
import '../../../viewmodel/surah_list/surahs_list_cubit.dart';
import '../../../viewmodel/surah_list/surahs_list_state.dart';
import 'hizb_list_view.dart';
import 'juz_list_view.dart';
import 'seach_result_count.dart';
import 'search_result_list.dart';
import 'search_section.dart';
import 'surah_list.dart';

class SurahListTab extends StatefulWidget {
  const SurahListTab({
    required this.selectedReciter,
    required this.isArabic,
    required this.localizations,
    super.key,
  });

  final String selectedReciter;
  final bool isArabic;
  final AppLocalizations localizations;

  @override
  State<SurahListTab> createState() => _SurahListTabState();
}

class _SurahListTabState extends State<SurahListTab> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final ValueNotifier<bool> exactSearchNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    exactSearchNotifier.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    context.read<SurahListCubit>().searchInQuran(
      value,
      partial: !exactSearchNotifier.value,
    );
  }

  void _toggleExactSearch() {
    exactSearchNotifier.value = !exactSearchNotifier.value;
    _onSearchChanged(_searchController.text);
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  Future<void> _navigateTo({
    required int surah,
    required int ayah,
    int? fromPage,
    int? toPage,
  }) async {
    final repository = GetIt.instance<QuranRepository>();
    int targetAyah = ayah;

    // Smart Resume: If opening from list (ayah == 1) and same surah/reciter is playing, resume from current ayah
    if (ayah == 1 &&
        repository.currentSurah == surah &&
        repository.currentReciter == widget.selectedReciter) {
      targetAyah = (repository.currentIndex ?? 0) + 1;
    }

    await navigateWithTransition(
      type: TransitionType.fade,
      context,
      QuranView(
        surahNumber: surah,
        reciter: widget.selectedReciter,
        currentAyah: targetAyah,
        fromPage: fromPage,
        toPage: toPage,
      ),
    );
    if (mounted) {
      context.read<LastPlayedCubit>().initialize();
    }
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Column(
      children: [
        TabBar(
          onTap: (index) {
            final viewType = QuranViewType.values[index];
            context.read<SurahListCubit>().changeViewType(viewType);
          },
          tabs: [
            Tab(text: widget.localizations.surahsText),
            Tab(text: widget.localizations.juzText),
            Tab(text: widget.localizations.hizbText),
          ],
        ),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            child: BlocBuilder<SurahListCubit, SurahsListState>(
              builder: (context, state) => CustomScrollView(
                controller: _scrollController,
                slivers: [
                  if (state.currentViewType == QuranViewType.surah) ...[
                    ValueListenableBuilder<bool>(
                      valueListenable: exactSearchNotifier,
                      builder: (context, exactSearch, child) => SearchSection(
                        controller: _searchController,
                        exactSearch: exactSearch,
                        onSearchChanged: _onSearchChanged,
                        toggleExactSearch: _toggleExactSearch,
                        clearSearch: _clearSearch,
                      ),
                    ),
                    if (state.searchText.isNotEmpty)
                      ResultsCount(
                        searchText: state.searchText,
                        resultsCount: state.searchResults.length,
                      ),
                    if (state.searchText.isNotEmpty)
                      SearchResultsList(
                        searchResults: state.searchResults,
                        navigateToResult: _navigateTo,
                      )
                    else
                      SurahList(
                        surahs: state.filteredSurahs,
                        isArabic: widget.isArabic,
                        navigateToSurah:
                            ({required int surah, required int ayah}) async {
                              // For Surah, we restrict to the pages of that Surah
                              final startPage = quran.getPageNumber(surah, 1);
                              final endPage = quran.getPageNumber(
                                surah,
                                quran.getVerseCount(surah),
                              );
                              await _navigateTo(
                                surah: surah,
                                ayah: ayah,
                                fromPage: startPage,
                                toPage: endPage,
                              );
                            },
                      ),
                  ] else if (state.currentViewType == QuranViewType.juz) ...[
                    JuzListView(
                      juzs: state.juzs,
                      isArabic: widget.isArabic,
                      navigateToJuz:
                          ({required int surah, required int ayah}) async {
                            // For Juz, we restrict to the pages of that Juz.
                            final juzModel = state.juzs.firstWhere(
                              (j) =>
                                  j.startSurah == surah && j.startAyah == ayah,
                            );
                            final juzNumber = juzModel.number;

                            // Calculate start page of this Juz
                            final startPage = quran.getPageNumber(surah, ayah);

                            // Calculate end page (start of next Juz - 1, or 604 for last Juz)
                            int endPage;
                            if (juzNumber == 30) {
                              endPage = 604;
                            } else {
                              final nextJuzIndex =
                                  juzNumber; // juzNumber is 1-based
                              if (nextJuzIndex < state.juzs.length) {
                                final nextJuz = state.juzs[nextJuzIndex];
                                endPage =
                                    quran.getPageNumber(
                                      nextJuz.startSurah,
                                      nextJuz.startAyah,
                                    ) -
                                    1;
                              } else {
                                endPage = 604;
                              }
                            }

                            await _navigateTo(
                              surah: surah,
                              ayah: ayah,
                              fromPage: startPage,
                              toPage: endPage,
                            );
                          },
                    ),
                  ] else if (state.currentViewType == QuranViewType.hizb) ...[
                    HizbListView(
                      hizbs: state.hizbs,
                      isArabic: widget.isArabic,
                      navigateToHizb:
                          ({required int surah, required int ayah}) async {
                            final hizbModel = state.hizbs.firstWhere(
                              (h) =>
                                  h.startSurah == surah && h.startAyah == ayah,
                            );
                            final hizbNumber = hizbModel.number;

                            final startPage = quran.getPageNumber(surah, ayah);
                            int endPage;

                            if (hizbNumber == 60) {
                              endPage = 604;
                            } else {
                              final nextHizbIndex = hizbNumber;
                              if (nextHizbIndex < state.hizbs.length) {
                                final nextHizb = state.hizbs[nextHizbIndex];
                                endPage =
                                    quran.getPageNumber(
                                      nextHizb.startSurah,
                                      nextHizb.startAyah,
                                    ) -
                                    1;
                              } else {
                                endPage = 604;
                              }
                            }

                            await _navigateTo(
                              surah: surah,
                              ayah: ayah,
                              fromPage: startPage,
                              toPage: endPage,
                            );
                          },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
