import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/utils/format_helper.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import 'widgets/current_prayer_card_widget.dart';

class PrayerTimesView extends StatefulWidget {
  const PrayerTimesView({
    required this.scaffoldContext,
    required this.localizations,
    super.key,
  });

  final BuildContext scaffoldContext;
  final AppLocalizations localizations;

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  @override
  void initState() {
    super.initState();
    final isArabic = widget.localizations.localeName == 'ar';
    context.read<PrayerTimesCubit>().checkInitialData(isArabic: isArabic);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return BlocSelector<PrayerTimesCubit, PrayerTimesState, RequestStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        if (status == RequestStatus.failure) {
          final message = context.select(
            (PrayerTimesCubit cubit) =>
                cubit.state.message ?? widget.localizations.errorMain,
          );
          return _PrayerErrorSliver(
            message: message,
            localizations: widget.localizations,
            isArabic: isArabic,
          );
        }

        return _PrayerSuccessSliver(
          localizations: widget.localizations,
          isArabic: isArabic,
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
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 16.toH),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colorScheme.error,
              fontSize: 16.toSp,
            ),
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
    final theme = context.theme;

    final hijriDate = _getHijriDate(isArabic);
    final String dayName = DateFormat.EEEE(
      isArabic ? 'ar' : 'en',
    ).format(DateTime.now());

    return CurrentPrayerCard(
      hijriDate: hijriDate,
      theme: theme,
      localizations: localizations,
      dayName: dayName,
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
