import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../../core/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../model/azkar_model/azkar_model.dart';

class AzkarListView extends StatefulWidget {
  const AzkarListView({
    required this.category,
    required this.azkarList,
    super.key,
  });

  final String category;
  final List<AzkarModel> azkarList;

  @override
  State<AzkarListView> createState() => _AzkarListViewState();
}

class _AzkarListViewState extends State<AzkarListView> {
  late List<ValueNotifier<int>> currentCounts;
  late List<int> totalCounts;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentCounts = List.generate(
      widget.azkarList.length,
      (index) => ValueNotifier(0),
    );
    totalCounts = widget.azkarList.map((e) => e.count ?? 1).toList();
    _loadPersistedCounts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var notifier in currentCounts) {
      notifier.dispose();
    }
    super.dispose();
  }

  Future<void> _loadPersistedCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastUpdateDate = prefs.getString('azkar_last_update_date');

    // Reset counts if it's a new day
    if (lastUpdateDate != today) {
      await prefs.setString('azkar_last_update_date', today);
      await prefs.remove('azkar_daily_counts');
      return;
    }

    final savedData = prefs.getString('azkar_daily_counts');
    if (savedData != null) {
      final Map<String, dynamic> countsMap = jsonDecode(savedData);
      for (int i = 0; i < widget.azkarList.length; i++) {
        final zekrKey = widget.azkarList[i].zekr;
        if (zekrKey != null && countsMap.containsKey(zekrKey)) {
          currentCounts[i].value = countsMap[zekrKey] as int;
        }
      }
    }
  }

  Future<void> _saveCurrentCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> countsMap = {};
    for (int i = 0; i < widget.azkarList.length; i++) {
      final zekrKey = widget.azkarList[i].zekr;
      if (zekrKey != null) {
        countsMap[zekrKey] = currentCounts[i].value;
      }
    }
    await prefs.setString('azkar_daily_counts', jsonEncode(countsMap));
  }

  void _incrementCounter(int index) {
    if (currentCounts[index].value < totalCounts[index]) {
      currentCounts[index].value++;
      _saveCurrentCounts();
    }
  }

  void _resetCounter(int index) {
    currentCounts[index].value = 0;
    _saveCurrentCounts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.azkarList.length,
          itemBuilder: (context, index) {
            final item = widget.azkarList[index];
            final total = totalCounts[index];
            final hasCount = total > 0;

            return ValueListenableBuilder<int>(
              valueListenable: currentCounts[index],
              builder: (context, current, child) {
                final isFinished = current >= total;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsetsDirectional.only(
                    start: 8.toW,
                    end: 16.toW,
                    top: 6.toH,
                    bottom: 6.toH,
                  ),
                  decoration: BoxDecoration(
                    color: theme
                        .colorScheme
                        .primaryContainer, // Mint green background equivalent
                    borderRadius: BorderRadius.circular(20.toR),
                    border: Border.all(
                      color: isFinished && hasCount
                          ? theme.colorScheme.secondary
                          : Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.toR),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // النص الأساسي - الذكر
                            Align(
                              child: Text(
                                item.zekr ?? '',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  height: 1.7,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            if ((item.reference?.isNotEmpty ?? false) ||
                                (item.description?.isNotEmpty ?? false))
                              SizedBox(height: 16.toH),

                            // المرجع - pill shape
                            if (item.reference?.isNotEmpty ?? false)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.toW,
                                  vertical: 8.toH,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.toR),
                                ),
                                child: Text(
                                  '${localization.revision}: ${item.reference}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.primary.withAlpha(
                                      150,
                                    ), // gray 666666 equivalent
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),

                            // الوصف - gray text below reference
                            if (item.description?.isNotEmpty ?? false) ...[
                              if (item.reference?.isNotEmpty ?? false)
                                SizedBox(height: 12.toH),
                              Text(
                                item.description!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white60,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // قسم الأزرار (يظهر فقط لو فيه تكرار)
                      if (hasCount) ...[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            16.toW,
                            0,
                            16.toW,
                            16.toH,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    current.toString(),
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: Colors.white,

                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    '/',
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    total.toString(),
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () => _resetCounter(index),
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                iconSize: 32.toR,
                              ),
                              SizedBox(
                                height: 42.toH,
                                width: 130.toW,
                                child: ElevatedButton(
                                  onPressed: isFinished
                                      ? null
                                      : () {
                                          HapticFeedback.mediumImpact();
                                          _incrementCounter(index);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        theme.colorScheme.secondary,
                                    foregroundColor:
                                        theme.colorScheme.onSecondary,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        25.toR,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    localization.tasbih,
                                    style: context.textTheme.titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
