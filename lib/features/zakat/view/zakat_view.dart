import 'package:flutter/material.dart';

import '../../../core/utils/format_helper.dart';
import '../../../core/utils/navigation_helper.dart';
import '../widgets/zakat_calculator.dart';

class ZakatView extends StatelessWidget {
  const ZakatView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('زكاتي')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          children: [
            // 💰 لمن الزكاة
            _buildSectionCard(
              theme,
              icon: Icons.people_alt_rounded,
              title: 'لمن الزكاة؟',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'قال الله تعالى:',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"إِنَّمَا الصَّدَقَاتُ لِلْفُقَرَاءِ وَالْمَسَاكِينِ وَالْعَامِلِينَ عَلَيْهَا وَالْمُؤَلَّفَةِ قُلُوبُهُمْ وَفِي الرِّقَابِ وَالْغَارِمِينَ وَفِي سَبِيلِ اللَّهِ وَابْنِ السَّبِيلِ" (التوبة: ${convertToArabicNumbers('60')})',
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'مصارف الزكاة الثمانية:',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('1')}. الفقراء',
                    'من لا يملك قوت يومه.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('2')}. المساكين',
                    'من يملك بعض حاجته ولكن لا يكفيه.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('3')}. العاملين عليها',
                    'من يجمعون الزكاة ويوزعونها.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('4')}. المؤلفة قلوبهم',
                    'من يُراد تأليف قلوبهم على الإسلام.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('5')}. في الرقاب',
                    'لتحرير الأسرى أو المديونين ظلمًا.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('6')}. الغارمين',
                    'من أثقلهم الدين.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('7')}. في سبيل الله',
                    'لدعم الدعوة والخير.',
                    textTheme: textTheme,
                  ),
                  BuildBeneficiaryItem(
                    '${convertToArabicNumbers('8')}. ابن السبيل',
                    'المسافر المنقطع عن بلده.',
                    textTheme: textTheme,
                  ),
                ],
              ),
            ),

            // ⏰ متى تجب الزكاة
            _buildSectionCard(
              theme,
              icon: Icons.access_time_filled_rounded,
              title: 'متى تجب الزكاة؟',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تجب الزكاة عند توافر هذه الشروط:',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BuildConditionItem(
                    'أن يكون المسلم حرًّا مالكًا للنصاب.',
                    textTheme: textTheme,
                  ),
                  BuildConditionItem(
                    'أن يبلغ المال النصاب (ما يعادل ${convertToArabicNumbers('85')} جرام ذهب تقريبًا).',
                    textTheme: textTheme,
                  ),
                  BuildConditionItem(
                    'أن يمر على المال حول كامل (سنة هجرية).',
                    textTheme: textTheme,
                  ),
                  BuildConditionItem(
                    'أن يكون المال ناميًا أو قابلًا للنماء.',
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
                      'قال النبي ﷺ: "لا زكاة في مال حتى يحول عليه الحول."',
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
              title: 'حاسبة الزكاة',
              content: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'احسب زكاتك بسهولة ودقة',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'أدخل قيمة أموالك وسنحسب لك مقدار الزكاة الواجبة',
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
                            'ابدأ حساب الزكاة',
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
                      'ملاحظة: الزكاة واجبة على المال المدخر الذي بلغ النصاب ومر عليه الحول.',
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              convertToArabicNumbers(text), 
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
