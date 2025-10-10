import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/location_service.dart';
import '../../../hadith/view/hadith_books_view.dart';
import '../../../azkar/view/azkar_view.dart';
import '../../../qiblah/service/qiblah_service.dart';
import '../../../qiblah/view/qiblah_view.dart';
import '../../../qiblah/viewmodel/qiblah_cubit.dart';
import '../../../settings/view/settings_view.dart';
import '../../../settings/view_model/rectire/rectire_cubit.dart';
import '../../../surahs_list/view/surahs_list_view.dart';
import '../../model/dashboard_item_model.dart';
import 'dashboard_button.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({required this.theme, super.key});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.watch<ReciterCubit>();
    final height = MediaQuery.of(context).size.height;
    final List<DashboardItemModel> items = [
      DashboardItemModel(
        icon: Icons.auto_stories_rounded,
        label: 'القرآن',
        color: Colors.blue,
        route: SurahsListView(
          selectedReciter: reciterCubit.state.selectedReciter,
        ),
      ),
      const DashboardItemModel(
        icon: Icons.library_books_rounded,
        label: 'الحديث',
        color: Colors.green,
        route: HadithBooksView(),
      ),
      const DashboardItemModel(
        icon: Icons.psychology_rounded,
        label: 'الأذكار',
        color: Colors.orange,
        route: AzkarView(),
      ),
      DashboardItemModel(
        icon: Icons.explore_rounded,
        label: 'القبلة',
        color: Colors.purple,
        route: BlocProvider(
          create: (_) => QiblahCubit(
            service: QiblahService(),
            locationService: LocationService(),
          )..init(),
          child: const QiblahView(),
        ),
      ),
      const DashboardItemModel(
        icon: Icons.settings_rounded,
        label: 'الإعدادات',
        color: Colors.grey,
        route: SettingsView(),
      ),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: height * 0.07,
          child: ListView.builder(
            cacheExtent: 75,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: 75,
                child: DashboardButton(item: item, theme: theme),
              );
            },
          ),
        ),
      ),
    );
  }
}
