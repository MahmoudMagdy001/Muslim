import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../names_of_allah/view/names_of_allah_screen.dart';
import '../../../prayer_times/view/prayer_times_view.dart';
import '../../../sebha/view/sebha_view.dart';
import '../../../zakat/view/zakat_view.dart';
import 'dashboard_list.dart';
import 'feature_card.dart';

class LayoutContent extends StatelessWidget {
  const LayoutContent(this.scaffoldContext, this.theme, {super.key});

  final BuildContext scaffoldContext;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      // عرض أوقات الصلاة
      PrayerTimesView(scaffoldContext: scaffoldContext, theme: theme),

      // محتوى الداشبورد
      DashboardGrid(theme: theme),

      // الأقسام الإضافية (أسماء الله – السبحة )
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: FeatureCard(
                  label: 'اسماء الله الحسنى',
                  image: 'assets/images/allah.png',
                  onTap: () => navigateWithTransition(
                    context,
                    const NamesOfAllahScreen(),
                  ),
                  theme: theme,
                ),
              ),
              Expanded(
                child: FeatureCard(
                  label: 'السبحه',
                  image: 'assets/images/seb7a.png',
                  onTap: () =>
                      navigateWithTransition(context, const SebhaView()),
                  theme: theme,
                ),
              ),
            ],
          ),
        ),
      ),

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
          child: Card(
            child: InkWell(
              onTap: () => navigateWithTransition(
                type: TransitionType.fade,
                context,
                const ZakatView(),
              ),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'زكاتي',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'قال ﷺ: "ما نقص مالٌ من صدقةٍ."',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'ابدأ الآن بحساب زكاتك وتذكّر فضلها العظيم',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      cacheHeight: 126,
                      cacheWidth: 126,
                      'assets/images/zakat.png',
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
