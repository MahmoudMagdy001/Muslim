import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/utils/format_helper.dart';
import '../../../l10n/app_localizations.dart';
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
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localizations.namesOfAllah)),
      body: FutureBuilder<NamesOfAllahModel>(
        future: _namesOfAllahFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allData = snapshot.data!.items;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      final data = allData[index];
                      final name = isArabic ? data.name : data.nameTranslation;
                      final text = isArabic ? data.text : data.textTranslation;

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
                                isArabic
                                    ? convertToArabicNumbers(
                                        (index + 1).toString(),
                                      )
                                    : (index + 1).toString(), // 👈 بدل data.id
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      name,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.share_rounded),
                                      onPressed: () {
                                        SharePlus.instance.share(
                                          ShareParams(
                                            text:
                                                '''
 الأسم: ${data.name}

 المعنى: ${data.text}

🔗 تم مشاركته من تطبيق مسلم 
''',
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '${isArabic ? 'المعني' : 'Meaning'} : $text',
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
