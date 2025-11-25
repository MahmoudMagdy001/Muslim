import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/utils/custom_loading_indicator.dart';
import '../../../l10n/app_localizations.dart';
import '../model/names_of_allah_model.dart';
import 'widgets/name_of_allah_card.dart';
import 'widgets/shareable_name_of_allah_card.dart';

class NamesOfAllahScreen extends StatefulWidget {
  const NamesOfAllahScreen({super.key});

  @override
  State<NamesOfAllahScreen> createState() => _NamesOfAllahScreenState();
}

class _NamesOfAllahScreenState extends State<NamesOfAllahScreen> {
  Future<NamesOfAllahModel>? _namesOfAllahFuture;
  final TextEditingController _searchController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  String searchQuery = '';
  bool _isSharing = false;
  int? _sharingIndex;

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

  Future<void> _shareAsImage(DataItem data, int index, bool isArabic) async {
    setState(() {
      _isSharing = true;
      _sharingIndex = index;
    });

    try {
      final imageBytes = await _screenshotController.captureFromWidget(
        ShareableNameOfAllahCard(data: data, isArabic: isArabic),
        delay: const Duration(milliseconds: 10),
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/names_of_allah_${index + 1}.png');
      await file.writeAsBytes(imageBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: isArabic
              ? 'أسماء الله الحسني - مشاركه من تطبيق مُسَلِّم'
              : 'Names of Allah - Shared from Muslim App',
          subject: isArabic ? 'أسماء الله الحسني' : 'Names of Allah',
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isArabic ? 'حدث خطأ أثناء المشاركة' : 'Error sharing image',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
          _sharingIndex = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

            // Filter data based on search query
            final filteredData = allData.where((data) {
              if (searchQuery.isEmpty) return true;
              final searchLower = searchQuery.toLowerCase();
              final name = isArabic ? data.name : data.nameTranslation;
              final text = isArabic ? data.text : data.textTranslation;
              return name.toLowerCase().contains(searchLower) ||
                  text.toLowerCase().contains(searchLower);
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: isArabic
                          ? 'ابحث عن اسم الله...'
                          : 'Search for Allah\'s name...',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredData.isEmpty
                      ? Center(
                          child: Text(
                            isArabic ? 'لا توجد نتائج' : 'No results found',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            final data = filteredData[index];
                            // Find the original index for the correct number display
                            final originalIndex = allData.indexOf(data);

                            return NameOfAllahCard(
                              data: data,
                              index: originalIndex,
                              isArabic: isArabic,
                              isSharing:
                                  _isSharing && _sharingIndex == originalIndex,
                              onShare: () =>
                                  _shareAsImage(data, originalIndex, isArabic),
                            );
                          },
                        ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CustomLoadingIndicator(text: ''));
        },
      ),
    );
  }
}
