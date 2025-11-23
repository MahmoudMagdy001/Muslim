import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

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
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: 16),
        Text(
          localizations.errorMain,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}
