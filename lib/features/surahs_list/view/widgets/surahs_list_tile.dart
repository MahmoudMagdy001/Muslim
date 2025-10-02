import 'package:flutter/material.dart';

import '../../../../core/utils/format_helper.dart';
import '../../model/surahs_list_model.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({required this.surah, required this.onTap, super.key});

  final SurahsListModel surah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15.0, 12.0, 16.0),
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
                  convertToArabicNumbers(surah.number.toString()),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Surah details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    surah.nameArabic,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${surah.locationArabic} - ${convertToArabicNumbers(surah.ayahCount.toString())} آيات',
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
