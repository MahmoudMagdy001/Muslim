import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../azkar/presentation/views/azkar_view.dart';
import '../../../hadith/presentation/views/hadith_books_view.dart';
import '../../../names_of_allah/presentation/cubit/names_of_allah_cubit.dart';
import '../../../names_of_allah/presentation/views/names_of_allah_screen.dart';
import '../../../qiblah/presentation/cubit/qiblah_cubit.dart';
import '../../../qiblah/presentation/views/qiblah_view.dart';
import '../../../sebha/presentation/cubit/sebha_cubit.dart';
import '../../../sebha/presentation/views/sebha_view.dart';
import '../../../settings/view_model/rectire/rectire_cubit.dart';
import '../../../surahs_list/view/surahs_list_view.dart';
import '../../model/dashboard_item_model.dart';
import 'dashboard_button.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({required this.localizations, super.key});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.watch<ReciterCubit>();

    final List<DashboardItemModel> items = [
      DashboardItemModel(
        image: 'assets/home/quran.png',
        label: localizations.quranButton,
        color: const Color(0xFFB1D4F3),
        darkColor: const Color(0xFF2C4A70),
        route: SurahsListView(
          selectedReciter: reciterCubit.state.selectedReciter,
        ),
      ),
      DashboardItemModel(
        image: 'assets/home/hadith.png',
        label: localizations.hadithButton,
        color: const Color(0xFFBAE6A2),
        darkColor: const Color(0xFF395A33),
        route: const HadithBooksView(),
      ),

      DashboardItemModel(
        image: 'assets/home/azkar.png',
        label: localizations.azkarButton,
        color: const Color(0xFFFEED9A),
        darkColor: const Color(0xFF9E8E3E),
        route: const AzkarView(),
      ),
      DashboardItemModel(
        image: 'assets/home/qibla.png',
        label: localizations.qiblahButton,
        color: const Color(0xFFCEB6F6),
        darkColor: const Color(0xFF5D4E75),
        route: BlocProvider(
          create: (_) => getIt<QiblahCubit>()..init(),
          child: const QiblahView(),
        ),
      ),
      DashboardItemModel(
        image: 'assets/home/tasbih.png',
        label: localizations.sebha,
        color: const Color(0xFFC2EFE1),
        darkColor: const Color(0xFF386E5D),
        route: BlocProvider(
          create: (_) => getIt<SebhaCubit>()..loadCustomAzkar(),
          child: const SebhaView(),
        ),
      ),
      DashboardItemModel(
        image: 'assets/home/allah_Names.png',
        label: localizations.namesOfAllah,
        color: const Color(0xFFE0E0E0),
        darkColor: const Color(0xFF424242),
        route: BlocProvider(
          create: (_) => getIt<NamesOfAllahCubit>(),
          child: const NamesOfAllahScreen(),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .symmetric(horizontal: 16.toW, vertical: 8.toH),
          child: Text(
            localizations.allServices,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.brightness == Brightness.dark
                  ? AppColors.white
                  : const Color(0xff4C406F),
            ),
          ),
        ),
        GridView.builder(
          padding: .symmetric(horizontal: 6.toW, vertical: 8.toH),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 6.toW,
            mainAxisSpacing: 6.toH,
            childAspectRatio: 0.90,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return DashboardButton(item: item);
          },
        ),
      ],
    );
  }
}
