import 'package:flutter/material.dart';

class HadithText extends StatelessWidget {
  const HadithText({required this.text, required this.isArabic, super.key});

  final String text;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(height: isArabic ? 2.1 : 1.6),
    textAlign: isArabic ? TextAlign.right : TextAlign.left,
  );
}
