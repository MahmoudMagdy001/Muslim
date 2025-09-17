import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_error_message.dart';
import '../../quran/view/quran_view.dart';
import '../model/surahs_list_model.dart';
import '../repository/surahs_list_repository_impl.dart';
import '../service/surahs_list_service.dart';
import '../viewmodel/surahs_list_cubit.dart';
import '../viewmodel/surahs_list_state.dart';
import 'widgets/surahs_list_tile.dart';

class SurahsListView extends StatelessWidget {
  const SurahsListView({required this.selectedReciter, super.key});
  final String selectedReciter;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => SurahListCubit(
      surahRepository: SurahsListRepositoryImpl(SurahsListService()),
    ),
    child: _SurahListScreenContent(selectedReciter: selectedReciter),
  );
}

class _SurahListScreenContent extends StatefulWidget {
  const _SurahListScreenContent({required this.selectedReciter});
  final String selectedReciter;

  @override
  State<_SurahListScreenContent> createState() =>
      _SurahListScreenContentState();
}

class _SurahListScreenContentState extends State<_SurahListScreenContent> {
  final _controller = ScrollController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSurah(SurahsListModel surah) async {
    final cubit = context.read<SurahListCubit>()..saveLastSurah(surah.number);

    await Navigator.of(context).push<int?>(
      MaterialPageRoute(
        builder: (_) => QuranView(
          surahNumber: surah.number,
          reciter: widget.selectedReciter,
          currentAyah: 1,
        ),
      ),
    );

    // حفظ آخر آية بعد الرجوع
    if (mounted) {
      try {
        final repository = SurahsListRepositoryImpl(SurahsListService());
        final lastAyah = await repository.getLastAyah();
        cubit.saveLastSurah(surah.number, lastAyah: lastAyah);
      } catch (e) {
        debugPrint('Error updating last ayah: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('القرآن الكريم')),
      body: BlocBuilder<SurahListCubit, SurahsListState>(
        builder: (context, state) {
          if (state.status == SurahsListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == SurahsListStatus.error) {
            return CustomErrorMessage(errorMessage: state.message);
          }

          if (state.status == SurahsListStatus.success) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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

                // Results Count
                if (state.searchText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'نتائج البحث: ${state.filteredSurahs.length} سورة',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                Expanded(
                  child: Scrollbar(
                    controller: _controller,
                    child: ListView.builder(
                      shrinkWrap: true,
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
            );
          }

          return const SizedBox();
        },
      ),
    ),
  );
}
