import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/core/widgets/custom_modal_sheet.dart';
import 'package:muslim/features/quran/presentation/views/widgets/create_share_tafsir.dart';
import 'package:muslim/l10n/app_localizations.dart';

class TafsirBottomSheet extends StatelessWidget {
  const TafsirBottomSheet({
    required this.surahName,
    required this.ayahNumber,
    required this.ayahText,
    required this.tafsirTitle,
    required this.tafsirText,
    required this.localizations,
    super.key,
  });

  final String surahName;
  final int ayahNumber;
  final String ayahText;
  final String tafsirTitle;
  final String tafsirText;
  final AppLocalizations localizations;

  static Future<void> show(
    BuildContext context, {
    required String surahName,
    required int ayahNumber,
    required String ayahText,
    required String tafsirTitle,
    required String tafsirText,
    required AppLocalizations localizations,
  }) =>
      showCustomModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        minChildSize: 0.3,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        builder: (context) => TafsirBottomSheet(
          surahName: surahName,
          ayahNumber: ayahNumber,
          ayahText: ayahText,
          tafsirTitle: tafsirTitle,
          tafsirText: tafsirText,
          localizations: localizations,
        ),
      );

  Future<void> _onSharePressed(BuildContext context) async {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    unawaited(
      BaseAppDialog.showLoading(
        context,
        message: isArabic ? 'جاري إنشاء الصور...' : 'Creating images...',
      ),
    );
    try {
      if (!context.mounted) return;
      final result = await TafsirShareService().createAndShare(
        surahName: surahName,
        ayahNumber: ayahNumber,
        ayahText: ayahText,
        tafsirTitle: tafsirTitle,
        tafsirText: tafsirText,
        context: context,
      );
      if (context.mounted) Navigator.pop(context);
      if (!result.success && context.mounted) {
        await BaseAppDialog.show<void>(
          context,
          title: isArabic ? '⚠️ خطأ' : '⚠️ Error',
          contentText: result.errorMessage ?? '',
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(isArabic ? 'موافق' : 'OK'),
            ),
          ],
        );
      }
    } on Object catch (e) {
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      if (context.mounted) {
        await BaseAppDialog.show<void>(
          context,
          title: isArabic ? '⚠️ خطأ' : '⚠️ Error',
          contentText: e.toString().replaceAll('Exception: ', ''),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(isArabic ? 'موافق' : 'OK'),
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$tafsirTitle — '
            '${isArabic ? 'للآية رقم ${convertToArabicNumbers(ayahNumber.toString())} - سورة $surahName' : 'Verse $ayahNumber - Surah $surahName'}',
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.toH),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              ayahText,
              textAlign: TextAlign.center,
              style: GoogleFonts.amiri().copyWith(
                fontSize: 22.toSp,
                height: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.toH),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              tafsirText,
              textAlign: TextAlign.justify,
              style: context.textTheme.titleMedium?.copyWith(height: 1.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: SizedBox(
              height: 52.toH,
              child: ElevatedButton(
                onPressed: () => _onSharePressed(context),
                child: Text(localizations.shareTafsir),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
