import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/azkar/presentation/views/azkar_view.dart';

class ContextualDhikrCard extends StatelessWidget {
  const ContextualDhikrCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    String title;
    String badgeText;
    String subtitle;

    if (hour >= 4 && hour < 12) {
      title = isArabic ? 'أذكار الصباح' : 'Morning Azkar';
      badgeText = isArabic ? 'وقت الصباح المستحب' : 'Recommended Time: Morning';
      subtitle = isArabic
          ? 'حصن نفسك ليوم مبارك بذكر الله'
          : 'Fortify your day with morning remembrance';
    } else if (hour >= 12 && hour < 20) {
      title = isArabic ? 'أذكار المساء' : 'Evening Azkar';
      badgeText = isArabic ? 'وقت المساء المستحب' : 'Recommended Time: Evening';
      subtitle = isArabic
          ? 'أمسينا وأمسى الملك لله وحده'
          : 'Evening peace through remembrance of Allah';
    } else {
      title = isArabic ? 'أذكار النوم والمساء' : 'Sleep Azkar & Istighfar';
      badgeText = isArabic ? 'سكينة الليل' : 'Nightly Serenity';
      subtitle = isArabic
          ? 'باسمك ربي وضعت جنبي وبك أرفعه'
          : 'Rest in tranquility and divine protection';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 6.toH),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.toR),
          color: context.theme.brightness == Brightness.dark
              ? const Color(0xFF182421)
              : Colors.white,
          border: Border.all(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  const AzkarView(),
                  type: TransitionType.fade,
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.toR),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 14.toH),
              child: Row(
                children: [
                  // Icon badge
                  Container(
                    width: 58.toW,
                    height: 58.toH,
                    padding: EdgeInsets.all(8.toR),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16.toR),
                    ),
                    child: Image.asset(
                      'assets/home/azkar.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.brightness_5_rounded,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.toW),

                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.toW,
                                vertical: 2.toH,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8.toR),
                              ),
                              child: Text(
                                badgeText,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: const Color(0xFFD4AF37),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.toH),
                        Text(
                          title,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xFF192522),
                          ),
                        ),
                        SizedBox(height: 2.toH),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.theme.brightness == Brightness.dark
                                ? Colors.white70
                                : const Color(0xFF5D716C),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.toW),

                  // Action Button
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.toW,
                      vertical: 6.toH,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A3B34),
                      borderRadius: BorderRadius.circular(14.toR),
                    ),
                    child: Text(
                      isArabic ? 'اقرأ الآن' : 'Read',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
