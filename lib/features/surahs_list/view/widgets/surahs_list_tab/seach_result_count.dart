import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions.dart';

class ResultsCount extends StatelessWidget {
  const ResultsCount({
    required this.searchText,
    required this.resultsCount,
    super.key,
  });

  final String searchText;
  final int resultsCount;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          'نتائج البحث: $resultsCount',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.theme.primaryColor,
          ),
        ),
      ),
    ),
  );
}
