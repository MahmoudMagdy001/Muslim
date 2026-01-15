import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';

class LastPlayedCard extends StatelessWidget {
  const LastPlayedCard({
    required this.lastPlayed,
    required this.navigateToSurah,
    super.key,
  });

  final Map<String, dynamic> lastPlayed;
  final Future<void> Function({required int surah, required int ayah})
  navigateToSurah;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 6.toW),
    height: 125.toH,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.toR),
      gradient: LinearGradient(
        colors: AppColors.cardGradient(context),
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
          padding: EdgeInsets.symmetric(horizontal: 20.toW, vertical: 15.toH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'آخر قراءة',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${quran.getSurahNameArabic(lastPlayed['surah'])} - آية ${convertToArabicNumbers(lastPlayed['verse'].toString())}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
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
                  backgroundColor: context.theme.colorScheme.secondary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.toR),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.toW,
                    vertical: 8.toH,
                  ),
                ),
                child: Text(
                  'تابع القراءة',
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
