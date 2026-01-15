import 'package:flutter/material.dart';
import '../../model/names_of_allah_model.dart';
import '../../../../core/utils/extensions.dart';

class ShareableNameOfAllahCard extends StatelessWidget {
  const ShareableNameOfAllahCard({
    required this.data,
    required this.isArabic,
    super.key,
  });
  final DataItem data;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Container(
    width: 800,
    height: 600,
    padding: const EdgeInsets.all(40),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.1 * 255).toInt()),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'أسماء الله الحسني',
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Name
        Text(
          data.name,
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // English Translation
        if (!isArabic) ...[
          Text(
            data.nameTranslation,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],

        // Meaning
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Text(
                isArabic ? 'المعنى' : 'Meaning',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isArabic ? data.text : data.textTranslation,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),

        // Footer
        Text(
          isArabic
              ? 'تمت المشاركة من تطبيق مُسَلِّم'
              : 'Shared from Muslim App',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}
