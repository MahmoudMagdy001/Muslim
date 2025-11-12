import 'package:flutter/material.dart';

import '../../../../../core/utils/format_helper.dart';
import '../../../model/search_model.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    required this.searchResults,
    required this.theme,
    required this.navigateToResult,
    super.key,
  });

  final List<SearchResult> searchResults;
  final ThemeData theme;
  final Future<void> Function({required int surah, required int ayah})
  navigateToResult;

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text('لا توجد نتائج', style: theme.textTheme.bodyMedium),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsetsDirectional.only(
        top: 8,
        bottom: 15,
        start: 6,
        end: 18,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final result = searchResults[index];
          return Card(
            child: ListTile(
              title: Text(
                'سورة ${result.surahName} - آية ${convertToArabicNumbers(result.verseNumber.toString())}',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  result.ayahText,
                  textAlign: TextAlign.justify,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 2.1),
                ),
              ),
              onTap: () => navigateToResult(
                surah: result.surahNumber,
                ayah: result.verseNumber,
              ),
            ),
          );
        }, childCount: searchResults.length),
      ),
    );
  }
}
