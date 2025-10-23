import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    required this.label,
    required this.image,
    required this.onTap,
    required this.theme,
    super.key,
  });

  final String label;
  final String image;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Image.asset(
                cacheHeight: 126,
                cacheWidth: 126,
                image,
                height: theme.textTheme.bodyMedium!.fontSize! * 3,
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
