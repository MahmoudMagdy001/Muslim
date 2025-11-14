import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../helper/hadith_helper.dart';
import 'hadith_screen.dart';

class SavedHadithScreen extends StatefulWidget {
  const SavedHadithScreen({super.key});

  @override
  State<SavedHadithScreen> createState() => _SavedHadithScreenState();
}

class _SavedHadithScreenState extends State<SavedHadithScreen> {
  List<Map<String, dynamic>> _savedHadiths = [];
  final Map<int, bool> _expandedMap = {};

  @override
  void initState() {
    super.initState();
    _loadSavedHadiths();
  }

  Future<void> _loadSavedHadiths() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('saved_hadiths');
    if (saved != null) {
      setState(() {
        _savedHadiths = List<Map<String, dynamic>>.from(json.decode(saved));
      });
    }
  }

  Future<void> _removeHadith(int index) async {
    final prefs = await SharedPreferences.getInstance();
    _savedHadiths.removeAt(index);
    await prefs.setString('saved_hadiths', json.encode(_savedHadiths));
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حذف الحديث رقم: ${index + 1}')),
      );
    }
  }

  void _navigateToHadith(Map<String, dynamic> hadith) {
    final hadithId = int.tryParse(hadith['id'].toString());
    if (hadithId == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HadithsScreen(
          bookSlug: hadith['bookSlug'],
          chapterNumber: hadith['chapterNumber'],
          chapterName: hadith['chapterName'],
          localizations: AppLocalizations.of(context),
          scrollToHadithId: hadithId,
        ),
      ),
    ).then(
      (value) => setState(() {
        _loadSavedHadiths();
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'صحيح':
      case 'Sahih':
      case 'sahih':
        return Colors.green;
      case 'حسن':
      case 'Hasan':
      case 'hasan':
        return Colors.blue;
      case 'ضعيف':
      case 'Da`eef':
      case 'da`eef':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('الأحاديث المحفوظة')),
      body: _savedHadiths.isEmpty
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bookmark_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا يوجد أحاديث محفوظة',
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            )
          : SafeArea(
              child: ListView.builder(
                // padding: const EdgeInsets.all(16),
                itemCount: _savedHadiths.length,
                itemBuilder: (context, index) {
                  final hadith = _savedHadiths[index];
                  final chapterName = hadith['chapterName'];
                  final chapterNumber = convertToArabicNumbers(
                    hadith['chapterNumber'],
                  );
                  final chapterId = convertToArabicNumbers(hadith['id']);
                  final isExpanded = _expandedMap[index] ?? false;

                  String displayedText = hadith['text'];
                  if (!isExpanded && displayedText.length > 200) {
                    displayedText = '${displayedText.substring(0, 200)}...';
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Card(
                      child: InkWell(
                        onTap: () => _navigateToHadith(hadith),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الكتاب: ${bookSlugArabic[hadith['bookSlug']]}',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'الفصل: $chapterName - رقم : $chapterNumber',
                              ),
                              Text('رقم الحديث: $chapterId'),
                              const SizedBox(height: 8),
                              SelectableText(
                                displayedText,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  height: 2.1,
                                ),
                              ),
                              // ignore: avoid_dynamic_calls
                              if (hadith['text'].length > 200)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _expandedMap[index] =
                                            !(_expandedMap[index] ?? false);
                                      });
                                    },
                                    child: Text(
                                      isExpanded ? 'عرض أقل' : 'عرض المزيد',
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الحكم: ${hadith['status']}',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: _getStatusColor(hadith['status']),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removeHadith(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
