import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_state.dart';
import 'package:muslim/features/prayer_times/presentation/views/widgets/current_prayer_card_widget.dart';

class PrayerTimesView extends StatefulWidget {
  const PrayerTimesView({
    super.key,
  });

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';
        unawaited(context.read<PrayerTimesCubit>().checkInitialData(isArabic: isArabic));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.message != curr.message ||
          prev.localPrayerTimes != curr.localPrayerTimes,
      builder: (context, state) {
        if (state.status == RequestStatus.failure) {
          return _PrayerErrorCard(
            message: state.message ?? context.l10n.errorMain,
            isArabic: isArabic,
          );
        }

        return _PrayerSuccessCard(
          isArabic: isArabic,
        );
      },
    );
  }
}

class _PrayerErrorCard extends StatelessWidget {
  const _PrayerErrorCard({
    required this.message,
    required this.isArabic,
  });

  final String message;
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
            style: context.typography.titleMedium.copyWith(
              color: context.colors.error,
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
            label: Text(context.l10n.retry),
          ),
        ],
      ),
    ),
  );
}

class _PrayerSuccessCard extends StatelessWidget {
  const _PrayerSuccessCard({
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final hijriDate = _getHijriDate(isArabic);
    final dayName = DateFormat.EEEE(
      isArabic ? 'ar' : 'en',
    ).format(DateTime.now());

    return CurrentPrayerCard(
      hijriDate: hijriDate,
      theme: theme,
      localizations: context.l10n,
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
