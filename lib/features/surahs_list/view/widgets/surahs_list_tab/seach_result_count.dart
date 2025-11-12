import 'package:flutter/material.dart';

class ResultsCount extends StatelessWidget {
  const ResultsCount({
    required this.searchText,
    required this.resultsCount,
    required this.theme,
    super.key,
  });

  final String searchText;
  final int resultsCount;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          'نتائج البحث: $resultsCount',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.primaryColor),
        ),
      ),
    ),
  );
}
