import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/surahs_list/model/search_model.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    required this.result,
    required this.onTap,
    super.key,
  });

  final SearchResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = context.l10n;

    return Container(
      margin: EdgeInsetsDirectional.only(
        start: 6.toW,
        end: 16.toW,
        top: 6.toH,
        bottom: 6.toH,
      ),
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
                        ? convertToArabicNumbers(result.surahNumber.toString())
                        : result.surahNumber.toString(),
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
                    Row(
                      children: [
                        Text(
                          result.surahName,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (result.verseNumber != 0) ...[
                          Text(
                            '- ${l10n.ayahNumberLabel(result.verseNumber)}',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (!result.isSurah) ...[
                      SizedBox(height: 4.toH),
                      Text(
                        result.ayahText,
                        style: GoogleFonts.amiri(
                          color: const Color(0xFFC0C0C0),
                          fontSize: 16.toSp,
                          height: 2.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 4.toH),
                      Text(
                        l10n.surahNumberLabel(result.surahNumber),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFC0C0C0),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.toH),
            ],
          ),
        ),
      ),
    );
  }
}
