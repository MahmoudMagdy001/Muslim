import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/navigation_helper.dart';
import '../../../quran/view/quran_view.dart';
import '../../../quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import '../../../quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({required this.reciter, super.key});
  final String reciter;

  Future<void> _openBookmark(BuildContext context, int surah, int ayah) async {
    await navigateWithTransition(
      type: TransitionType.fade,
      context,
      QuranView(surahNumber: surah, reciter: reciter, currentAyah: ayah),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<BookmarksCubit, BookmarksState>(
      listener: (context, state) {
        // يمكنك إضافة أي تفاعل إضافي هنا عند تغيير الحالة
      },
      child: BlocBuilder<BookmarksCubit, BookmarksState>(
        buildWhen: (previous, current) =>
            previous.bookmarks != current.bookmarks ||
            previous.status != current.status,
        builder: (context, state) {
          if (state.status == BookmarksStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.bookmarks.isEmpty) {
            return const Center(child: Text('لا توجد علامات بعد'));
          }

          return Scrollbar(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final bookMark = state.bookmarks[index];
                    final surahName = quran.getSurahNameArabic(
                      bookMark.surahNumber,
                    );
                    final ayahNumber = bookMark.ayahNumber;
                    final ayahText = bookMark.ayahText;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          _openBookmark(
                            context,
                            bookMark.surahNumber,
                            bookMark.ayahNumber,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'سورة $surahName',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  IconButton(
                                    tooltip: 'مسح العلامه',
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    onPressed: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text(
                                                'مسح العلامه',
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                              content: Text(
                                                'هل انت متاكد من انك تريد مسح العلامه من السوره $surahName الآية رقم $ayahNumber ؟',
                                                style:
                                                    theme.textTheme.bodyMedium,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                    context,
                                                  ).pop(false),
                                                  child: Text(
                                                    'تجاهل',
                                                    style: theme
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                    context,
                                                  ).pop(true),
                                                  child: Text(
                                                    'مسح',
                                                    style: theme
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          color: Colors.red,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );

                                      if (result == true) {
                                        // استخدم await للتأكد من اكتمال العملية
                                        if (context.mounted) {
                                          await context
                                              .read<BookmarksCubit>()
                                              .removeBookmark(
                                                surah: bookMark.surahNumber,
                                                ayah: bookMark.ayahNumber,
                                              );
                                        }

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'تم مسح العلامة من سورة $surahName آية $ayahNumber',
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                ayahText,
                                style: theme.textTheme.titleMedium!.copyWith(
                                  height: 1.9,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, childCount: state.bookmarks.length),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
