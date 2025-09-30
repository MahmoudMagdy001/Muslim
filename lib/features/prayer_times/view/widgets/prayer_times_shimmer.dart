import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PrayerTimesShimmer extends StatelessWidget {
  const PrayerTimesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.brightness == Brightness.dark
        ? Colors.grey[700]!
        : Colors.grey[300]!;
    final highlightColor = theme.brightness == Brightness.dark
        ? Colors.grey[500]!
        : Colors.grey[100]!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🟢 اسم المدينة
              Container(
                height: 14,
                width: 100,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
              ),

              // 🟢 الهيدر (الهجري + زر تحديث)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 14, width: 120, color: Colors.white),
                  Container(height: 24, width: 24, color: Colors.white),
                ],
              ),
              const SizedBox(height: 16),

              // 🟢 اسم الصلاة + وقتها
              Row(
                children: [
                  Container(height: 16, width: 60, color: Colors.white),
                  const SizedBox(width: 8),
                  Container(height: 16, width: 50, color: Colors.white),
                ],
              ),
              const SizedBox(height: 12),

              // 🟢 الوقت المتبقي
              Container(height: 14, width: 150, color: Colors.white),
              const SizedBox(height: 20),

              // 🟢 زر عرض المزيد
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
