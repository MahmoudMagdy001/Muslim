import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/quran/view/quran_view.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';
import 'package:muslim/features/surahs_list/view/widgets/bookmark_tab/bookmark_card.dart';
import 'package:muslim/features/surahs_list/view/widgets/bookmark_tab/empty_bookmarks_state.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({
    required this.reciter,
    required this.localizations,
    super.key,
  });

  final String reciter;
  final AppLocalizations localizations;

  Future<void> _openBookmark(BuildContext context, int surah, int ayah) async {
    await navigateWithTransition<void>(
      type: TransitionType.fade,
      context,
      QuranView(surahNumber: surah, reciter: reciter, currentAyah: ayah),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksCubit>();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state.bookmarks.isEmpty &&
          cubit.state.status != BookmarksStatus.loading) {
        unawaited(cubit.load());
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
                    ),
                    onDismissed: (direction) async {
                      await cubit.removeBookmark(
                        surah: bookmark.surahNumber,
                        ayah: bookmark.ayahNumber,
                      );
                      if (context.mounted) {
                        final surahName = isArabic
                            ? quran.getSurahNameArabic(bookmark.surahNumber)
                            : quran.getSurahName(bookmark.surahNumber);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${localizations.deleteBookmarkSuccess} $surahName ${l10n.ayahNumberLabel(bookmark.ayahNumber)}',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: BookmarkCard(
                      bookmark: bookmark,
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
                        );

                        if (confirmed ?? false) {
                          await cubit.removeBookmark(
                            surah: bookmark.surahNumber,
                            ayah: bookmark.ayahNumber,
                          );
                          if (context.mounted) {
                            final surahName = isArabic
                                ? quran.getSurahNameArabic(bookmark.surahNumber)
                                : quran.getSurahName(bookmark.surahNumber);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${localizations.deleteBookmarkSuccess} $surahName ${l10n.ayahNumberLabel(bookmark.ayahNumber)}',
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
  ) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;
    final surahName = isArabic
        ? quran.getSurahNameArabic(surahNumber)
        : quran.getSurahName(surahNumber);

    return BaseAppDialog.show<bool>(
      context,
      title: localizations.deleteBookmark,
      contentText:
          '${localizations.deleteBookmarkQuestion} $surahName '
          '${l10n.ayahNumberLabel(ayahNumber)}?',
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
