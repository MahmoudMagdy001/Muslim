import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RandomZekrWidget extends StatefulWidget {
  const RandomZekrWidget({super.key});

  @override
  State<RandomZekrWidget> createState() => _RandomZekrWidgetState();
}

class _RandomZekrWidgetState extends State<RandomZekrWidget> {
  List<String> _zekrList = [];
  String _currentZekr = 'جاري تحميل الذكر...';
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadZekr();
  }

  Future<void> _loadZekr() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/azkar/azkar.json',
      );
      final data = jsonDecode(response) as List;
      final List<String> loadedZekrs = data
          .map((jsonItem) => jsonItem['zekr'] as String)
          .toList();

      if (loadedZekrs.isNotEmpty) {
        setState(() {
          _zekrList = loadedZekrs;
          _currentZekr = _getRandomZekr();
        });
      } else {
        setState(() {
          _currentZekr = 'لا توجد أذكار لعرضها.';
        });
      }
    } catch (e) {
      setState(() {
        _currentZekr = 'خطأ في تحميل الأذكار.';
      });
    }
  }

  String _getRandomZekr() {
    if (_zekrList.isEmpty) return 'لا يوجد أذكار.';
    return _zekrList[_random.nextInt(_zekrList.length)];
  }

  void _refreshZekr() {
    setState(() {
      _currentZekr = _getRandomZekr();
    });
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ذكر اليوم',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _refreshZekr,
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: 'تغيير الذكر',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // محتوى الذكر
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
              ),
              child: Text(
                _currentZekr,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
