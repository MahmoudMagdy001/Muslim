import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../repository/tafsir_repository.dart';
import '../../../../l10n/app_localizations.dart';

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
  Widget build(BuildContext context) => Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: isArabic
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Text(
                  localizations.selectTafsir,
                  style: TextStyle(
                    fontSize: 24.toSp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        displayableName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.toSp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
