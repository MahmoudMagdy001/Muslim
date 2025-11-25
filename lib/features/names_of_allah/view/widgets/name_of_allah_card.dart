import 'package:flutter/material.dart';
import '../../../../core/utils/format_helper.dart';
import '../../model/names_of_allah_model.dart';

class NameOfAllahCard extends StatelessWidget {
  const NameOfAllahCard({
    required this.data,
    required this.index,
    required this.isArabic,
    required this.isSharing,
    required this.onShare,
    super.key,
  });
  final DataItem data;
  final int index;
  final bool isArabic;
  final bool isSharing;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = isArabic ? data.name : data.nameTranslation;
    final text = isArabic ? data.text : data.textTranslation;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha((0.1 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              isArabic
                  ? convertToArabicNumbers((index + 1).toString())
                  : (index + 1).toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(name, style: theme.textTheme.titleLarge),
                  ),
                  const SizedBox(width: 8),
                  isSharing
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.share_rounded),
                          onPressed: onShare,
                        ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${isArabic ? 'المعني' : 'Meaning'} : $text',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
