import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../helper/prayer_consts.dart';
import '../../helper/time_left_format.dart';
import '../../viewmodel/prayer_times_cubit.dart';
import '../../viewmodel/prayer_times_state.dart';

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
        final timingsMap = state.localPrayerTimes?.toMap() ?? {};
        final next = state.nextPrayer;
        final previous = state.previousPrayerDateTime;
        final nextDateTime = state.localPrayerTimes != null && next != null
            ? state.localPrayerTimes!.toMap()[next] != null
                  ? state.timeLeft != null
                        ? DateTime.now().add(state.timeLeft!)
                        : DateTime.now()
                  : DateTime.now()
            : DateTime.now();

        // Calculate real progress
        double progress = 0.0;
        if (previous != null && state.timeLeft != null) {
          final totalInterval = nextDateTime.difference(previous).inSeconds;
          if (totalInterval > 0) {
            final elapsed = totalInterval - state.timeLeft!.inSeconds;
            progress = (elapsed / totalInterval).clamp(0.0, 1.0);
          }
        }

        return ColoredBox(
          color: theme.colorScheme.primary,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset('assets/home/vactor.png', fit: BoxFit.fill),
              ),
              Skeletonizer(
                enabled: state.status == PrayerTimesStatus.loading,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // Top Info: Day, Date, City
                      Padding(
                        padding: .symmetric(horizontal: 12.toW),
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  '$dayName - $hijriDate',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4.toH),
                                _CityText(theme),
                              ],
                            ),
                            _RefreshButton(localizations, isArabic),
                          ],
                        ),
                      ),

                      // Center: Circular Progress & Next Prayer
                      Padding(
                        padding: .symmetric(vertical: 10.toH),
                        child: Stack(
                          alignment: .center,
                          children: [
                            // Circular Progress (Custom Arc)
                            CustomPaint(
                              size: Size(200.toW, 180.toH),
                              painter: _PrayerProgressPainter(
                                progress: progress,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            // Inner Details
                            Column(
                              mainAxisSize: .min,
                              children: [
                                _NextPrayerName(theme, isArabic),
                                SizedBox(height: 4.toH),
                                _TimeLeftText(theme, isArabic),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Bottom: All Prayer Times Row
                      Padding(
                        padding: .only(bottom: 12.toH),
                        child: Padding(
                          padding: .symmetric(horizontal: 10.toW),
                          child: Row(
                            children: prayerOrder.map((key) {
                              final isNext = key == next;
                              final timing = timingsMap[key] ?? '';
                              // Icon mapping
                              final String iconPath = switch (key) {
                                'Fajr' => 'assets/home/fagr.png',
                                'Dhuhr' => 'assets/home/dohr.png',
                                'Asr' => 'assets/home/asr.png',
                                'Maghrib' => 'assets/home/maghreb.png',
                                'Isha' => 'assets/home/asiha.png',
                                _ => 'assets/home/fagr.png',
                              };

                              return Expanded(
                                child: _PrayerSmallCard(
                                  label: isArabic
                                      ? prayerNamesAr[key] ?? key
                                      : key,
                                  time: formatTo12Hour(timing, isArabic),
                                  isNext: isNext,
                                  theme: theme,
                                  iconPath: iconPath,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
    margin: .symmetric(horizontal: 2.toW),
    padding: .symmetric(vertical: 6.toH),
    decoration: BoxDecoration(
      color: isNext
          ? theme.colorScheme.secondary.withAlpha((0.2 * 255).toInt())
          : Colors.transparent,
      borderRadius: .circular(12.toR),
      border: .all(
        color: isNext ? theme.colorScheme.secondary : Colors.white24,
        width: 1.toW,
      ),
    ),
    child: Column(
      mainAxisSize: .min,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isNext ? Colors.white : Colors.white70,
            fontWeight: isNext ? .bold : .normal,
          ),
        ),
        SizedBox(height: 4.toH),
        Image.asset(
          iconPath,
          height: 24.toH,
          width: 24.toW,
          color: isNext ? theme.colorScheme.secondary : Colors.white,
        ),
        SizedBox(height: 4.toH),
        Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: .bold,
          ),
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
  const _NextPrayerName(this.theme, this.isArabic);
  final ThemeData theme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PrayerTimesCubit, PrayerTimesState, String?>(
        selector: (state) => state.nextPrayer,
        builder: (context, nextPrayer) => Text(
          isArabic
              ? prayerNamesAr[nextPrayer] ?? '------'
              : nextPrayer ?? '------',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: .bold,
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
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      );
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton(this.localizations, this.isArabic);
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () async {
      HapticFeedback.heavyImpact();
      await context.read<PrayerTimesCubit>().refreshPrayerTimes(
        isArabic: isArabic,
      );
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

    const double startAngle = 0.65 * 3.141592653589793;
    const double totalSweep = 1.7 * 3.141592653589793;

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
