import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../quran/view/quran_view.dart';
import '../../quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import '../../quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';
import '../model/surahs_list_model.dart';
import '../repository/surahs_list_repository_impl.dart';
import '../service/surahs_list_service.dart';
import '../viewmodel/surah_list/surahs_list_cubit.dart';
import '../viewmodel/surah_list/surahs_list_state.dart';
import 'widgets/surahs_list_tile.dart';

class SurahsListView extends StatelessWidget {
  const SurahsListView({required this.selectedReciter, super.key});
  final String selectedReciter;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SurahListCubit(
          surahRepository: SurahsListRepositoryImpl(SurahsListService()),
        ),
      ),
    ],
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('القرآن الكريم'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'السور'),
                Tab(text: 'العلامات'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // التبويب الأول: قائمة السور
              _SurahListTab(selectedReciter: selectedReciter),

              // التبويب الثاني: العلامات
              _BookmarksTab(reciter: selectedReciter),
            ],
          ),
        ),
      ),
    ),
  );
}

class _SurahListTab extends StatefulWidget {
  const _SurahListTab({required this.selectedReciter});
  final String selectedReciter;

  @override
  State<_SurahListTab> createState() => _SurahListTabState();
}

class _SurahListTabState extends State<_SurahListTab> {
  final _controller = ScrollController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSurah(SurahsListModel surah) async {
    await Navigator.of(context).push<int?>(
      MaterialPageRoute(
        builder: (_) => QuranView(
          surahNumber: surah.number,
          reciter: widget.selectedReciter,
          currentAyah: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: BlocBuilder<SurahListCubit, SurahsListState>(
      builder: (context, state) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث باسم السورة...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: state.searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SurahListCubit>().filterSurahs('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                context.read<SurahListCubit>().filterSurahs(value);
              },
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          ),

          // نتائج البحث
          if (state.searchText.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'نتائج البحث: ${state.filteredSurahs.length} سورة',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
          // ليست السور
          Expanded(
            child: Scrollbar(
              controller: _controller,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 12),
                controller: _controller,
                itemCount: state.filteredSurahs.length,
                cacheExtent: 1000,
                itemExtent: 110,
                itemBuilder: (context, index) {
                  final surah = state.filteredSurahs[index];
                  return SurahListTile(
                    surah: surah,
                    onTap: () => _navigateToSurah(surah),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _BookmarksTab extends StatelessWidget {
  const _BookmarksTab({required this.reciter});
  final String reciter;

  Future<void> _openBookmark(BuildContext context, int surah, int ayah) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            QuranView(surahNumber: surah, reciter: reciter, currentAyah: ayah),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<BookmarksCubit, BookmarksState>(
        builder: (context, state) {
          if (state.status == BookmarksStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.bookmarks.isEmpty) {
            return const Center(child: Text('لا توجد علامات بعد'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state.bookmarks.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final bookMark = state.bookmarks[index];
              final surahName = quran.getSurahNameArabic(bookMark.surahNumber);
              final ayahNumber = bookMark.ayahNumber;
              final ayahText = bookMark.ayahText;
              return Card(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سورة $surahName',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ayahText,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.9,
                        ),
                      ),
                    ],
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (BuildContext context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            title: Text(
                              'مسح العلامه',
                              style: theme.textTheme.titleMedium,
                            ),
                            content: Text(
                              'هل انت متاكد من انك تريد مسح العلامه من السوره $surahName الآية رقم $ayahNumber ؟',
                              style: theme.textTheme.bodyMedium,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  'تجاهل',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(
                                  'مسح',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      if (result == true) {
                        if (context.mounted) {
                          context.read<BookmarksCubit>().removeBookmark(
                            surah: bookMark.surahNumber,
                            ayah: bookMark.ayahNumber,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'تم مسح العلامة من سورة $surahName آية $ayahNumber',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  onTap: () => _openBookmark(
                    context,
                    bookMark.surahNumber,
                    bookMark.ayahNumber,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
