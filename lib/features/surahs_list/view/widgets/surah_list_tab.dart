import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../quran/service/quran_service.dart';
import '../../../quran/view/quran_view.dart';
import '../../../quran/viewmodel/last_played_cubit/last_played.dart';
import '../../model/surahs_list_model.dart';
import '../../viewmodel/surah_list/surahs_list_cubit.dart';
import '../../viewmodel/surah_list/surahs_list_state.dart';
import 'surahs_list_tile.dart';

class SurahListTab extends StatefulWidget {
  const SurahListTab({
    required this.selectedReciter,
    required this.isArabic,
    required this.localizations,
    required this.theme,
    super.key,
  });
  final String selectedReciter;
  final bool isArabic;
  final AppLocalizations localizations;
  final ThemeData theme;

  @override
  State<SurahListTab> createState() => _SurahListTabState();
}

class _SurahListTabState extends State<SurahListTab> {
  final _controller = ScrollController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSurah(SurahsListModel surah) async {
    await navigateWithTransition(
      type: TransitionType.fade,
      context,
      QuranView(
        surahNumber: surah.number,
        reciter: widget.selectedReciter,
        currentAyah: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quranService = QuranService();

    return BlocProvider(
      create: (context) => LastPlayedCubit(quranService)..initialize(),
      child: BlocBuilder<SurahListCubit, SurahsListState>(
        builder: (context, state) => Scrollbar(
          controller: _controller,
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              // صندوق البحث
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 6,
                    end: 18,
                    top: 6,
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: widget.localizations.searchForSurahName,
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
              ),

              // نتائج البحث
              if (state.searchText.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        '${widget.localizations.searchResult} ${state.filteredSurahs.length}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child:
                    BlocSelector<
                      LastPlayedCubit,
                      Map<String, dynamic>?,
                      Map<String, dynamic>?
                    >(
                      selector: (state) => state,

                      builder: (context, lastPlayed) {
                        if (lastPlayed == null) return const SizedBox.shrink();

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Card(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => navigateWithTransition(
                                context,
                                QuranView(
                                  surahNumber: lastPlayed['surah'],
                                  reciter: widget.selectedReciter,
                                  currentAyah: lastPlayed['verse'],
                                ),
                              ),
                              child: ListTile(
                                trailing: const Icon(Icons.arrow_back_ios),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'آخر سوره استمعت لها: سورة ${quran.getSurahNameArabic(lastPlayed['surah'])}',
                                      style: widget.theme.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'آية رقم: ${convertToArabicNumbers(lastPlayed['verse'].toString())}',
                                      style: widget.theme.textTheme.bodyLarge,
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

              // ليست السور
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15,
                  bottom: 15,
                  start: 6,
                  end: 18,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final surah = state.filteredSurahs[index];
                    return SurahListTile(
                      surah: surah,
                      onTap: () => _navigateToSurah(surah),
                      isArabic: widget.isArabic,
                    );
                  }, childCount: state.filteredSurahs.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
