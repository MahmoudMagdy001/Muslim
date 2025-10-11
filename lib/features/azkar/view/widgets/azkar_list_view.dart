import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/ext/extention.dart';
import '../../model/azkar_model/azkar_model.dart';

class AzkarListView extends StatefulWidget {
  const AzkarListView({
    required this.category,
    required this.azkarList,
    super.key,
  });

  final String category;
  final List<AzkarModel> azkarList;

  @override
  State<AzkarListView> createState() => _AzkarListViewState();
}

class _AzkarListViewState extends State<AzkarListView> {
  late List<int> currentCounts;
  late List<int> totalCounts;

  @override
  void initState() {
    super.initState();
    // تهيئة العدادات
    currentCounts = List.generate(widget.azkarList.length, (index) => 0);
    totalCounts = widget.azkarList.map((e) => e.count ?? 1).toList();
  }

  void _incrementCounter(int index) {
    if (currentCounts[index] < totalCounts[index]) {
      setState(() {
        currentCounts[index]++;
      });
    }
  }

  void _resetCounter(int index) {
    setState(() {
      currentCounts[index] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final local = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: ListView.builder(
        itemCount: widget.azkarList.length,
        itemBuilder: (context, index) {
          final item = widget.azkarList[index];
          final current = currentCounts[index];
          final total = totalCounts[index];
          final isFinished = current >= total;
          final progress = total > 0 ? current / total : 0.0;
          final hasCount = total > 0;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isFinished && hasCount
                      ? colorScheme.primary
                      : theme.cardColor,
                  width: isFinished && hasCount ? 2.0 : 1.0,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.zekr ?? '',
                          style: theme.textTheme.titleMedium?.copyWith(
                            height: local == 'ar' ? 2.1 : 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isFinished && hasCount
                                ? colorScheme.onSurface
                                : colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // المرجع
                        if (item.reference?.isNotEmpty ?? false)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bookmark_border,
                                  size: 16,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${context.localization.revision}: ${item.reference}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),

                        // الوصف / الفوائد
                        if (item.description?.isNotEmpty ?? false) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest
                                  .withAlpha((0.5 * 255).toInt()),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  size: 18,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item.description!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // قسم التكرار (يظهر فقط لو فيه تكرار)
                  if (hasCount) ...[
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        // Progress Bar
                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    current.toString(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '/',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    total.toString(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              if (!isFinished) ...[
                                // زر التسبيح
                                SizedBox(
                                  height: 45,
                                  width: 120,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      HapticFeedback.mediumImpact();
                                      _incrementCounter(index);
                                    },

                                    child: Text(context.localization.tasbih),
                                  ),
                                ),
                              ] else
                                // زر إعادة العد
                                SizedBox(
                                  height: 45,
                                  width: 120,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      _resetCounter(index);
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      color: colorScheme.primary,
                                    ),
                                    label: Text(
                                      context.localization.reset,
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      side: BorderSide(
                                        color: colorScheme.primary,
                                      ),
                                      foregroundColor: colorScheme.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
