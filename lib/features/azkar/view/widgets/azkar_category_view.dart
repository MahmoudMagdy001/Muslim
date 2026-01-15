import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/custom_loading_indicator.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
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
  final TextEditingController _searchController = TextEditingController();
  Map<String, List<AzkarModel>> _filteredGroupedAzkar = {};

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
    _filteredGroupedAzkar = grouped;
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(localization.azkarCategoryList)),
      body: SafeArea(
        child: FutureBuilder<Map<String, List<AzkarModel>>>(
          future: _groupedAzkarFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomLoadingIndicator(
                text: localization.azkarLoadingText,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${localization.azkarError} ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text(localization.azkarError));
            } else {
              return Scrollbar(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsetsDirectional.only(
                        start: 8.toW,
                        end: 16.toW,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final category = _filteredGroupedAzkar.keys.elementAt(
                            index,
                          );
                          final azkarList = _filteredGroupedAzkar[category]!;
                          return _AzkarCategoryListItem(
                            index: index + 1,
                            category: category,
                            azkarList: azkarList,
                            isArabic: isArabic,
                          );
                        }, childCount: _filteredGroupedAzkar.keys.length),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _AzkarCategoryListItem extends StatelessWidget {
  const _AzkarCategoryListItem({
    required this.index,
    required this.category,
    required this.azkarList,
    required this.isArabic,
  });

  final int index;
  final String category;
  final List<AzkarModel> azkarList;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.toH),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.cardGradient(context),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.toR),
      ),
      child: InkWell(
        onTap: () {
          navigateWithTransition(
            type: TransitionType.fade,
            context,
            AzkarListView(category: category, azkarList: azkarList),
          );
        },
        borderRadius: BorderRadius.circular(15.toR),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/quran/marker.png',
                    width: 40.toW,
                    height: 40.toH,
                  ),
                  Text(
                    isArabic
                        ? convertToArabicNumbers(index.toString())
                        : index.toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.toW),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.toH),
                    Text(
                      '${isArabic ? convertToArabicNumbers(azkarList.length.toString()) : azkarList.length} ${localization.azkar}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onPrimary.withAlpha(180),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: context.colorScheme.onPrimary,
                size: 16.toR,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
