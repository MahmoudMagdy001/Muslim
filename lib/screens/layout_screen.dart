import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/settings/view/settings_view.dart';
import '../features/settings/view_model/rectire/rectire_cubit.dart';
import '../core/service/last_read_service.dart';
import '../features/prayer_times/view/prayer_times_view.dart';
import '../features/qiblah/view/qiblah_view.dart';
import '../features/quran/view/quran_view.dart';
import '../features/surahs_list/view/surahs_list_view.dart';
import 'hadith_books_screen.dart';
import 'package:quran/quran.dart' as quran;

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late ValueNotifier<Map<String, dynamic>?> _lastSurahDataNotifier;
  final lastReadService = LastReadService();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastSurahDataNotifier = ValueNotifier(null);
    _loadLastSurah();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lastSurahDataNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ReciterCubit>().refreshReciter();
      _loadLastSurah();
    }
  }

  Future<void> _loadLastSurah() async {
    final data = await lastReadService.loadLastRead();
    if (mounted) {
      _lastSurahDataNotifier.value = data;
    }
  }

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
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _LastSurahCard(),
        const SizedBox(height: 20),
        _DashboardGrid(),
        const SizedBox(height: 20),
        const _PrayerTimesSection(),
      ],
    ),
  );
}

class _DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 15,
    mainAxisSpacing: 15,
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
        icon: Icons.settings_rounded,
        label: 'الإعدادات',
        routeBuilder: _settingsRoute,
      ),
      _DashboardButton(
        icon: Icons.explore_rounded,
        label: 'اتجاه القبلة',
        routeBuilder: _qiblahRoute,
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
      builder: (context, state) => GestureDetector(
        onTap: () async {
          final route = routeBuilder(context, state.selectedReciterId);
          await Navigator.of(context).push(route);
          if (label == 'سور القرآن') {
            if (context.mounted) {
              context
                  .findAncestorStateOfType<_LayoutScreenState>()!
                  ._loadLastSurah();
            }
          }
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: theme.brightness == Brightness.dark
                  ? theme.colorScheme.primary.withAlpha(102) // 0.4 * 255
                  : theme.colorScheme.primary,
              child: Icon(
                icon,
                color: theme.brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
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

class _LastSurahCard extends StatelessWidget {
  const _LastSurahCard();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_LayoutScreenState>()!;

    return BlocBuilder<ReciterCubit, ReciterState>(
      builder: (context, reciterState) =>
          ValueListenableBuilder<Map<String, dynamic>?>(
            valueListenable: state._lastSurahDataNotifier,
            builder: (context, data, child) {
              if (data == null || data['surah'] == null) {
                return _buildEmptyCard(context, reciterState.selectedReciterId);
              }

              return _buildLastSurahCard(
                context,
                data,
                reciterState.selectedReciterId,
              );
            },
          ),
    );
  }

  Widget _buildEmptyCard(BuildContext context, String selectedReciter) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('لم تستمع لأي سورة بعد', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 10),
            ElevatedButton(
              style: theme.elevatedButtonTheme.style,
              onPressed: () async {
                final reciterCubit = context.read<ReciterCubit>();
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuranView(
                      surahNumber: 1,
                      reciter: reciterCubit.state.selectedReciterId,
                      currentAyah: 1,
                    ),
                  ),
                );

                if (context.mounted) {
                  context
                      .findAncestorStateOfType<_LayoutScreenState>()!
                      ._loadLastSurah();
                }
              },
              child: Text(
                'ابدأ من سورة الفاتحة',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastSurahCard(
    BuildContext context,
    Map<String, dynamic> data,
    String selectedReciter,
  ) {
    final theme = Theme.of(context);
    final surahNumber = data['surah'] as int;
    final lastAyah = data['ayah'] as int;
    final lastOpened = data['lastOpened'] as String? ?? '';

    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => QuranView(
                surahNumber: surahNumber,
                reciter: selectedReciter,
                currentAyah: lastAyah,
              ),
            ),
          );
          if (context.mounted) {
            context
                .findAncestorStateOfType<_LayoutScreenState>()!
                ._loadLastSurah();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'آخر سورة استمعت لها : ${quran.getSurahNameArabic(surahNumber)}',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      'رقم السورة: $surahNumber | عدد الآيات: ${quran.getVerseCount(surahNumber)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'آخر آية استمعت لها: $lastAyah${lastOpened.isNotEmpty ? ' | آخر فتح: $lastOpened' : ''}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrayerTimesSection extends StatelessWidget {
  const _PrayerTimesSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'مواقيت الصلاة',
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const PrayerTimesView(),
      ],
    );
  }
}
