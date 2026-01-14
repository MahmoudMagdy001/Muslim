import 'package:flutter/material.dart';

import '../../../../../../core/utils/format_helper.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../model/hadith_model.dart';
import '../../../../view_model/hadith/hadith_cubit.dart';
import 'hadith_card_header.dart';
import 'hadith_meta_data.dart';
import 'hadith_text.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({
    required this.hadith,
    required this.isArabic,
    required this.localizations,
    required this.cubit,
    required this.onShowSnackBar,
    super.key,
  });

  final HadithModel hadith;
  final bool isArabic;
  final AppLocalizations localizations;
  final HadithCubit cubit;
  final Function(String) onShowSnackBar;

  void _onBookmarkPressed() {
    cubit.toggleHadithSave(hadith, isArabic).then((_) {
      final isSaved = cubit.isHadithSaved(hadith.id);
      final message = isSaved
          ? 'تم حفظ الحديث رقم: ${convertToArabicNumbers(hadith.id)}'
          : 'تم إزالة الحديث رقم: ${convertToArabicNumbers(hadith.id)}';
      onShowSnackBar(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heading = isArabic ? hadith.headingArabic : hadith.headingEnglish;
    final text = isArabic ? hadith.hadithArabic : hadith.hadithEnglish;
    final status = cubit.getStatus(hadith.status, isArabic);

    return RepaintBoundary(
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HadithCardHeader(
                heading: heading,
                hadithId: hadith.id,
                onBookmarkPressed: _onBookmarkPressed,
                cubit: cubit,
              ),
              const SizedBox(height: 12),
              HadithText(text: text, isArabic: isArabic),
              const SizedBox(height: 8),
              HadithMetadata(
                status: status,
                hadithId: hadith.id,
                statusColor: _getStatusColor(hadith.status, theme),
                localizations: localizations,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status, ThemeData theme) {
    switch (status.toLowerCase()) {
      case 'sahih':
        return Colors.green;
      case 'hasan':
        return Colors.blue;
      case 'da`eef':
        return Colors.orange;
      default:
        return theme.primaryColor;
    }
  }
}
