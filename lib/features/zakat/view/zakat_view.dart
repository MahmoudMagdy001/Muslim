import 'package:flutter/material.dart';

import '../../../core/utils/format_helper.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/zakat_calculator.dart';

class ZakatView extends StatelessWidget {
  const ZakatView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final localizations = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(localizations.my_zakat)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          children: [
            // 💰 لمن الزكاة
            _buildSectionCard(
              theme,
              icon: Icons.people_alt_rounded,
              title: localizations.zakat_for_whom,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.quran_verse,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${localizations.quran_text} (${isArabic ? 'التوبة' : 'At-Tawbah'}: ${isArabic ? convertToArabicNumbers('60') : '60'})',
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    localizations.beneficiaries,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('1') : '1'}. ${localizations.poor}',
                    localizations.poor_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('2') : '2'}. ${localizations.needy}',
                    localizations.needy_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('3') : '3'}. ${localizations.collectors}',
                    localizations.collectors_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('4') : '4'}. ${localizations.new_muslims}',
                    localizations.new_muslims_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('5') : '5'}. ${localizations.slaves}',
                    localizations.slaves_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('6') : '6'}. ${localizations.debtors}',
                    localizations.debtors_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('7') : '7'}. ${localizations.cause_of_allah}',
                    localizations.cause_of_allah_desc,
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${isArabic ? convertToArabicNumbers('8') : '8'}. ${localizations.traveler}',
                    localizations.traveler_desc,
                    textTheme: textTheme,
                  ),
                ],
              ),
            ),

            // ⏰ متى تجب الزكاة
            _buildSectionCard(
              theme,
              icon: Icons.access_time_filled_rounded,
              title: localizations.when_zakat_due,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.conditions,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BuildConditionItem(
                    localizations.condition_1,
                    textTheme: textTheme,
                  ),
                  BuildConditionItem(
                    localizations.condition_2,
                    textTheme: textTheme,
                  ),
                  BuildConditionItem(
                    localizations.condition_3,
                    textTheme: textTheme,
                  ),
                  BuildConditionItem(
                    localizations.condition_4,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      localizations.hadith,
                      style: textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // 🧮 حاسبة الزكاة
            _buildSectionCard(
              theme,
              icon: Icons.calculate_rounded,
              title: localizations.zakat_calculator,
              content: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        localizations.calculate_easily,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizations.enter_amount,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => navigateWithTransition(
                        type: TransitionType.fade,
                        context,
                        const ZakatCalculator(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calculate_rounded, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            localizations.start_calculation,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      localizations.note,
                      style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    final textTheme = theme.textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }
}

// Widgets مساعدة
class BuildBeneficiaryItem extends StatelessWidget {
  const BuildBeneficiaryItem(
    this.title,
    this.description, {
    required this.textTheme,
    super.key,
  });

  final String title;
  final String description;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class BuildConditionItem extends StatelessWidget {
  const BuildConditionItem(this.text, {required this.textTheme, super.key});

  final String text;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isArabic ? convertToArabicNumbers(text) : text,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
