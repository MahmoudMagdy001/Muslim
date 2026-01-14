import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/prayer_type.dart';
import '../../cubit/prayer_times_cubit.dart';
import '../../cubit/prayer_times_state.dart';
import '../../helper/prayer_consts.dart';
import '../../helper/time_left_format.dart';

class CurrentPrayerCard extends StatelessWidget {
  const CurrentPrayerCard({
    required this.hijriDate,
    required this.theme,
    required this.localizations,
    required this.dayName,
    super.key,
  });

  final String hijriDate;
  final ThemeData theme;
  final AppLocalizations localizations;
  final String dayName;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        final localPrayerTimes = state.localPrayerTimes;
        final next = state.nextPrayer;

        return Skeletonizer(
          enabled: state.status == RequestStatus.loading,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Teal Header Container
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                      ),
                      child: Stack(
                        children: [
                          // Mosque Silhouette Background
                          Positioned(
                            child: Skeleton.ignore(
                              child: Image.asset(
                                'assets/home/vactor.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.toW),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Info: Date
                                SizedBox(height: 4.toH),
                                Row(
                                  children: [
                                    const Skeleton.ignore(
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(width: 8.toW),
                                    Text(
                                      hijriDate,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.toH),
                                // Next Prayer row
                                Row(
                                  children: [
                                    Text(
                                      '${isArabic ? 'الصلاة القادمة' : 'Next Prayer'}: ',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.white70),
                                    ),
                                    _NextPrayerName(theme, isArabic),
                                  ],
                                ),

                                _CityText(theme),

                                // Digital Clock
                                Center(child: _TimeLeftText(theme, isArabic)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Overlapping Prayer Strip
                    Positioned(
                      bottom: -30.toH,
                      left: 12.toW,
                      right: 12.toW,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.toH,
                          horizontal: 8.toW,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.toR),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: PrayerType.values
                              .where(
                                (prayer) => prayerVisuals.containsKey(prayer),
                              )
                              .map((prayer) {
                                final isNext = prayer == next;
                                final timing =
                                    localPrayerTimes?.timeForPrayer(prayer) ??
                                    '';
                                final visual = prayerVisuals[prayer]!;

                                return _PrayerMiniCard(
                                  label: prayer.displayName(isArabic: isArabic),
                                  time: formatTo12Hour(timing, isArabic),
                                  isNext: isNext,
                                  theme: theme,
                                  iconPath: visual.assetPath,
                                );
                              })
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer to account for overlapping Container
              SizedBox(height: 45.toH),
            ],
          ),
        );
      },
    );
  }
}

class _PrayerMiniCard extends StatelessWidget {
  const _PrayerMiniCard({
    required this.label,
    required this.time,
    required this.isNext,
    required this.theme,
    required this.iconPath,
  });

  final String label;
  final String time;
  final bool isNext;
  final ThemeData theme;
  final String iconPath;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.toW, vertical: 8.toH),
    decoration: BoxDecoration(
      color: isNext ? theme.colorScheme.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(8.toR),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Skeleton.ignore(
          child: Icon(
            _getPrayerIcon(label),
            size: 24.toR,
            color: isNext
                ? Colors.white
                : theme.colorScheme.primary.withAlpha(200),
          ),
        ),
        SizedBox(height: 4.toH),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isNext ? Colors.white : Colors.black54,
            fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        SizedBox(height: 2.toH),
        Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isNext ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );

  IconData _getPrayerIcon(String label) {
    if (label.contains('فجر') || label.contains('Fajr')) {
      return Icons.nights_stay_outlined;
    }
    if (label.contains('شروق') || label.contains('Sunrise')) {
      return Icons.wb_sunny_outlined;
    }
    if (label.contains('ظهر') || label.contains('Dhuhr')) {
      return Icons.wb_sunny;
    }
    if (label.contains('عصر') || label.contains('Asr')) {
      return Icons.wb_cloudy_outlined;
    }
    if (label.contains('مغرب') || label.contains('Maghrib')) {
      return Icons.wb_twilight;
    }
    return Icons.nightlight_round;
  }
}

class _CityText extends StatelessWidget {
  const _CityText(this.theme);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, String?>(
        selector: (state) => state.city,
        builder: (context, city) => Text(
          city ?? '--------------',
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      );
}

class _NextPrayerName extends StatelessWidget {
  const _NextPrayerName(this.theme, this.isArabic);
  final ThemeData theme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, PrayerType?>(
        selector: (state) => state.nextPrayer,
        builder: (context, nextPrayer) => Text(
          nextPrayer?.displayName(isArabic: isArabic) ?? '------',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

class _TimeLeftText extends StatelessWidget {
  const _TimeLeftText(this.theme, this.isArabic);
  final ThemeData theme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, Duration?>(
        selector: (state) => state.timeLeft,
        builder: (context, timeLeft) => Text(
          formatTimeLeft(
            timeLeft ?? const Duration(hours: 1, minutes: 23, seconds: 45),
            isArabic,
          ),
          style: theme.textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 48.toSp,
          ),
        ),
      );
}
