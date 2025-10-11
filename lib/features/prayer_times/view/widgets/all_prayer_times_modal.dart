import 'package:flutter/material.dart';

import '../../../../core/utils/format_helper.dart';
import '../../helper/prayer_consts.dart';

class AllPrayerTimesModal extends StatelessWidget {
  const AllPrayerTimesModal({
    required this.timingsMap,
    required this.theme,
    required this.nextPrayer,
    required this.hijriDate,
    super.key,
  });

  final Map<String, String> timingsMap;
  final ThemeData theme;
  final String? nextPrayer;
  final String hijriDate;

  @override
  Widget build(BuildContext context) => Container(
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
  );
}
