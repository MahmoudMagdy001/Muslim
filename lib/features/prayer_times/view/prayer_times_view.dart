import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/format_helper.dart';
import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import 'widgets/current_prayer_card_widget.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({
    required this.scaffoldContext,
    required this.theme,
    super.key,
  });

  final BuildContext scaffoldContext;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => PrayerTimesCubit()..init(),
    child: BlocSelector<PrayerTimesCubit, PrayerTimesState, PrayerTimesStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        if (status == PrayerTimesStatus.error) {
          final message = context.select(
            (PrayerTimesCubit cubit) =>
                cubit.state.message ?? 'حدث خطأ غير متوقع',
          );
          return _PrayerErrorSliver(message: message);
        }

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: status == PrayerTimesStatus.loading,
            child: const _PrayerSuccessSliver(),
          ),
        );
      },
    ),
  );
}

class _PrayerErrorSliver extends StatelessWidget {
  const _PrayerErrorSliver({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await context.read<PrayerTimesCubit>().refreshPrayerTimes();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PrayerSuccessSliver extends StatelessWidget {
  const _PrayerSuccessSliver();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hijriDate = _getHijriDate();

    return CurrentPrayerCard(hijriDate: hijriDate, theme: theme);
  }

  static String _getHijriDate() {
    final hijri = HijriCalendar.now();
    final day = convertToArabicNumbers(hijri.hDay.toString());
    final year = convertToArabicNumbers(hijri.hYear.toString());
    final monthName = getArabicMonthName(hijri.hMonth);
    return '$day $monthName $year هـ';
  }
}
