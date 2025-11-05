import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/format_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import 'widgets/current_prayer_card_widget.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({
    required this.scaffoldContext,
    required this.theme,
    required this.localizations,
    super.key,
  });

  final BuildContext scaffoldContext;
  final ThemeData theme;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return BlocSelector<PrayerTimesCubit, PrayerTimesState, PrayerTimesStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        if (status == PrayerTimesStatus.error ||
            status == PrayerTimesStatus.permissionError) {
          final message = context.select(
            (PrayerTimesCubit cubit) =>
                cubit.state.message ?? localizations.errorMain,
          );
          return _PrayerErrorSliver(
            message: message,
            localizations: localizations,
            isArabic: isArabic,
          );
        }

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: status == PrayerTimesStatus.loading,
            child: _PrayerSuccessSliver(
              localizations: localizations,
              isArabic: isArabic,
            ),
          ),
        );
      },
    );
  }
}

class _PrayerErrorSliver extends StatelessWidget {
  const _PrayerErrorSliver({
    required this.message,
    required this.localizations,
    required this.isArabic,
  });

  final String message;
  final AppLocalizations localizations;
  final bool isArabic;

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
                await context.read<PrayerTimesCubit>().refreshPrayerTimes(
                  isArabic: isArabic,
                );
              },
              icon: const Icon(Icons.refresh),
              label: Text(localizations.retry),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PrayerSuccessSliver extends StatelessWidget {
  const _PrayerSuccessSliver({
    required this.localizations,
    required this.isArabic,
  });
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hijriDate = _getHijriDate(isArabic);

    return CurrentPrayerCard(
      hijriDate: hijriDate,
      theme: theme,
      localizations: localizations,
    );
  }

  static String _getHijriDate(bool isArabic) {
    final hijri = HijriCalendar.now();
    final day = isArabic
        ? convertToArabicNumbers(hijri.hDay.toString())
        : hijri.hDay.toString();
    final year = isArabic
        ? convertToArabicNumbers(hijri.hYear.toString())
        : hijri.hYear.toString();
    final monthName = isArabic
        ? getArabicMonthName(hijri.hMonth)
        : getEnglishHijriMonthName(hijri.hMonth);
    return '$day $monthName $year ${isArabic ? 'هـ' : 'Hijri'}';
  }
}
