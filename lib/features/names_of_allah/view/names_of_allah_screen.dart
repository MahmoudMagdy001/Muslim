import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../core/utils/custom_loading_indicator.dart';
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
        Container(
          width: 800,
          height: 600,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'أسماء الله الحسني',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              // الرأس - رقم الاسم
              const SizedBox(height: 20),

              // اسم الله
              Text(
                data.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // الترجمة الإنجليزية
              if (!isArabic) ...[
                Text(
                  data.nameTranslation,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],

              // المعنى
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      isArabic ? 'المعنى' : 'Meaning',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isArabic ? data.text : data.textTranslation,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // التذييل
              Text(
                isArabic
                    ? 'تمت المشاركة من تطبيق مُسَلِّم'
                    : 'Shared from Muslim App',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );

      // حفظ الصورة
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/أسماء الله الحسني_${index + 1}.png');
      await file.writeAsBytes(imageBytes);

      // المشاركة
      // مشاركة صورة واحدة
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'أسماء الله الحسني - مشاركه من تطبيق مُسَلِّم',
          subject: 'أسماء الله الحسني',
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
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final localizations = AppLocalizations.of(context);

    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: AppBar(title: Text(localizations.namesOfAllah)),
        body: FutureBuilder<NamesOfAllahModel>(
          future: _namesOfAllahFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final allData = snapshot.data!.items;

              return Column(
                children: [
                  // حقل البحث (اختياري)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: isArabic
                            ? 'ابحث عن اسم الله...'
                            : 'Search for Allah\'s name...',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        final data = allData[index];
                        final name = isArabic
                            ? data.name
                            : data.nameTranslation;
                        final text = isArabic
                            ? data.text
                            : data.textTranslation;

                        // فلترة البحث
                        if (searchQuery.isNotEmpty) {
                          final searchLower = searchQuery.toLowerCase();
                          final nameMatches = name.toLowerCase().contains(
                            searchLower,
                          );
                          final textMatches = text.toLowerCase().contains(
                            searchLower,
                          );
                          if (!nameMatches && !textMatches) {
                            return const SizedBox.shrink();
                          }
                        }

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
                                      : (index + 1).toString(),
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
                                      Expanded(
                                        child: Text(
                                          name,
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      _isSharing && _sharingIndex == index
                                          ? SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(
                                                      theme.colorScheme.primary,
                                                    ),
                                              ),
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                Icons.share_rounded,
                                              ),
                                              onPressed: () {
                                                _shareAsImage(
                                                  data,
                                                  index,
                                                  isArabic,
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
      ),
    );
  }
}
