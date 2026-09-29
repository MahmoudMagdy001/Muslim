import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/features/quran/repository/tafsir_repository.dart';
import 'package:muslim/l10n/app_localizations.dart';

class TafsirSelectionDialog extends StatelessWidget {
  const TafsirSelectionDialog({
    required this.localizations,
    super.key,
  });

  final AppLocalizations localizations;

  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    required AppLocalizations localizations,
  }) =>
      showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => TafsirSelectionDialog(localizations: localizations),
      );

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colors = context.colors;

    return BaseAppDialog(
      icon: Icons.menu_book_rounded,
      iconColor: colors.secondary,
      title: localizations.selectTafsir,
      content: SizedBox(
        width: context.screenWidth * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: TafsirRepository.tafasirList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 2.3,
              ),
              itemBuilder: (context, index) {
                final tafsir = TafsirRepository.tafasirList[index];
                final tafsirName = (isArabic
                    ? tafsir['name_ar']
                    : tafsir['name_en']) as String;

                var displayableName = tafsirName;
                if (displayableName.startsWith('تفسير ')) {
                  displayableName = displayableName.substring(6);
                }

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pop(context, tafsir),
                    borderRadius: BorderRadius.circular(12.r),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: colors.border,
                          width: 0.8,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayableName,
                          textAlign: TextAlign.center,
                          style: context.typography.titleSmall.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: colors.textSecondary,
          ),
          child: Text(localizations.cancel),
        ),
      ],
    );
  }
}
