import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart'; // 👈 استيراد الباكدج
import '../../../core/utils/format_helper.dart';
import '../model/names_of_allah_model.dart';

class NamesOfAllahScreen extends StatefulWidget {
  const NamesOfAllahScreen({super.key});

  @override
  State<NamesOfAllahScreen> createState() => _NamesOfAllahScreenState();
}

class _NamesOfAllahScreenState extends State<NamesOfAllahScreen> {
  Future<NamesOfAllahModel>? _namesOfAllahFuture;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _namesOfAllahFuture = _loadNamesOfAllah();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<NamesOfAllahModel> _loadNamesOfAllah() async {
    final String response = await rootBundle.loadString(
      'assets/json/names_of_allah.json',
    );
    final data = await json.decode(response);
    return NamesOfAllahModel.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('أسماء الله الحسنى')),
      body: FutureBuilder<NamesOfAllahModel>(
        future: _namesOfAllahFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allData = snapshot.data!.items;
            // فلترة حسب البحث
            final filteredData = allData.where((item) {
              final name = item.name;
              final text = item.text;
              return name.contains(searchQuery) || text.contains(searchQuery);
            }).toList();
    
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'ابحث عن اسم...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final data = filteredData[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                convertToArabicNumbers(data.id.toString()),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data.name,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.share_rounded),
                                      onPressed: () {
                                        SharePlus.instance.share(
                                          ShareParams(
                                            text: 'المعني: ${data.text}',
                                            title: data.name,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'المعني : ${data.text}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
    
                          // 👇 زرار Share
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
