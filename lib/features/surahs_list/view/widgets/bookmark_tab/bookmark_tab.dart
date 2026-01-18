import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../core/utils/custom_loading_indicator.dart';
import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../../../core/widgets/base_app_dialog.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../quran/view/quran_view.dart';
import '../../../../quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import '../../../../quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';
import 'bookmark_card.dart';
import 'empty_bookmarks_state.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({
    required this.reciter,
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final String reciter;
  final AppLocalizations localizations;
  final bool isArabic;

  Future<void> _openBookmark(BuildContext context, int surah, int ayah) async {
    await navigateWithTransition(
      type: TransitionType.fade,
      context,
      QuranView(surahNumber: surah, reciter: reciter, currentAyah: ayah),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksCubit>();

    // Load bookmarks after first frame if empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state.bookmarks.isEmpty &&
          cubit.state.status != BookmarksStatus.loading) {
        cubit.load();
      }
    });

    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (previous, current) =>
          previous.bookmarks != current.bookmarks ||
          previous.status != current.status,
      builder: (context, state) {
        if (state.status == BookmarksStatus.loading) {
          return const Center(child: CustomLoadingIndicator(text: 'text'));
        }

        if (state.bookmarks.isEmpty) {
          return EmptyBookmarksState(message: localizations.emptyBookmarks);
        }

        return Scrollbar(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final bookmark = state.bookmarks[index];
                  return Dismissible(
                    key: Key(
                      'bookmark_${bookmark.surahNumber}_${bookmark.ayahNumber}',
                    ),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      padding: EdgeInsets.symmetric(horizontal: 20.toW),
                      margin: EdgeInsets.symmetric(
                        vertical: 6.toH,
                        horizontal: 8.toW,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(15.toR),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) => _showDeleteDialog(
                      context,
                      bookmark.surahNumber,
                      bookmark.ayahNumber,
                      localizations,
                      isArabic,
                    ),
                    onDismissed: (direction) async {
                      await cubit.removeBookmark(
                        surah: bookmark.surahNumber,
                        ayah: bookmark.ayahNumber,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${localizations.deleteBookmarkSuccess} '
                              '${isArabic ? quran.getSurahNameArabic(bookmark.surahNumber) : quran.getSurahName(bookmark.surahNumber)} '
                              '${isArabic ? 'آية' : 'Verse'} ${bookmark.ayahNumber}',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: BookmarkCard(
                      bookmark: bookmark,
                      isArabic: isArabic,
                      localizations: localizations,
                      reciter: reciter,
                      onOpen: () => _openBookmark(
                        context,
                        bookmark.surahNumber,
                        bookmark.ayahNumber,
                      ),
                      onDelete: () async {
                        final confirmed = await _showDeleteDialog(
                          context,
                          bookmark.surahNumber,
                          bookmark.ayahNumber,
                          localizations,
                          isArabic,
                        );

                        if (confirmed == true) {
                          await cubit.removeBookmark(
                            surah: bookmark.surahNumber,
                            ayah: bookmark.ayahNumber,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${localizations.deleteBookmarkSuccess} '
                                  '${isArabic ? quran.getSurahNameArabic(bookmark.surahNumber) : quran.getSurahName(bookmark.surahNumber)} '
                                  '${isArabic ? 'آية' : 'Verse'} ${bookmark.ayahNumber}',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  );
                }, childCount: state.bookmarks.length),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> _showDeleteDialog(
    BuildContext context,
    int surahNumber,
    int ayahNumber,
    AppLocalizations localizations,
    bool isArabic,
  ) {
    final surahName = isArabic
        ? quran.getSurahNameArabic(surahNumber)
        : quran.getSurahName(surahNumber);

    return BaseAppDialog.show<bool>(
      context,
      title: localizations.deleteBookmark,
      contentText:
          '${localizations.deleteBookmarkQuestion} $surahName '
          '${isArabic ? 'الآية رقم' : 'Verse Number'} '
          '${isArabic ? convertToArabicNumbers(ayahNumber.toString()) : ayahNumber}?',
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(localizations.cancelButton),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            localizations.deleteButton,
            style: TextStyle(color: context.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
