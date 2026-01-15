import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../model/search_model.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    required this.result,
    required this.onTap,
    required this.isArabic,
    super.key,
  });

  final SearchResult result;
  final VoidCallback onTap;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.toH, horizontal: 16.toW),
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
                  Text(
                    result.surahName,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
                    SizedBox(height: 4.toH),
                    Text(
                      isArabic
                          ? 'الآية ${convertToArabicNumbers(result.verseNumber.toString())}'
                          : 'Verse ${result.verseNumber}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: 4.toH),
                    Text(
                      isArabic ? 'سورة' : 'Surah',
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
