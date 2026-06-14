import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_cubit.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/hadith_view/hadith_view.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/saved_hadiths_view/widgets/saved_hadith_card.dart';
import 'package:muslim/features/surahs_list/view/widgets/bookmark_tab/empty_bookmarks_state.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    unawaited(_loadSavedHadiths());
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
      final decoded = json.decode(saved);
      if (decoded is Iterable) {
        savedHadithsNotifier.value =
            decoded.map((dynamic e) => Map<String, dynamic>.from(e as Map)).toList();
      }
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

    unawaited(
      navigateWithTransition<void>(
        context,
        BlocProvider(
          create: (context) {
            final cubit = getIt<HadithCubit>();
            unawaited(cubit.initializeData(
              hadith['bookSlug'] as String,
              hadith['chapterNumber'] as String,
              hadith['chapterName'] as String,
            ));
            return cubit;
          },
          child: HadithView(
            bookSlug: hadith['bookSlug'] as String,
            chapterNumber: hadith['chapterNumber'] as String,
            chapterName: hadith['chapterName'] as String,
            localizations: AppLocalizations.of(context),
            scrollToHadithId: hadithId,
          ),
        ),
        type: TransitionType.fade,
      ).then((_) => _loadSavedHadiths()),
    );
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
                scrollCacheExtent: ScrollCacheExtent.pixels(context.screenHeight * 0.9),
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
                        BaseAppDialog.show<bool>(
                          context,
                          title: 'تأكيد الحذف',
                          contentText:
                              'هل انت متاكد من حذف حديث رقم ${convertToArabicNumbers(hadith['id'].toString())} من المحفوظات؟',
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
                    onDismissed: (direction) => unawaited(_removeHadith(index)),
                    child: SavedHadithCard(
                      hadith: hadith,
                      onTap: () => _navigateToHadith(hadith),
                      onDelete: () async {
                        final confirm = await BaseAppDialog.show<bool>(
                          context,
                          title: 'تأكيد الحذف',
                          contentText:
                              'هل انت متاكد من حذف رقم ${convertToArabicNumbers(hadith['id'].toString())} من المحفوظات؟',
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
                        if (confirm ?? false) {
                          await _removeHadith(index);
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
