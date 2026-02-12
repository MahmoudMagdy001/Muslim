import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../model/hizb_model.dart';

class HizbListTile extends StatelessWidget {
  const HizbListTile({
    required this.hizb,
    required this.isArabic,
    required this.onTap,
    super.key,
  });

  final HizbModel hizb;
  final bool isArabic;
  final VoidCallback onTap;

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
                      ? convertToArabicNumbers(hizb.number.toString())
                      : hizb.number.toString(),
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
                    isArabic ? 'الحزب ${hizb.number}' : 'Hizb ${hizb.number}',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.toH),
                  Text(
                    '${hizb.startSurahName} - ${isArabic ? convertToArabicNumbers(hizb.startAyah.toString()) : hizb.startAyah.toString()}',
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
              isArabic ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: context.colorScheme.onPrimary,
              size: 16.toR,
            ),
          ],
        ),
      ),
    ),
  );
}
