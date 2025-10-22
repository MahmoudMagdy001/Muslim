import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../quran/view/quran_view.dart';
import '../../model/surahs_list_model.dart';
import '../../viewmodel/surah_list/surahs_list_cubit.dart';
import '../../viewmodel/surah_list/surahs_list_state.dart';
import 'surahs_list_tile.dart';

class SurahListTab extends StatefulWidget {
  const SurahListTab({required this.selectedReciter, super.key});
  final String selectedReciter;

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
  Widget build(BuildContext context) =>
      BlocBuilder<SurahListCubit, SurahsListState>(
        builder: (context, state) => Scrollbar(
          controller: _controller,
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              // صندوق البحث
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
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
              ),

              // نتائج البحث
              if (state.searchText.isNotEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'نتائج البحث: ${state.filteredSurahs.length} سورة',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
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
                    );
                  }, childCount: state.filteredSurahs.length),
                ),
              ),
            ],
          ),
        ),
      );
}
