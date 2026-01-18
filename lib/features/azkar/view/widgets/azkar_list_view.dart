import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'azkar_item_card.dart';
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.category)),
    body: Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.azkarList.length,
        itemBuilder: (context, index) => AzkarItemCard(
          item: widget.azkarList[index],
          currentCount: currentCounts[index],
          totalCount: totalCounts[index],
          onIncrement: () => _incrementCounter(index),
          onReset: () => _resetCounter(index),
        ),
      ),
    ),
  );
}
