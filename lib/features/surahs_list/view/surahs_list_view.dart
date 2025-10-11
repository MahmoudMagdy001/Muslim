import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/surahs_list_repository_impl.dart';
import '../service/surahs_list_service.dart';
import '../viewmodel/surah_list/surahs_list_cubit.dart';
import 'widgets/bookmark_tab.dart';
import 'widgets/surah_list_tab.dart';

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
            SurahListTab(selectedReciter: selectedReciter),
            BookmarksTab(reciter: selectedReciter),
          ],
        ),
      ),
    ),
  );
}
