import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
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
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.toH),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: AppColors.cardGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15.toR),
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.toR),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/quran/marker.png',
                  width: 40.toW,
                  height: 40.toH,
                ),
                Text(
                  isArabic
                      ? convertToArabicNumbers(surah.number.toString())
                      : surah.number.toString(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.toW),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.surahName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.toH),
                  Text(
                    '${surah.locationArabic} - ${isArabic ? '${convertToArabicNumbers(surah.ayahCount.toString())} آيات' : '${surah.ayahCount.toString()} Verses'}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFC0C0C0),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.toR),
          ],
        ),
      ),
    ),
  );
}
