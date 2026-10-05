import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;
import 'package:share_plus/share_plus.dart';

/// Modern Islamic action sheet for verse interactions (Play, Tafsir, Bookmark, Copy, Share)
class VerseOptionsMenu extends StatelessWidget {
  const VerseOptionsMenu({
    required this.surahNumber,
    required this.ayahNumber,
    required this.verseText,
    required this.localizations,
    super.key,
  });

  final int surahNumber;
  final int ayahNumber;
  final String verseText;
  final AppLocalizations localizations;

  static Future<String?> show(
    BuildContext context, {
    required AppLocalizations localizations,
    Offset? position,
    int? surahNumber,
    int? ayahNumber,
    String? verseText,
  }) =>
      showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => VerseOptionsMenu(
          surahNumber: surahNumber ?? 1,
          ayahNumber: ayahNumber ?? 1,
          verseText: verseText ?? '',
          localizations: localizations,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final surahName = isArabic
        ? quran.getSurahNameArabic(surahNumber)
        : quran.getSurahName(surahNumber);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: colors.border, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Header: Surah and Ayah Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.2),
                      width: 0.6,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu_book_rounded, size: 14.r, color: colors.primary),
                      SizedBox(width: 6.w),
                      Text(
                        isArabic
                            ? 'سورة $surahName • آية ${convertToArabicNumbers(ayahNumber.toString())}'
                            : 'Surah $surahName • Verse $ayahNumber',
                        style: context.typography.titleSmall.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close_rounded, color: colors.textSecondary, size: 20.r),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // Verse preview text
            if (verseText.isNotEmpty)
              Container(
                margin: EdgeInsets.only(bottom: 14.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border, width: 0.6),
                ),
                child: Text(
                  verseText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.amiri(
                    fontSize: 16.sp,
                    color: colors.textPrimary,
                    height: 1.8,
                  ),
                ),
              ),

            // Options List
            _OptionTile(
              icon: Icons.play_circle_fill_rounded,
              iconColor: colors.primary,
              title: localizations.playVerseSound,
              onTap: () => Navigator.of(context).pop('play'),
            ),
            _OptionTile(
              icon: Icons.auto_stories_rounded,
              iconColor: colors.secondary,
              title: localizations.tafsirVerse,
              onTap: () => Navigator.of(context).pop('tafseer'),
            ),
            _OptionTile(
              icon: Icons.bookmark_add_rounded,
              iconColor: const Color(0xFFE6A123),
              title: localizations.bookmarkVerse,
              onTap: () => Navigator.of(context).pop('bookmark'),
            ),
            _OptionTile(
              icon: Icons.copy_rounded,
              iconColor: colors.textSecondary,
              title: isArabic ? 'نسخ نص الآية' : 'Copy Verse',
              onTap: () async {
                final ref = isArabic
                    ? '[$verseText] [سورة $surahName: آية $ayahNumber]'
                    : '"$verseText" [Surah $surahName: Verse $ayahNumber]';
                await Clipboard.setData(ClipboardData(text: ref));
                if (context.mounted) {
                  Navigator.of(context).pop('copy');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isArabic ? 'تم نسخ الآية الكريمة بنجاح' : 'Verse copied to clipboard',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            _OptionTile(
              icon: Icons.share_rounded,
              iconColor: colors.primary,
              title: isArabic ? 'مشاركة الآية' : 'Share Verse',
              onTap: () async {
                Navigator.of(context).pop('share');
                final shareContent = isArabic
                    ? '$verseText\n\n[سورة $surahName - آية $ayahNumber]'
                    : '$verseText\n\n[Surah $surahName - Verse $ayahNumber]';
                await SharePlus.instance.share(ShareParams(text: shareContent));
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border, width: 0.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
          child: Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20.r),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  title,
                  style: context.typography.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13.r,
                color: colors.textSecondary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
