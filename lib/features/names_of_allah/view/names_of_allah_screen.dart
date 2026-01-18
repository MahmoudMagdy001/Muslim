import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/utils/custom_loading_indicator.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../model/names_of_allah_model.dart';
import 'widgets/name_of_allah_card.dart';
import 'widgets/shareable_name_of_allah_card.dart';
import '../../../core/utils/extensions.dart';

class NamesOfAllahScreen extends StatefulWidget {
  const NamesOfAllahScreen({super.key});

  @override
  State<NamesOfAllahScreen> createState() => _NamesOfAllahScreenState();
}

class _NamesOfAllahScreenState extends State<NamesOfAllahScreen> {
  Future<NamesOfAllahModel>? _namesOfAllahFuture;
  final TextEditingController _searchController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier('');
  final ValueNotifier<bool> isSharingNotifier = ValueNotifier(false);
  final ValueNotifier<int?> sharingIndexNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _namesOfAllahFuture = _loadNamesOfAllah();
    _searchController.addListener(() {
      searchQueryNotifier.value = _searchController.text.trim();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    searchQueryNotifier.dispose();
    isSharingNotifier.dispose();
    sharingIndexNotifier.dispose();
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
    isSharingNotifier.value = true;
    sharingIndexNotifier.value = index;

    try {
      // Small delay to ensure UI updates before capture
      await Future.delayed(const Duration(milliseconds: 50));
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
        isSharingNotifier.value = false;
        sharingIndexNotifier.value = null;
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

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.toW,
                    vertical: 8.toH,
                  ),
                  child: TextField(
                    controller: _searchController,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    decoration: InputDecoration(
                      hintText: isArabic
                          ? 'ابحث عن اسم الله...'
                          : 'Search for Allah\'s name...',
                      hintStyle: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant.withAlpha(
                          150,
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.toH,
                          horizontal: 8.toW,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.toH,
                            horizontal: 8.toW,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12.toR),
                          ),
                          child: Image.asset(
                            'assets/quran/search.png',
                            width: 20.toW,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (context, value, _) => value.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: context.theme.primaryColor,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  searchQueryNotifier.value = '';
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.toW,
                        vertical: 12.toH,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: searchQueryNotifier,
                    builder: (context, searchQuery, child) {
                      // Filter data based on search query
                      final filteredData = allData.where((data) {
                        if (searchQuery.isEmpty) return true;
                        final searchLower = searchQuery.toLowerCase();
                        final name = isArabic
                            ? data.name
                            : data.nameTranslation;
                        final text = isArabic
                            ? data.text
                            : data.textTranslation;
                        return name.toLowerCase().contains(searchLower) ||
                            text.toLowerCase().contains(searchLower);
                      }).toList();

                      if (filteredData.isEmpty) {
                        return Center(
                          child: Text(
                            isArabic ? 'لا توجد نتائج' : 'No results found',
                            style: context.textTheme.bodyLarge,
                          ),
                        );
                      }

                      return ValueListenableBuilder<bool>(
                        valueListenable: isSharingNotifier,
                        builder: (context, isSharing, _) =>
                            ValueListenableBuilder<int?>(
                              valueListenable: sharingIndexNotifier,
                              builder: (context, sharingIndex, _) =>
                                  ListView.builder(
                                    itemCount: filteredData.length,
                                    itemBuilder: (context, index) {
                                      final data = filteredData[index];
                                      final originalIndex = allData.indexOf(
                                        data,
                                      );

                                      return NameOfAllahCard(
                                        data: data,
                                        index: originalIndex,
                                        isArabic: isArabic,
                                        isSharing:
                                            isSharing &&
                                            sharingIndex == originalIndex,
                                        onShare: () => _shareAsImage(
                                          data,
                                          originalIndex,
                                          isArabic,
                                        ),
                                      );
                                    },
                                  ),
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
          return const Center(child: CustomLoadingIndicator(text: ''));
        },
      ),
    );
  }
}
