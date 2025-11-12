import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../core/utils/format_helper.dart';

class LastPlayedCard extends StatelessWidget {
  const LastPlayedCard({
    required this.lastPlayed,
    required this.theme,
    required this.navigateToSurah,
    super.key,
  });

  final Map<String, dynamic> lastPlayed;
  final ThemeData theme;
  final Future<void> Function({required int surah, required int ayah})
  navigateToSurah;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => navigateToSurah(
        surah: lastPlayed['surah'],
        ayah: lastPlayed['verse'],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'آخر سوره استمعت لها: سورة ${quran.getSurahNameArabic(lastPlayed['surah'])}',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'سوره رقم: ${convertToArabicNumbers(lastPlayed['surah'].toString())}',
                  ),
                  const SizedBox(width: 8),
                  const Text('-'),
                  const SizedBox(width: 8),
                  Text(
                    'آية رقم: ${convertToArabicNumbers(lastPlayed['verse'].toString())}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
