import 'package:flutter/material.dart';

import 'package:muslim/core/utils/extensions.dart';

class HadithText extends StatelessWidget {
  const HadithText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Text(
      text,
      style: context.textTheme.titleMedium?.copyWith(
        height: isArabic ? 1.8 : 1.6,
      ),
      textAlign: TextAlign.center,
    );
  }
}
