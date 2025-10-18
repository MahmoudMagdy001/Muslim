import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/ext/extention.dart';
import '../../model/azkar_model/azkar_model.dart';
import 'azkar_list_view.dart';

class AzkarCategoriesView extends StatefulWidget {
  const AzkarCategoriesView({super.key});

  @override
  State<AzkarCategoriesView> createState() => _AzkarCategoriesViewState();
}

class _AzkarCategoriesViewState extends State<AzkarCategoriesView> {
  Future<Map<String, List<AzkarModel>>>? _groupedAzkarFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_groupedAzkarFuture == null) {
      final locale = Localizations.localeOf(context).languageCode;
      final assetPath = (locale == 'ar')
          ? 'assets/json/azkar.json'
          : 'assets/json/azkar_en.json';
      _groupedAzkarFuture = _loadAndGroupAzkar(assetPath);
    }
  }

  /// A unified function to load and group Azkar from a given asset path.
  Future<Map<String, List<AzkarModel>>> _loadAndGroupAzkar(
    String assetPath,
  ) async {
    final String response = await rootBundle.loadString(assetPath);
    final data = jsonDecode(response) as List;

    final azkarList = data.map((e) => AzkarModel.fromJson(e)).toList();

    final Map<String, List<AzkarModel>> grouped = {};
    for (final zekr in azkarList) {
      final category = zekr.category;
      grouped.putIfAbsent(category, () => []);
      grouped[category]!.add(zekr);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.localization.azkarCategoryList)),
    body: SafeArea(
      child: FutureBuilder<Map<String, List<AzkarModel>>>(
        future: _groupedAzkarFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(context.localization.azkarLoadingText),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${context.localization.azkarError} ${snapshot.error}',
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(context.localization.azkarError));
          } else {
            final groupedAzkar = snapshot.data!;
            return Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 16,
                  top: 5,
                ),
                itemCount: groupedAzkar.keys.length,
                itemBuilder: (context, index) {
                  final category = groupedAzkar.keys.elementAt(index);
                  final azkarList = groupedAzkar[category]!;
                  return _AzkarCategoryListItem(
                    category: category,
                    azkarList: azkarList,
                  );
                },
              ),
            );
          }
        },
      ),
    ),
  );
}

class _AzkarCategoryListItem extends StatelessWidget {
  const _AzkarCategoryListItem({
    required this.category,
    required this.azkarList,
  });

  final String category;
  final List<AzkarModel> azkarList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final count = azkarList.length;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AzkarListView(category: category, azkarList: azkarList),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.book, color: colorScheme.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$count ${context.localization.azkar}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
