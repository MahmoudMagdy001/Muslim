import 'package:flutter/material.dart';
import 'extensions.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(context.theme.primaryColor),
          strokeWidth: 3,
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: context.textTheme.titleMedium?.copyWith(
            color: context.theme.primaryColor,
          ),
        ),
      ],
    ),
  );
}
