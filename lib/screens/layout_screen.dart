import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/azkar/view/azkar_view.dart';
import '../features/settings/view/settings_view.dart';
import '../features/settings/view_model/rectire/rectire_cubit.dart';
import '../features/prayer_times/view/prayer_times_view.dart';
import '../features/qiblah/view/qiblah_view.dart';

import '../features/surahs_list/view/surahs_list_view.dart';
import 'hadith_books_screen.dart';

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
        appBar: AppBar(title: const Text('مُسَلِّم')),
        body: const _LayoutContent(),
      ),
    );
  }
}

class _LayoutContent extends StatelessWidget {
  const _LayoutContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _PrayerTimesSection(),

          const SizedBox(height: 10),
          _DashboardGrid(),
          const SizedBox(height: 10),

          RandomZekrWidget(theme: theme),
        ],
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    children: const [
      _DashboardButton(
        icon: Icons.auto_stories_rounded,
        label: 'سور القرآن',
        routeBuilder: _surahListRoute,
      ),
      _DashboardButton(
        icon: Icons.library_books_rounded,
        label: 'كتب الحديث',
        routeBuilder: _hadithBooksRoute,
      ),
      _DashboardButton(
        icon: Icons.menu_book_outlined,
        label: 'الأذكار',
        routeBuilder: _azkarRoute,
      ),

      _DashboardButton(
        icon: Icons.explore_rounded,
        label: 'اتجاه القبلة',
        routeBuilder: _qiblahRoute,
      ),
      _DashboardButton(
        icon: Icons.settings_rounded,
        label: 'الإعدادات',
        routeBuilder: _settingsRoute,
      ),
    ],
  );

  static MaterialPageRoute _surahListRoute(
    BuildContext context,
    String reciter,
  ) => MaterialPageRoute(
    builder: (_) => SurahsListView(selectedReciter: reciter),
  );

  static MaterialPageRoute _hadithBooksRoute(
    BuildContext context,
    String reciter,
  ) => MaterialPageRoute(builder: (_) => const HadithBooksScreen());

  static MaterialPageRoute _settingsRoute(
    BuildContext context,
    String reciter,
  ) => MaterialPageRoute(builder: (_) => const SettingsView());
  static MaterialPageRoute _azkarRoute(BuildContext context, String reciter) =>
      MaterialPageRoute(builder: (_) => const AzkarView());

  static MaterialPageRoute _qiblahRoute(BuildContext context, String reciter) =>
      MaterialPageRoute(builder: (_) => const QiblahView());
}

class _DashboardButton extends StatelessWidget {
  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.routeBuilder,
  });
  final IconData icon;
  final String label;
  final MaterialPageRoute Function(BuildContext, String) routeBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ReciterCubit, ReciterState>(
      builder: (context, state) => InkWell(
        onTap: () async {
          final route = routeBuilder(context, state.selectedReciterId);
          await Navigator.of(context).push(route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: theme.brightness == Brightness.dark
                  ? theme.colorScheme.primary.withAlpha(102)
                  : theme.colorScheme.primary,
              child: Icon(
                icon,
                color: theme.brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.brightness == Brightness.dark
                    ? Colors.white70
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerTimesSection extends StatelessWidget {
  const _PrayerTimesSection();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [PrayerTimesView()],
  );
}

class RandomZekrWidget extends StatefulWidget {
  const RandomZekrWidget({required this.theme, super.key});
  final ThemeData theme;

  @override
  State<RandomZekrWidget> createState() => _RandomZekrWidgetState();
}

class _RandomZekrWidgetState extends State<RandomZekrWidget> {
  List<String> _zekrList = [];
  String _currentZekr = 'جاري تحميل الذكر...';

  @override
  void initState() {
    super.initState();
    _loadZekr();
  }

  Future<void> _loadZekr() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/azkar/azkar.json',
      );
      final data = jsonDecode(response) as List;
      final List<String> loadedZekrs = data
          .map((jsonItem) => jsonItem['zekr'] as String)
          .toList();
      if (loadedZekrs.isNotEmpty) {
        setState(() {
          _zekrList = loadedZekrs;
          _currentZekr = _getRandomZekr(_zekrList);
        });
      } else {
        setState(() {
          _currentZekr = 'لا توجد أذكار لعرضها.';
        });
      }
    } catch (e) {
      setState(() {
        _currentZekr = 'خطأ في تحميل الأذكار.';
      });
    }
  }

  String _getRandomZekr(List<String> list) {
    if (list.isEmpty) return 'لا يوجد أذكار.';
    final randomIndex = DateTime.now().millisecondsSinceEpoch % list.length;
    return list[randomIndex];
  }

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الذكر اليومي',
                style: widget.theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
              ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       _currentZekr = _getRandomZekr(_zekrList);
              //     });
              //   },
              //   icon: const Icon(Icons.refresh),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _currentZekr,
            textAlign: TextAlign.right,
            style: widget.theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              height: 2.1,
            ),
          ),
        ],
      ),
    ),
  );
}
