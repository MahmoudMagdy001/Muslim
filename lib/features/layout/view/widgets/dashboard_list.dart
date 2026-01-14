import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/location_service.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../hadith/view/hadith_books_view.dart';
import '../../../azkar/view/azkar_view.dart';
import '../../../names_of_allah/view/names_of_allah_screen.dart';
import '../../../qiblah/service/qiblah_service.dart';
import '../../../qiblah/view/qiblah_view.dart';
import '../../../qiblah/viewmodel/qiblah_cubit.dart';
import '../../../sebha/view/sebha_view.dart';
import '../../../settings/view_model/rectire/rectire_cubit.dart';
import '../../../surahs_list/view/surahs_list_view.dart';
import '../../model/dashboard_item_model.dart';
import 'dashboard_button.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({
    required this.theme,
    required this.localizations,
    super.key,
  });

  final ThemeData theme;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.watch<ReciterCubit>();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final List<DashboardItemModel> items = [
      DashboardItemModel(
        image: 'assets/home/hadith.png',
        label: localizations.hadithButton,
        color: const Color(0xFFBAE6A2),
        route: const HadithBooksView(),
      ),
      DashboardItemModel(
        image: 'assets/home/quran.png',
        label: localizations.quranButton,
        color: const Color(0xFFB1D4F3),
        route: SurahsListView(
          selectedReciter: reciterCubit.state.selectedReciter,
        ),
      ),
      DashboardItemModel(
        image: 'assets/home/azkar.png',
        label: localizations.azkarButton,
        color: const Color(0xFFFEED9A),
        route: const AzkarView(),
      ),
      DashboardItemModel(
        image: 'assets/home/qibla.png',
        label: localizations.qiblahButton,
        color: const Color(0xFFCEB6F6),
        route: BlocProvider(
          create: (_) => QiblahCubit(
            service: QiblahService(),
            locationService: LocationService(),
          )..init(),
          child: const QiblahView(),
        ),
      ),
      DashboardItemModel(
        image: 'assets/home/tasbih.png',
        label: localizations.sebha,
        color: const Color(0xFFC2EFE1),
        route: SebhaView(localizations: localizations, isArabic: isArabic),
      ),
      DashboardItemModel(
        image: 'assets/home/allah_Names.png',
        label: localizations.namesOfAllah,
        color: const Color(0xFFE0E0E0),
        route: const NamesOfAllahScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .symmetric(horizontal: 16.toW, vertical: 8.toH),
          child: Text(
            localizations.allServices,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xff4C406F),
              fontSize: 20.toSp,
            ),
          ),
        ),
        GridView.builder(
          padding: .symmetric(horizontal: 16.toW, vertical: 8.toH),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.toW,
            mainAxisSpacing: 16.toH,
            childAspectRatio: 0.85,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return DashboardButton(item: item, theme: theme);
          },
        ),
      ],
    );
  }
}
