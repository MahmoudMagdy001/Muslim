import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
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
      gradient: LinearGradient(
        colors: AppColors.cardGradient(context),
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
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.theme.primaryColor,
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
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.toH),
                  Text(
                    '${surah.locationArabic} - ${isArabic ? '${convertToArabicNumbers(surah.ayahCount.toString())} آيات' : '${surah.ayahCount.toString()} Verses'}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimary.withAlpha(180),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.onPrimary,
              size: 16.toR,
            ),
          ],
        ),
      ),
    ),
  );
}
