import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PrayerTileShimmer extends StatelessWidget {
  const PrayerTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة الصلاة (دائرة)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[600] : Colors.grey[200],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 8),

            // اسم الصلاة
            Container(
              width: 60,
              height: 16,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[600] : Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),

            // توقيت الصلاة
            Container(
              width: 50,
              height: 14,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[600] : Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),

            // الوقت المتبقي (للتأثير الإضافي)
            Container(
              width: 40,
              height: 12,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[600] : Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerHeaderShimmer extends StatelessWidget {
  const PrayerHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // الصف العلوي (الأيقونة والنصوص)
              Row(
                children: [
                  // الأيقونة
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[600] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 15),

                  // النصوص
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 18,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[600] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 80,
                        height: 16,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[600] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // زر التحديث
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[600] : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // شريط الوقت المتبقي
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
