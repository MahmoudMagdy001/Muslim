import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/format_helper.dart';
import '../../helper/prayer_consts.dart';
import '../../helper/time_left_format.dart';
import '../../viewmodel/prayer_times_cubit.dart';
import '../../viewmodel/prayer_times_state.dart';
import 'more_prayer_times_button.dart';

class CurrentPrayerCard extends StatelessWidget {
  const CurrentPrayerCard({
    required this.hijriDate,
    required this.theme,
    super.key,
  });

  final String hijriDate;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🏙️ المدينة
        _CityText(theme),
        // 🕌 التاريخ الهجري + زر التحديث
        Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 5,
            start: 10,
            end: 5,
            bottom: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hijriDate, style: theme.textTheme.bodyMedium),
              const _RefreshButton(),
            ],
          ),
        ),
        // 🕋 اسم الصلاة القادمة + وقتها
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 10,
            end: 5,
            bottom: 5,
          ),
          child: Row(
            children: [
              _NextPrayerName(theme),
              const SizedBox(width: 8),
              const _NextPrayerTime(),
            ],
          ),
        ),
        // ⏳ الوقت المتبقي
        _TimeLeftText(theme),
        const Divider(thickness: 0.1),
        // 📅 زر المزيد من مواقيت الصلاة
        MorePrayerTimesButton(theme: theme, hijriDate: hijriDate),
      ],
    ),
  );
}

class _CityText extends StatelessWidget {
  const _CityText(this.theme);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Center(
      child: BlocSelector<PrayerTimesCubit, PrayerTimesState, String?>(
        selector: (state) => state.city,
        builder: (context, city) =>
            Text(city ?? '--------------', style: theme.textTheme.bodyMedium),
      ),
    ),
  );
}

class _NextPrayerName extends StatelessWidget {
  const _NextPrayerName(this.theme);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, String?>(
        selector: (state) => state.nextPrayer,
        builder: (context, nextPrayer) => Text(
          prayerNamesAr[nextPrayer] ?? '------',
          style: theme.textTheme.labelLarge,
        ),
      );
}

class _NextPrayerTime extends StatelessWidget {
  const _NextPrayerTime();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<
        PrayerTimesCubit,
        PrayerTimesState,
        ({String? nextPrayer, Map<String, dynamic>? localPrayerTimes})
      >(
        selector: (state) => (
          nextPrayer: state.nextPrayer,
          localPrayerTimes: state.localPrayerTimes?.toMap(),
        ),
        builder: (context, data) {
          final timingsMap = data.localPrayerTimes ?? {};
          final next = data.nextPrayer;
          final time = next != null
              ? formatTo12Hour(timingsMap[next] ?? '')
              : '00:00 ص';
          return Text(
            time,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          );
        },
      );
}

class _TimeLeftText extends StatelessWidget {
  const _TimeLeftText(this.theme);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, Duration?>(
        selector: (state) => state.timeLeft,
        builder: (context, timeLeft) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 10,
            end: 5,
            bottom: 8,
            top: 16,
          ),
          child: Text(
            formatTimeLeft(
              timeLeft ?? const Duration(hours: 1, minutes: 23, seconds: 45),
            ),
            style: theme.textTheme.bodySmall,
          ),
        ),
      );
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () async {
      HapticFeedback.heavyImpact();
      await context.read<PrayerTimesCubit>().refreshPrayerTimes();
    },
    icon: const Icon(Icons.refresh_rounded),
    tooltip: 'تحديث مواقيت الصلاة',
  );
}
