import 'package:flutter/material.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';

class ZakatErrorView extends StatelessWidget {
  const ZakatErrorView({
    required this.errorMessage,
    required this.onRetry,
    required this.localizations,
    super.key,
  });

  final String? errorMessage;
  final VoidCallback onRetry;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return InternetStateManager(
      noInternetScreen: const NoInternetScreen(),
      onRestoreInternetConnection: onRetry,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.toR),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.toSp,
                color: theme.colorScheme.error,
              ),
              SizedBox(height: 16.toH),
              Text(
                errorMessage ?? localizations.gold_price_error,
                style: textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.toH),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(localizations.retry),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.toW,
                    vertical: 12.toH,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
