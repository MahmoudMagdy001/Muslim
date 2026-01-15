import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../core/utils/format_helper.dart';
import '../../../../../../l10n/app_localizations.dart';

class HadithMetadata extends StatelessWidget {
  const HadithMetadata({
    required this.status,
    required this.hadithId,
    required this.statusColor,
    required this.localizations,
    super.key,
  });

  final String status;
  final String hadithId;
  final Color statusColor;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '${localizations.hadithStatus}: $status',
        style: context.textTheme.titleSmall?.copyWith(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'رقم الحديث: ${convertToArabicNumbers(hadithId)}',
        style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
    ],
  );
}
