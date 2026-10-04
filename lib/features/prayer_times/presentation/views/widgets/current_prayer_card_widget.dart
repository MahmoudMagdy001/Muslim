import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_bloc.dart';
import 'package:muslim/features/prayer_times/presentation/helper/prayer_consts.dart';
import 'package:muslim/features/prayer_times/presentation/helper/time_left_format.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

    // ponytail: restrict rebuilds of outer widget to only status and prayer-time changes (avoid 1s ticks)
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.localPrayerTimes != current.localPrayerTimes ||
          previous.nextPrayer != current.nextPrayer ||
          previous.previousPrayerDateTime != current.previousPrayerDateTime,
      builder: (context, state) {
        final localPrayerTimes = state.localPrayerTimes;
        final next = state.nextPrayer;

        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24.toR),
          ),
          child: ColoredBox(
            color: theme.colorScheme.primary,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/home/vactor.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Skeletonizer(
                  enabled: state.status == RequestStatus.loading,
                  child: Column(
                    children: [
                      SizedBox(height: 8.toH),
                        // Top Info: Day, Date, City
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.toW),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$dayName - $hijriDate',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.toH),
                                  _CityText(theme),
                                ],
                              ),
                              _RefreshButton(
                                localizations: localizations,
                              ),
                            ],
                          ),
                        ),

                        // Center: Circular Progress & Next Prayer
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.toH),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // isolates countdown tick rebuilds to just the progress arc
                              _PrayerProgressArc(theme: theme),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _NextPrayerName(theme: theme),
                                  SizedBox(height: 4.toH),
                                  _TimeLeftText(theme: theme),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Bottom: All Prayer Times Row
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.toH),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.toW),
                            child: Row(
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

                                    return Expanded(
                                      child: _PrayerSmallCard(
                                        label: prayer.displayName(
                                          isArabic: isArabic,
                                        ),
                                        time: formatTo12Hour(
                                          timing,
                                          isArabic: isArabic,
                                        ),
                                        isNext: isNext,
                                        theme: theme,
                                        iconPath: visual.assetPath,
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}

class _PrayerSmallCard extends StatelessWidget {
  const _PrayerSmallCard({
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
    margin: EdgeInsets.symmetric(horizontal: 3.toW),
    padding: EdgeInsets.symmetric(vertical: 8.toH, horizontal: 2.toW),
    decoration: BoxDecoration(
      color: isNext
          ? theme.colorScheme.secondary.withValues(alpha: 0.22)
          : Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(14.toR),
      border: Border.all(
        color: isNext
            ? theme.colorScheme.secondary
            : Colors.white.withValues(alpha: 0.15),
        width: isNext ? 1.5 : 1,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isNext ? theme.colorScheme.secondary : Colors.white.withValues(alpha: 0.85),
            fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
            fontSize: 11.toSp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 6.toH),
        Image.asset(
          iconPath,
          height: 22.toH,
          width: 22.toW,
          cacheWidth: 72,
          cacheHeight: 72,
          color: isNext ? theme.colorScheme.secondary : Colors.white,
        ),
        SizedBox(height: 6.toH),
        Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.toSp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
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
  const _NextPrayerName({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, PrayerType?>(
        selector: (state) => state.nextPrayer,
        builder: (context, nextPrayer) => Text(
          nextPrayer?.localizedName(context.l10n) ?? '------',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

class _TimeLeftText extends StatelessWidget {
  const _TimeLeftText({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return BlocSelector<PrayerTimesCubit, PrayerTimesState, Duration?>(
      selector: (state) => state.timeLeft,
      builder: (context, timeLeft) => Text(
        formatTimeLeft(
          timeLeft ?? const Duration(hours: 1, minutes: 23, seconds: 45),
          isArabic: isArabic,
        ),
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({required this.localizations});
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () async {
      await HapticFeedback.heavyImpact();
      if (context.mounted) {
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';
        await context.read<PrayerTimesCubit>().refreshPrayerTimes(
          isArabic: isArabic,
        );
      }
    },
    icon: const Icon(Icons.refresh_rounded, color: Colors.white),
    tooltip: localizations.updatePrayerTimes,
  );
}

class _PrayerProgressPainter extends CustomPainter {
  _PrayerProgressPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 19) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    const startAngle = 0.65 * 3.141592653589793;
    const totalSweep = 1.7 * 3.141592653589793;

    final backgroundPaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 19
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 19
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawArc(rect, startAngle, totalSweep, false, backgroundPaint)
      ..drawArc(rect, startAngle, totalSweep * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _PrayerProgressPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

// ponytail: isolate high-frequency rebuilds of the countdown timer progress arc
class _PrayerProgressArc extends StatelessWidget {
  const _PrayerProgressArc({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        buildWhen: (previous, current) =>
            previous.timeLeft != current.timeLeft ||
            previous.previousPrayerDateTime != current.previousPrayerDateTime ||
            previous.localPrayerTimes != current.localPrayerTimes ||
            previous.nextPrayer != current.nextPrayer,
        builder: (context, state) {
          final localPrayerTimes = state.localPrayerTimes;
          final next = state.nextPrayer;
          final previous = state.previousPrayerDateTime;
          final nextDateTime = localPrayerTimes != null && next != null
              ? localPrayerTimes.timeForPrayer(next) != '--:--'
                  ? state.timeLeft != null
                      ? DateTime.now().add(state.timeLeft!)
                      : DateTime.now()
                  : DateTime.now()
              : DateTime.now();

          var progress = 0.0;
          if (previous != null && state.timeLeft != null) {
            final totalInterval = nextDateTime.difference(previous).inSeconds;
            if (totalInterval > 0) {
              final elapsed = totalInterval - state.timeLeft!.inSeconds;
              progress = (elapsed / totalInterval).clamp(0.0, 1.0);
            }
          }

          return CustomPaint(
            size: Size(200.toW, 180.toH),
            painter: _PrayerProgressPainter(
              progress: progress,
              color: theme.colorScheme.secondary,
            ),
          );
        },
      );
}
