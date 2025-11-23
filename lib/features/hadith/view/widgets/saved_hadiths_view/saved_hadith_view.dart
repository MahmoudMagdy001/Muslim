import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../l10n/app_localizations.dart';
import '../hadith_view/hadith_view.dart';
import 'widgets/saved_hadith_card.dart';

class SavedHadithView extends StatefulWidget {
  const SavedHadithView({super.key});

  @override
  State<SavedHadithView> createState() => _SavedHadithViewState();
}

class _SavedHadithViewState extends State<SavedHadithView> {
  List<Map<String, dynamic>> _savedHadiths = [];

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

    navigateWithTransition(
      type: TransitionType.fade,
      context,
      HadithView(
        bookSlug: hadith['bookSlug'],
        chapterNumber: hadith['chapterNumber'],
        chapterName: hadith['chapterName'],
        localizations: AppLocalizations.of(context),
        scrollToHadithId: hadithId,
      ),
    ).then(
      (value) => setState(() {
        _loadSavedHadiths();
      }),
    );
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
                cacheExtent: MediaQuery.of(context).size.height * 0.9,
                itemCount: _savedHadiths.length,
                itemBuilder: (context, index) {
                  final hadith = _savedHadiths[index];
                  return SavedHadithCard(
                    hadith: hadith,
                    onTap: () => _navigateToHadith(hadith),
                    onDelete: () => _removeHadith(index),
                  );
                },
              ),
            ),
    );
  }
}
