import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../core/utils/format_helper.dart';
import '../helper/prayer_consts.dart';
import '../helper/time_left_format.dart';
import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import 'widgets/prayer_header_shimmer.dart';
import 'widgets/prayer_times_shimmer.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({required this.scaffoldContext, super.key});

  final BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => PrayerTimesCubit()..init(),
      child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        builder: (context, state) {
          if (state.status == PrayerTimesStatus.loading) {
            return _PrayerLoadingSliver(theme: theme);
          } else if (state.status == PrayerTimesStatus.error) {
            return _PrayerErrorSliver(
              message: state.message ?? 'حدث خطأ غير متوقع',
            );
          } else if (state.status == PrayerTimesStatus.success) {
            return _PrayerSuccessSliver(
              state: state,
              theme: theme,
              scaffoldContext: scaffoldContext,
            );
          } else {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
        },
      ),
    );
  }
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

class _PrayerLoadingSliver extends StatelessWidget {
  const _PrayerLoadingSliver({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          PrayerHeaderShimmer(isDark: isDark),
          const SizedBox(height: 16),
          PrayerTimesShimmer(isDark: isDark),
        ],
      ),
    );
  }
}

/// 📌 حالة النجاح لـ CustomScrollView
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
    final timingsMap = state.localPrayerTimes!.toMap();
    final hijriDate = _getHijriDate();

    return SliverToBoxAdapter(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                Text('${state.city}', style: theme.textTheme.bodyMedium),
                _CurrentPrayerCard(
                  state: state,
                  timingsMap: timingsMap,
                  hijriDate: hijriDate,
                  scaffoldContext: scaffoldContext,
                ),
                const Divider(thickness: 0.1),

                _MorePrayerTimes(theme: theme, hijriDate: hijriDate),
              ],
            ),
          ],
        ),
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

/// 📌 بطاقة الصلاة الحالية (التي عليها الدور)
class _CurrentPrayerCard extends StatelessWidget {
  const _CurrentPrayerCard({
    required this.state,
    required this.timingsMap,
    required this.hijriDate,
    required this.scaffoldContext,
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
          // اسم الصلاة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hijriDate, style: theme.textTheme.bodyMedium),
              IconButton(
                onPressed: () async {
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

/// 📌 زر عرض المزيد من مواقيت الصلاة
class _MorePrayerTimes extends StatelessWidget {
  const _MorePrayerTimes({required this.theme, required this.hijriDate});

  final ThemeData theme;
  final String hijriDate;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => showAllPrayerTimes(context),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Row(
          children: [
            Text(
              'اضغط لعرض المزيد من اوقات الصلاه',
              style: theme.textTheme.bodySmall,
            ),
            const Spacer(),
            Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    ),
  );

  void showAllPrayerTimes(BuildContext context) {
    final state = context.read<PrayerTimesCubit>().state;
    final timingsMap = state.localPrayerTimes!.toMap();

    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => _AllPrayerTimesModal(
        timingsMap: timingsMap,
        theme: theme,
        nextPrayer: state.nextPrayer,
        hijriDate: hijriDate,
      ),
    );
  }
}

/// 📌 مودال عرض جميع مواقيت الصلاة
class _AllPrayerTimesModal extends StatelessWidget {
  const _AllPrayerTimesModal({
    required this.timingsMap,
    required this.theme,
    required this.nextPrayer,
    required this.hijriDate,
  });

  final Map<String, String> timingsMap;
  final ThemeData theme;
  final String? nextPrayer;
  final String hijriDate;

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.mosque_rounded, size: 24),
                    const SizedBox(width: 8),
                    Text('مواقيت الصلاة', style: theme.textTheme.headlineSmall),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          hijriDate,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: prayerOrder.map((prayerKey) {
                final timing = timingsMap[prayerKey] ?? '00:00';
                final isNext = nextPrayer == prayerKey;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: isNext
                        ? Border.all(color: theme.colorScheme.primary)
                        : null,
                  ),
                  child: ListTile(
                    title: Text(
                      prayerNamesAr[prayerKey] ?? prayerKey,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: isNext
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isNext ? theme.colorScheme.primary : null,
                      ),
                    ),
                    trailing: Text(
                      formatTo12Hour(timing),
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: isNext
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isNext ? theme.colorScheme.primary : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
