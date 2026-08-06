import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_cubit.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/hadith_view/widgets/hadith_card_header.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/hadith_view/widgets/hadith_meta_data.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/hadith_view/widgets/hadith_text.dart';
import 'package:muslim/l10n/app_localizations.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({
    required this.hadith,
    required this.localizations,
    required this.cubit,
    required this.onShowSnackBar,
    super.key,
  });

  final HadithEntity hadith;
  final AppLocalizations localizations;
  final HadithCubit cubit;
  final void Function(String) onShowSnackBar;

  void _onBookmarkPressed(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    unawaited(
      cubit.toggleHadithSave(hadith, isArabic: isArabic).then((_) {
        final isSaved = cubit.isHadithSaved(hadith.id);
        final message = isSaved
            ? 'تم حفظ الحديث رقم: ${convertToArabicNumbers(hadith.id)}'
            : 'تم إزالة الحديث رقم: ${convertToArabicNumbers(hadith.id)}';
        onShowSnackBar(message);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final heading = isArabic ? hadith.headingArabic : hadith.headingEnglish;
    final text = isArabic ? hadith.hadithArabic : hadith.hadithEnglish;
    final status = cubit.getStatus(hadith.status, isArabic: isArabic);

    return RepaintBoundary(
      child: Card(
        margin: EdgeInsets.only(bottom: 12.toH),
        child: Padding(
          padding: EdgeInsets.all(16.toR),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HadithCardHeader(
                heading: heading,
                hadithId: hadith.id,
                onBookmarkPressed: () => _onBookmarkPressed(context),
                cubit: cubit,
              ),
              const SizedBox(height: 12),
              HadithText(text: text),
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
