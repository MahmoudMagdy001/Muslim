import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/quran/repository/quran_repository.dart';
import 'package:muslim/features/quran/view/quran_view.dart';
import 'package:muslim/features/quran/viewmodel/last_played_cubit/last_played.dart';
import 'package:muslim/features/surahs_list/model/quran_view_type.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/hizb_list_view.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/juz_list_view.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/last_played_section.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/seach_result_count.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/search_result_list.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/search_section.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/surah_list.dart';
import 'package:muslim/features/surahs_list/viewmodel/surah_list/surahs_list_cubit.dart';
import 'package:muslim/features/surahs_list/viewmodel/surah_list/surahs_list_state.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;

class SurahListTab extends StatefulWidget {
  const SurahListTab({
    required this.selectedReciter,
    required this.isArabic,
    required this.localizations,
    this.forceViewType,
    super.key,
  });

  final String selectedReciter;
  final bool isArabic;
  final AppLocalizations localizations;
  final QuranViewType? forceViewType;

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
    unawaited(
      context.read<SurahListCubit>().searchInQuran(
            value,
            partial: !exactSearchNotifier.value,
          ),
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
    var targetAyah = ayah;

    // Smart Resume: If opening from list (ayah == 1) and same surah/reciter is playing, resume from current ayah
    if (ayah == 1 &&
        repository.currentSurah == surah &&
        repository.currentReciter == widget.selectedReciter) {
      targetAyah = (repository.currentIndex ?? 0) + 1;
    }

    await navigateWithTransition<void>(
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
      await context.read<LastPlayedCubit>().initialize();
    }
  }

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: _scrollController,
    child: BlocBuilder<SurahListCubit, SurahsListState>(
      builder: (context, state) {
        final currentViewType = widget.forceViewType ?? state.currentViewType;
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            if (currentViewType == QuranViewType.surah) ...[
              LastPlayedSection(
                navigateToSurah:
                    ({required surah, required ayah}) async {
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
                      ({required surah, required ayah}) async {
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
            ] else if (currentViewType == QuranViewType.juz) ...[
              JuzListView(
                juzs: state.juzs,
                isArabic: widget.isArabic,
                navigateToJuz: ({required surah, required ayah}) async {
                  // For Juz, we restrict to the pages of that Juz.
                  final juzModel = state.juzs.firstWhere(
                    (j) => j.startSurah == surah && j.startAyah == ayah,
                  );
                  final juzNumber = juzModel.number;

                  // Calculate start page of this Juz
                  final startPage = quran.getPageNumber(surah, ayah);

                  // Calculate end page (start of next Juz - 1, or 604 for last Juz)
                  int endPage;
                  if (juzNumber == 30) {
                    endPage = 604;
                  } else {
                    final nextJuzIndex = juzNumber; // juzNumber is 1-based
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
            ] else if (currentViewType == QuranViewType.hizb) ...[
              HizbListView(
                hizbs: state.hizbs,
                isArabic: widget.isArabic,
                navigateToHizb:
                    ({required surah, required ayah}) async {
                      final hizbModel = state.hizbs.firstWhere(
                        (h) => h.startSurah == surah && h.startAyah == ayah,
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
        );
      },
    ),
  );
}
