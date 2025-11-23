import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.message,
    required this.localizations,
    required this.onRetry,
    super.key,
  });

  final String message;
  final AppLocalizations localizations;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 64,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onRetry, child: Text(localizations.retry)),
      ],
    ),
  );
}
