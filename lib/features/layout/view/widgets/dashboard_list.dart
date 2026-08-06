import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/azkar/presentation/views/azkar_view.dart';
import 'package:muslim/features/hadith/presentation/views/hadith_books_view.dart';
import 'package:muslim/features/layout/model/dashboard_item_model.dart';
import 'package:muslim/features/layout/view/widgets/dashboard_button.dart';
import 'package:muslim/features/names_of_allah/presentation/views/names_of_allah_screen.dart';
import 'package:muslim/features/qiblah/presentation/views/qiblah_view.dart';
import 'package:muslim/features/sebha/presentation/views/sebha_view.dart';
import 'package:muslim/features/settings/view_model/rectire/rectire_cubit.dart';
import 'package:muslim/features/surahs_list/view/surahs_list_view.dart';
import 'package:muslim/l10n/app_localizations.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({required this.localizations, super.key});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.watch<ReciterCubit>();

    final items = <DashboardItemModel>[
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
        route: const QiblahView(),
      ),
      DashboardItemModel(
        image: 'assets/home/tasbih.png',
        label: localizations.sebha,
        color: const Color(0xFFC2EFE1),
        darkColor: const Color(0xFF386E5D),
        route: const SebhaView(),
      ),
      DashboardItemModel(
        image: 'assets/home/allah_Names.png',
        label: localizations.namesOfAllah,
        color: const Color(0xFFE0E0E0),
        darkColor: const Color(0xFF424242),
        route: const NamesOfAllahScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: .symmetric(horizontal: 16.toW, vertical: 8.toH),
          child: Text(
            localizations.allServices,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.brightness == Brightness.dark
                  ? Colors.white
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
