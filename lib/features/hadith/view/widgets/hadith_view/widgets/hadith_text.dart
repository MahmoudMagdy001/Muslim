import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions.dart';

class HadithText extends StatelessWidget {
  const HadithText({required this.text, required this.isArabic, super.key});

  final String text;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: context.textTheme.titleMedium?.copyWith(
      height: isArabic ? 1.8 : 1.6,
    ),
    textAlign: TextAlign.center,
  );
}
