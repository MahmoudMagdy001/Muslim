import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/format_helper.dart';

import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import 'widgets/current_prayer_card_widget.dart';
import 'widgets/more_prayer_times_button.dart';

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
    child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        if (state.status == PrayerTimesStatus.error) {
          return _PrayerErrorSliver(
            message: state.message ?? 'حدث خطأ غير متوقع',
          );
        }

        // ✅ نستخدم Skeletonizer هنا
        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: state.status == PrayerTimesStatus.loading,
            child: _PrayerSuccessSliver(
              state: state,
              theme: theme,
              scaffoldContext: scaffoldContext,
            ),
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

/// 📌 حالة النجاح
class _PrayerSuccessSliver extends StatelessWidget {
  const _PrayerSuccessSliver({
    required this.state,
    required this.theme,
    required this.scaffoldContext,
  });

  final PrayerTimesState state;
  final ThemeData theme;
  final BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    final timingsMap = state.localPrayerTimes?.toMap() ?? {};
    final hijriDate = _getHijriDate();

    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            state.city ?? '--------------',
            style: theme.textTheme.bodyMedium,
          ),
          CurrentPrayerCard(
            state: state,
            timingsMap: timingsMap,
            hijriDate: hijriDate,
            scaffoldContext: scaffoldContext,
          ),
          const Divider(thickness: 0.1),
          MorePrayerTimesButton(theme: theme, hijriDate: hijriDate),
        ],
      ),
    );
  }

  String _getHijriDate() {
    final hijri = HijriCalendar.now();
    final day = convertToArabicNumbers(hijri.hDay.toString());
    final year = convertToArabicNumbers(hijri.hYear.toString());
    final monthName = getArabicMonthName(hijri.hMonth);
    return '$day $monthName $year هـ';
  }
}
