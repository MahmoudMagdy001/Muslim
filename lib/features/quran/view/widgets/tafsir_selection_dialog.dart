import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/base_app_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../repository/tafsir_repository.dart';

class TafsirSelectionDialog extends StatelessWidget {
  const TafsirSelectionDialog({
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final AppLocalizations localizations;
  final bool isArabic;

  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    required AppLocalizations localizations,
    required bool isArabic,
  }) => showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) =>
        TafsirSelectionDialog(localizations: localizations, isArabic: isArabic),
  );

  @override
  Widget build(BuildContext context) => BaseAppDialog(
    title: localizations.selectTafsir,
    content: SizedBox(
      width: context.screenWidth * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          const SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: TafsirRepository.tafasirList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              final tafsir = TafsirRepository.tafasirList[index];
              final tafsirName = isArabic
                  ? tafsir['name_ar']
                  : tafsir['name_en'];

              // Extract just the name if it contains "تفسير"
              String displayableName = tafsirName;
              if (displayableName.startsWith('تفسير ')) {
                displayableName = displayableName.substring(6);
              }

              return InkWell(
                onTap: () => Navigator.pop(context, tafsir),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      displayableName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.colorScheme.onPrimary,
                        fontSize: 18.toSp,
                        fontWeight: FontWeight.w500,
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
  );
}
