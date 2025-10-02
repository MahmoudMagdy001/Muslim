import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/format_helper.dart';
import '../../helper/prayer_consts.dart';
import '../../helper/time_left_format.dart';
import '../../viewmodel/prayer_times_cubit.dart';
import '../../viewmodel/prayer_times_state.dart';

class CurrentPrayerCard extends StatelessWidget {
  const CurrentPrayerCard({
    required this.state,
    required this.timingsMap,
    required this.hijriDate,
    required this.scaffoldContext,
    super.key,
  });

  final PrayerTimesState state;
  final Map<String, String> timingsMap;
  final String hijriDate;
  final BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextPrayerKey = state.nextPrayer;
    final timing = nextPrayerKey != null
        ? timingsMap[nextPrayerKey] ?? '00:00'
        : '00:00';
    final prayerName = nextPrayerKey != null
        ? prayerNamesAr[nextPrayerKey] ?? nextPrayerKey
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اسم الصلاة + زر تحديث
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hijriDate, style: theme.textTheme.bodyMedium),
              IconButton(
                onPressed: () async {
                  HapticFeedback.mediumImpact();
                  await context.read<PrayerTimesCubit>().refreshPrayerTimes();
                  if (scaffoldContext.mounted) {
                    ScaffoldMessenger.of(
                      scaffoldContext,
                    ).removeCurrentSnackBar();
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(content: Text('تم تحديث جدولة الإشعارات')),
                    );
                  }
                },
                icon: const Icon(Icons.refresh_rounded),
                tooltip: 'إعادة جدولة الإشعارات',
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(prayerName, style: theme.textTheme.labelLarge),
              const SizedBox(width: 8),
              Text(
                formatTo12Hour(timing),
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // الوقت المتبقي
          if (state.timeLeft != null) ...[
            const SizedBox(height: 15),
            Text(
              formatTimeLeft(state.timeLeft!),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
