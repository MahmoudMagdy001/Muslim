import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../core/utils/responsive_helper.dart';
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
    final heading = isArabic ? hadith.headingArabic : hadith.headingEnglish;
    final text = isArabic ? hadith.hadithArabic : hadith.hadithEnglish;
    final status = cubit.getStatus(hadith.status, isArabic);

    return RepaintBoundary(
      child: Card(
        // Color removed to use theme default (AppColors.lightCard/darkCard)
        margin: EdgeInsets.only(bottom: 12.toH),
        child: Padding(
          padding: EdgeInsets.all(16.toR),
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
                statusColor: _getStatusColor(hadith.status, context.theme),
                localizations: localizations,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const Map<String, Color> _statusColors = {
    'sahih': Colors.green,
    'hasan': Colors.blue,
    'da`eef': Colors.orange,
  };

  Color _getStatusColor(String status, ThemeData theme) =>
      _statusColors[status.toLowerCase()] ?? theme.primaryColor;
}
