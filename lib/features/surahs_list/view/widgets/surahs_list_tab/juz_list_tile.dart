import 'package:flutter/material.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/surahs_list/model/juz_model.dart';

class JuzListTile extends StatelessWidget {
  const JuzListTile({
    required this.juz,
    required this.onTap,
    super.key,
  });

  final JuzModel juz;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;
    final startSurahName = juz.getStartSurahName(isArabic: isArabic);
    final endSurahName = juz.getEndSurahName(isArabic: isArabic);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.toH),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.cardGradient,
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
                        ? convertToArabicNumbers(juz.number.toString())
                        : juz.number.toString(),
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
                      l10n.juzNumberLabel(juz.number),
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.toH),
                    Text(
                      isArabic
                          ? '$startSurahName: ${convertToArabicNumbers(juz.startAyah.toString())} - $endSurahName: ${convertToArabicNumbers(juz.endAyah.toString())}'
                          : '$startSurahName: ${juz.startAyah} - $endSurahName: ${juz.endAyah}',
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
}
