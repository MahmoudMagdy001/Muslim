import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../model/hadith_model.dart';
import '../../view_model/hadith/hadith_cubit.dart';
import 'hadith_view/hadith_view.dart';

class HadithOfTheDayCard extends StatelessWidget {
  const HadithOfTheDayCard({required this.randomHadithFuture, super.key});

  final Future<Map<String, dynamic>>? randomHadithFuture;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return FutureBuilder<Map<String, dynamic>>(
      future: randomHadithFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final hasError = snapshot.hasError;
        final data = snapshot.data;

        if (hasError) {
          return Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: theme.colorScheme.error),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('فشل تحميل حديث اليوم. حاول لاحقاً.'),
                ),
              ],
            ),
          );
        }

        if (data == null && !isLoading) {
          return const SizedBox.shrink();
        }

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.cardGradient(context),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حديث اليوم',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isLoading
                                ? 'جاري تحميل حديث اليوم...'
                                : _getHadithText(data!['hadith'], isArabic),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withAlpha(
                                (0.9 * 255).toInt(),
                              ),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      'assets/hadith/Hadis.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () => _navigateToHadith(context, data!, localization),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.colorScheme.secondary,
                      foregroundColor: context.theme.colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'قراءة الحديث',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getHadithText(HadithModel hadith, bool isArabic) {
    final text = isArabic ? hadith.hadithArabic : hadith.hadithEnglish;
    // Remove some common characters or clean up if needed
    return text.replaceAll('\n', ' ').trim();
  }

  void _navigateToHadith(
    BuildContext context,
    Map<String, dynamic> data,
    AppLocalizations localization,
  ) {
    final HadithModel hadith = data['hadith'];
    final String bookSlug = data['bookSlug'];
    final String chapterNumber = data['chapterNumber'];
    final String chapterName =
        Localizations.localeOf(context).languageCode == 'ar'
        ? data['chapterNameAr']
        : data['chapterNameEn'];

    navigateWithTransition(
      context,
      BlocProvider(
        create: (context) => HadithCubit(
          bookSlug: bookSlug,
          chapterNumber: chapterNumber,
          chapterName: chapterName,
        )..initializeData(),
        child: HadithView(
          bookSlug: bookSlug,
          chapterNumber: chapterNumber,
          chapterName: chapterName,
          localizations: localization,
          scrollToHadithId: int.tryParse(hadith.id),
        ),
      ),
      type: TransitionType.fade,
    );
  }
}
