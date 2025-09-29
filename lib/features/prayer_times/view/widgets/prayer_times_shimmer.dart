import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/prayer_consts.dart';

class PrayerTimesShimmer extends StatelessWidget {
  const PrayerTimesShimmer({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
    highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          prayerOrder.length,
          (index) => Container(
            width: MediaQuery.of(context).size.width / prayerOrder.length - 12,
            height: 90,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.1 * 255).toInt()),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
