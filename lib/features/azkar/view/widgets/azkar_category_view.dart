import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/azkar_model/azkar_model.dart';
import 'azkar_list_view.dart';

class AzkarCategoriesView extends StatefulWidget {
  const AzkarCategoriesView({super.key});

  @override
  State<AzkarCategoriesView> createState() => _AzkarCategoriesViewState();
}

class _AzkarCategoriesViewState extends State<AzkarCategoriesView> {
  Map<String, List<AzkarModel>> groupedAzkar = {};

  @override
  void initState() {
    super.initState();
    loadAzkar();
  }

  Future<void> loadAzkar() async {
    final String response = await rootBundle.loadString(
      'assets/azkar/azkar.json',
    );
    final data = jsonDecode(response) as List;
    

    final List<AzkarModel> azkarList = data
        .map((e) => AzkarModel.fromJson(e))
        .toList();

    final Map<String, List<AzkarModel>> grouped = {};
    for (var zekr in azkarList) {
      final category = zekr.category;
      grouped.putIfAbsent(category, () => []);
      grouped[category]!.add(zekr);
    }

    setState(() {
      groupedAzkar = grouped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قائمة أنواع الأذكار'),
          centerTitle: true,
        ),
        body: groupedAzkar.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('جاري تحميل الأذكار...'),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: groupedAzkar.keys.length,
                itemBuilder: (context, index) {
                  final category = groupedAzkar.keys.elementAt(index);
                  final azkarList = groupedAzkar[category]!;
                  final count = azkarList.length;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AzkarListView(
                              category: category,
                              azkarList: azkarList,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            // أيقونة
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.book,
                                color: colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // النص
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$count أذكار',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // سهم الاتجاه
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
                },
              ),
      ),
    );
  }
}
