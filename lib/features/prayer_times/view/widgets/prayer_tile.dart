import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../helper/prayer_consts.dart';
import '../../../../core/utils/format_helper.dart';

class PrayerTile extends StatelessWidget {
  const PrayerTile({
    required this.prayerKey,
    required this.timing,
    required this.isNext,
    required this.theme,
    this.timeLeft,
    super.key,
  });

  final String prayerKey;
  final String timing;
  final bool isNext;
  final String? timeLeft;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;
    final prayerName = prayerNamesAr[prayerKey] ?? prayerKey;
    final prayerIcon = prayerIcons[prayerKey] ?? Icons.access_time;
    final prayerColor = prayerColors[prayerKey] ?? Colors.blue;
    final formattedTime = formatTo12Hour(timing);

    return Column(
      children: [
        Icon(
          prayerIcon,
          color: isNext ? AppColors.primary : prayerColor,
          size: 25,
        ),
        const SizedBox(height: 6),
        Text(
          formattedTime,
          style: textTheme.bodyMedium?.copyWith(
            color: isNext ? AppColors.primary : null,
            fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          prayerName,
          style: textTheme.bodySmall?.copyWith(
            color: isNext ? AppColors.primary : null,
            fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
