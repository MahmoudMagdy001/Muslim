import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../core/theme/app_colors.dart';
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
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: AppColors.cardGradient,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Stack(
      children: [
        // Illustration background
        Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          child: Image.asset('assets/quran/image.png', fit: BoxFit.contain),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'آخر قراءة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${quran.getSurahNameArabic(lastPlayed['surah'])} - آية ${convertToArabicNumbers(lastPlayed['verse'].toString())}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => navigateToSurah(
                  surah: lastPlayed['surah'],
                  ayah: lastPlayed['verse'],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'تابع القراءة',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
