import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../zakat/view/zakat_view.dart';

class ZakatCardWidget extends StatelessWidget {
  const ZakatCardWidget({
    required this.theme,
    required this.localizations,
    super.key,
  });

  final ThemeData theme;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
    child: Card(
      child: InkWell(
        onTap: () => navigateWithTransition(context, const ZakatView()),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.zakat,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localizations.zakatDuaa,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.zakatStart,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                cacheHeight: 126,
                cacheWidth: 126,
                'assets/images/zakat.png',
                height: 80,
                width: 80,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
