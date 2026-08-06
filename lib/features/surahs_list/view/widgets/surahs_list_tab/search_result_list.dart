import 'package:flutter/material.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/surahs_list/model/search_model.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/search_result_tile.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    required this.searchResults,
    required this.navigateToResult,
    super.key,
  });

  final List<SearchResult> searchResults;
  final Future<void> Function({required int surah, required int ayah})
  navigateToResult;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (searchResults.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.toH, horizontal: 20.toW),
          child: Center(
            child: Text(
              l10n.noResultsFound,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    final surahResults = searchResults.where((r) => r.isSurah).toList();
    final ayahResults = searchResults.where((r) => !r.isSurah).toList();

    return SliverList(
      delegate: SliverChildListDelegate([
        if (surahResults.isNotEmpty) ...[
          _buildHeader(context, l10n.surahsText),
          ...surahResults.map(
            (result) => SearchResultTile(
              result: result,
              onTap: () => navigateToResult(surah: result.surahNumber, ayah: 1),
            ),
          ),
        ],
        if (ayahResults.isNotEmpty) ...[
          _buildHeader(context, l10n.ayatText),
          ...ayahResults.map(
            (result) => SearchResultTile(
              result: result,
              onTap: () => navigateToResult(
                surah: result.surahNumber,
                ayah: result.verseNumber,
              ),
            ),
          ),
        ],
        SizedBox(height: 16.toH),
      ]),
    );
  }

  Widget _buildHeader(BuildContext context, String title) => Padding(
    padding: EdgeInsets.fromLTRB(16.toW, 16.toH, 16.toW, 8.toH),
    child: Text(
      title,
      style: context.theme.textTheme.titleMedium?.copyWith(
        color: context.theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
