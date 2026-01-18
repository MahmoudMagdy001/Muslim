import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/widgets/base_app_dialog.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../view_model/hadith/hadith_cubit.dart';
import '../hadith_view/hadith_view.dart';
import '../../../../surahs_list/view/widgets/bookmark_tab/empty_bookmarks_state.dart';
import 'widgets/saved_hadith_card.dart';

class SavedHadithView extends StatefulWidget {
  const SavedHadithView({super.key});

  @override
  State<SavedHadithView> createState() => _SavedHadithViewState();
}

class _SavedHadithViewState extends State<SavedHadithView> {
  final ValueNotifier<List<Map<String, dynamic>>> savedHadithsNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _loadSavedHadiths();
  }

  @override
  void dispose() {
    savedHadithsNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadSavedHadiths() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('saved_hadiths');
    if (saved != null) {
      savedHadithsNotifier.value = List<Map<String, dynamic>>.from(
        json.decode(saved),
      );
    }
  }

  Future<void> _removeHadith(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = List<Map<String, dynamic>>.from(
      savedHadithsNotifier.value,
    )..removeAt(index);
    await prefs.setString('saved_hadiths', json.encode(currentList));
    savedHadithsNotifier.value = currentList;

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
      context,
      BlocProvider(
        create: (context) => HadithCubit(
          bookSlug: hadith['bookSlug'],
          chapterNumber: hadith['chapterNumber'],
          chapterName: hadith['chapterName'],
        )..initializeData(),
        child: HadithView(
          bookSlug: hadith['bookSlug'],
          chapterNumber: hadith['chapterNumber'],
          chapterName: hadith['chapterName'],
          localizations: AppLocalizations.of(context),
          scrollToHadithId: hadithId,
        ),
      ),
      type: TransitionType.fade,
    ).then((value) => _loadSavedHadiths());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الأحاديث المحفوظة')),
    body: ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: savedHadithsNotifier,
      builder: (context, savedHadiths, child) => savedHadiths.isEmpty
          ? SafeArea(
              child: EmptyBookmarksState(
                message: AppLocalizations.of(context).savedHadithsEmpty,
              ),
            )
          : SafeArea(
              child: ListView.builder(
                cacheExtent: context.screenHeight * 0.9,
                itemCount: savedHadiths.length,
                itemBuilder: (context, index) {
                  final hadith = savedHadiths[index];
                  return Dismissible(
                    key: Key('${hadith['id']}_${hadith['bookSlug']}_$index'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: context.colorScheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async =>
                        await BaseAppDialog.show<bool>(
                          context,
                          title: 'تأكيد الحذف',
                          contentText:
                              'هل انت متاكد من حذف حديث رقم ${convertToArabicNumbers(hadith['id'])} من المحفوظات؟',
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('إلغاء'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                  color: context.colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                    onDismissed: (direction) => _removeHadith(index),
                    child: SavedHadithCard(
                      hadith: hadith,
                      onTap: () => _navigateToHadith(hadith),
                      onDelete: () async {
                        final confirm = await BaseAppDialog.show<bool>(
                          context,
                          title: 'تأكيد الحذف',
                          contentText:
                              'هل انت متاكد من حذف رقم ${convertToArabicNumbers(hadith['id'])} من المحفوظات؟',
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('إلغاء'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                  color: context.colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        );
                        if (confirm == true) {
                          _removeHadith(index);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
    ),
  );
}
