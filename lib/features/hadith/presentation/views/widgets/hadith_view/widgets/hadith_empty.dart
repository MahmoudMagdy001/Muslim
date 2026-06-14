import 'package:flutter/material.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/l10n/app_localizations.dart';

class EmptyHadithsState extends StatelessWidget {
  const EmptyHadithsState({required this.localizations, super.key});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bookmark_border,
          size: 64,
          color: context.colorScheme.onSurface,
        ),
        const SizedBox(height: 16),
        Text(localizations.errorMain, style: context.textTheme.titleMedium),
      ],
    ),
  );
}
