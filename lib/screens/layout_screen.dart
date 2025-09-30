// layout_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/navigation_helper.dart';
import '../features/azkar/view/azkar_view.dart';
import '../features/prayer_times/view/prayer_times_view.dart';
import '../features/qiblah/view/qiblah_view.dart';
import '../features/settings/view/settings_view.dart';
import '../features/settings/view_model/rectire/rectire_cubit.dart';
import '../features/surahs_list/view/surahs_list_view.dart';
import 'hadith_books_screen.dart';
import 'random_zekr_view.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Builder(
          // ⬅ Builder بيرجع context مربوط بـ Scaffold ده
          builder: (scaffoldContext) => _LayoutContent(scaffoldContext),
        ),
      ),
    );
  }
}

class _LayoutContent extends StatelessWidget {
  const _LayoutContent(this.scaffoldContext);
  final BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(title: Text('مُسَلِّم'), pinned: true),
        PrayerTimesView(scaffoldContext: scaffoldContext), // ⬅ مررت الـ context
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          sliver: _DashboardGrid(theme: theme),
        ),
        const RandomZekrWidget(),
      ],
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  const _DashboardGrid({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.watch<ReciterCubit>();

    final List<DashboardItem> items = [
      DashboardItem(
        icon: Icons.auto_stories_rounded,
        label: 'القرآن الكريم',
        color: Colors.blue,
        route: SurahsListView(
          selectedReciter: reciterCubit.state.selectedReciter,
        ),
      ),
      const DashboardItem(
        icon: Icons.library_books_rounded,
        label: 'الحديث',
        color: Colors.green,
        route: HadithBooksScreen(),
      ),
      const DashboardItem(
        icon: Icons.psychology_rounded,
        label: 'الأذكار',
        color: Colors.orange,
        route: AzkarView(),
      ),
      const DashboardItem(
        icon: Icons.explore_rounded,
        label: 'القبلة',
        color: Colors.purple,
        route: QiblahView(),
      ),
      const DashboardItem(
        icon: Icons.settings_rounded,
        label: 'الإعدادات',
        color: Colors.grey,
        route: SettingsView(),
      ),
    ];

    return SliverAnimatedGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: _DashboardButton(item: items[index], theme: theme),
        ),
      ),
      initialItemCount: items.length,
    );
  }
}

class DashboardItem {
  const DashboardItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Widget route;
}

class _DashboardButton extends StatelessWidget {
  const _DashboardButton({required this.item, required this.theme});

  final DashboardItem item;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => navigateWithTransition(context, item.route),
    borderRadius: BorderRadius.circular(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, color: item.color, size: 32),
        const SizedBox(height: 12),
        Text(
          item.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.titleLarge?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
