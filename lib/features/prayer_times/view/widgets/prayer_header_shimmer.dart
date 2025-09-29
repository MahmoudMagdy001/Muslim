import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PrayerHeaderShimmer extends StatelessWidget {
  const PrayerHeaderShimmer({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
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
                      width: 80,
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
