import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../quran/view/quran_view.dart';
import '../../../../quran/viewmodel/last_played_cubit/last_played.dart';
import '../../../viewmodel/surah_list/surahs_list_cubit.dart';
import '../../../viewmodel/surah_list/surahs_list_state.dart';
import 'last_played_section.dart';
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

  Future<void> _navigateTo({required int surah, required int ayah}) async {
    await navigateWithTransition(
      type: TransitionType.fade,
      context,
      QuranView(
        surahNumber: surah,
        reciter: widget.selectedReciter,
        currentAyah: ayah,
      ),
    );
    if (mounted) {
      context.read<LastPlayedCubit>().initialize();
    }
  }

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: _scrollController,
    child: CustomScrollView(
      controller: _scrollController,
      slivers: [
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
        BlocBuilder<SurahListCubit, SurahsListState>(
          buildWhen: (previous, current) =>
              previous.searchText != current.searchText ||
              previous.searchResults.length != current.searchResults.length,
          builder: (context, state) {
            if (state.searchText.isNotEmpty) {
              return ResultsCount(
                searchText: state.searchText,
                resultsCount: state.searchResults.length,
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
        BlocBuilder<SurahListCubit, SurahsListState>(
          buildWhen: (previous, current) =>
              previous.searchText != current.searchText,
          builder: (context, state) {
            if (state.searchText.isEmpty) {
              return LastPlayedSection(navigateToSurah: _navigateTo);
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
        BlocBuilder<SurahListCubit, SurahsListState>(
          buildWhen: (previous, current) =>
              previous.searchText != current.searchText ||
              previous.searchResults != current.searchResults,
          builder: (context, state) {
            if (state.searchText.isNotEmpty) {
              return SearchResultsList(
                searchResults: state.searchResults,
                navigateToResult: _navigateTo,
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
        BlocBuilder<SurahListCubit, SurahsListState>(
          buildWhen: (previous, current) =>
              previous.searchText != current.searchText ||
              previous.filteredSurahs != current.filteredSurahs,
          builder: (context, state) {
            if (state.searchText.isEmpty) {
              return SurahList(
                surahs: state.filteredSurahs,
                isArabic: widget.isArabic,
                navigateToSurah: _navigateTo,
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    ),
  );
}
