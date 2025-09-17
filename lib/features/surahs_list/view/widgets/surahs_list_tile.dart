import 'package:flutter/material.dart';

import '../../model/surahs_list_model.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({required this.surah, required this.onTap, super.key});

  final SurahsListModel surah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    surah.number.toString(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      surah.nameArabic,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${surah.locationArabic} - ${surah.ayahCount} آيات',
                      style: theme.textTheme.bodySmall?.copyWith(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                color: theme.iconTheme.color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
