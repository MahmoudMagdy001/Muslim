import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../model/azkar_model/azkar_model.dart';

class AzkarItemCard extends StatelessWidget {
  const AzkarItemCard({
    required this.item,
    required this.currentCount,
    required this.totalCount,
    required this.onIncrement,
    required this.onReset,
    super.key,
  });

  final AzkarModel item;
  final ValueNotifier<int> currentCount;
  final int totalCount;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = AppLocalizations.of(context);
    final hasCount = totalCount > 0;

    return ValueListenableBuilder<int>(
      valueListenable: currentCount,
      builder: (context, current, child) {
        final isFinished = current >= totalCount;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsetsDirectional.only(
            start: 8.toW,
            end: 16.toW,
            top: 6.toH,
            bottom: 6.toH,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20.toR),
            border: Border.all(
              color: isFinished && hasCount
                  ? theme.colorScheme.secondary
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.toR),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Text(
                        item.zekr ?? '',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          height: 1.7,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if ((item.reference?.isNotEmpty ?? false) ||
                        (item.description?.isNotEmpty ?? false))
                      SizedBox(height: 16.toH),
                    if (item.reference?.isNotEmpty ?? false)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.toW,
                          vertical: 8.toH,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.toR),
                        ),
                        child: Text(
                          '${localization.revision}: ${item.reference}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary.withAlpha(150),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    if (item.description?.isNotEmpty ?? false) ...[
                      if (item.reference?.isNotEmpty ?? false)
                        SizedBox(height: 12.toH),
                      Text(
                        item.description!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white60,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (hasCount) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.toW, 0, 16.toW, 16.toH),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            current.toString(),
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '/',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            totalCount.toString(),
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: onReset,
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        iconSize: 32.toR,
                      ),
                      SizedBox(
                        height: 42.toH,
                        width: 130.toW,
                        child: ElevatedButton(
                          onPressed: isFinished
                              ? null
                              : () {
                                  HapticFeedback.mediumImpact();
                                  onIncrement();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            foregroundColor: theme.colorScheme.onSecondary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.toR),
                            ),
                          ),
                          child: Text(
                            localization.tasbih,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
