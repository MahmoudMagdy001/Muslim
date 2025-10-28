import 'package:flutter/material.dart';

import '../../../../core/utils/format_helper.dart';
import '../../model/surahs_list_model.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({
    required this.surah,
    required this.onTap,
    required this.isArabic,
    super.key,
  });

  final SurahsListModel surah;
  final VoidCallback onTap;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 15,
          bottom: 15,
          start: 6,
          end: 18,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isArabic
                      ? convertToArabicNumbers(surah.number.toString())
                      : surah.number.toString(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Surah details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    surah.surahName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${surah.locationArabic} - ${isArabic ? '${convertToArabicNumbers(surah.ayahCount.toString())} آيات' : '${surah.ayahCount.toString()} Verses'}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              color: colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
