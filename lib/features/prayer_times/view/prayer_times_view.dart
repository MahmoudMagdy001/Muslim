import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/prayer_consts.dart';
import '../helper/time_left_format.dart';
import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import 'widgets/prayer_header_shimmer.dart';
import 'widgets/prayer_tile.dart';
import 'widgets/prayer_times_shimmer.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => PrayerTimesCubit()..init(),
      child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        builder: (context, state) {
          if (state.status == PrayerTimesStatus.loading) {
            return _PrayerLoadingView(theme: theme);
          } else if (state.status == PrayerTimesStatus.error) {
            return _PrayerErrorView(
              message: state.message ?? 'حدث خطأ غير متوقع',
            );
          } else if (state.status == PrayerTimesStatus.success) {
            return _PrayerSuccessView(state: state, theme: theme);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _PrayerErrorView extends StatelessWidget {
  const _PrayerErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
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
  );
}

class _PrayerLoadingView extends StatelessWidget {
  const _PrayerLoadingView({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        PrayerHeaderShimmer(isDark: isDark),
        const SizedBox(height: 16),
        PrayerTimesShimmer(isDark: isDark),
      ],
    );
  }
}

/// 📌 حالة النجاح
class _PrayerSuccessView extends StatelessWidget {
  const _PrayerSuccessView({required this.state, required this.theme});
  final PrayerTimesState state;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final timingsMap = state.localPrayerTimes!.toMap();

    return Card(
      child: Column(
        children: [
          _NextPrayerHeader(state: state),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prayerOrder.map((prayerKey) {
                final timing = timingsMap[prayerKey] ?? '00:00';
                final timeLeft =
                    state.nextPrayer == prayerKey && state.timeLeft != null
                    ? formatTimeLeft(state.timeLeft!)
                    : null;

                return PrayerTile(
                  prayerKey: prayerKey,
                  timing: timing,
                  isNext: state.nextPrayer == prayerKey,
                  timeLeft: timeLeft,
                  theme: theme,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// 📌 الهيدر (الصلاة القادمة + الوقت المتبقي)
class _NextPrayerHeader extends StatelessWidget {
  const _NextPrayerHeader({required this.state});
  final PrayerTimesState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconBox(theme, Icons.mosque_outlined),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الصلاة القادمة', style: theme.textTheme.titleMedium),
                  Text(
                    prayerNamesAr[state.nextPrayer] ?? state.nextPrayer!,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                tooltip: 'إعادة جدولة الإشعارات',
                onPressed: () =>
                    context.read<PrayerTimesCubit>().refreshPrayerTimes(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          if (state.timeLeft != null) ...[
            const SizedBox(height: 10),
            _buildTimeLeftBox(theme, formatTimeLeft(state.timeLeft!)),
          ],
        ],
      ),
    );
  }

  Widget _buildIconBox(ThemeData theme, IconData icon) => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: theme.brightness == Brightness.dark
          ? theme.colorScheme.primary.withAlpha(102)
          : theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(
      icon,
      size: 20,
      color: theme.brightness == Brightness.dark
          ? Colors.white70
          : Colors.white,
    ),
  );

  Widget _buildTimeLeftBox(ThemeData theme, String timeText) => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: theme.brightness == Brightness.dark
          ? theme.colorScheme.primary.withAlpha(102)
          : theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer_outlined, size: 20, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          timeText,
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}
