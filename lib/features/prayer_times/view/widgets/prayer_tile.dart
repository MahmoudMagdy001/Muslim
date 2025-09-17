import 'package:flutter/material.dart';

import '../../helper/prayer_consts.dart';
import '../../../../core/utils/format_helper.dart';

class PrayerTile extends StatelessWidget {
  const PrayerTile({
    required this.prayerKey,
    required this.timing,
    required this.isNext,
    this.timeLeft,
    super.key,
  });

  final String prayerKey;
  final String timing;
  final bool isNext;
  final String? timeLeft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final prayerName = prayerNamesAr[prayerKey] ?? prayerKey;
    final prayerIcon = prayerIcons[prayerKey] ?? Icons.access_time;
    final prayerColor = prayerColors[prayerKey] ?? Colors.blue;
    final formattedTime = formatTo12Hour(timing);

    return Card(
      color: isNext
          ? theme.brightness == Brightness.dark
                ? theme.colorScheme.primary.withAlpha(102)
                : theme.colorScheme.primary
          : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          prayerIcon,
          color: isNext ? Colors.white : prayerColor,
          size: 30,
        ),
        title: Text(
          prayerName,
          style: textTheme.titleMedium?.copyWith(
            color: isNext ? Colors.white : null,
            fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isNext && timeLeft != null && timeLeft!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isNext ? Colors.white24 : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'المتبقي: $timeLeft',
                  style: textTheme.bodySmall?.copyWith(
                    color: isNext ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              formattedTime,
              style: textTheme.titleMedium?.copyWith(
                color: isNext ? Colors.white : null,
                fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
