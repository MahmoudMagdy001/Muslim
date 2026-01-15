import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../model/search_model.dart';
import 'search_result_tile.dart';

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
    if (searchResults.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.toH, horizontal: 20.toW),
          child: Center(
            child: Text(
              'لا توجد نتائج',
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
          _buildHeader(context, 'السور'),
          ...surahResults.map(
            (result) => SearchResultTile(
              result: result,
              isArabic: true, // Assuming Arabic as per user request context
              onTap: () => navigateToResult(surah: result.surahNumber, ayah: 1),
            ),
          ),
        ],
        if (ayahResults.isNotEmpty) ...[
          _buildHeader(context, 'الآيات'),
          ...ayahResults.map(
            (result) => SearchResultTile(
              result: result,
              isArabic: true,
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
