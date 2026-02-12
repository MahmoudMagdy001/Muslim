import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';

class ZakatErrorView extends StatelessWidget {
  const ZakatErrorView({
    required this.errorMessage,
    required this.onRetry,
    required this.localizations,
    this.onManualEntry,
    super.key,
  });

  final String? errorMessage;
  final VoidCallback onRetry;
  final VoidCallback? onManualEntry;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.toR),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .warning_amber_rounded, // Changed to warning to look less like a "crash"
              size: 64.toSp,
              color: theme
                  .colorScheme
                  .primary, // Changed to primary to look friendlier
            ),
            SizedBox(height: 16.toH),
            Text(
              errorMessage ?? localizations.gold_price_error,
              style: textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.toH),
            if (onManualEntry != null)
              FilledButton.icon(
                onPressed: onManualEntry,
                icon: const Icon(Icons.edit),
                label: Text(localizations.enterGoldPriceManually),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.toW,
                    vertical: 16.toH,
                  ),
                ),
              ),
            if (onManualEntry == null) ...[
              SizedBox(height: 16.toH),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(localizations.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
