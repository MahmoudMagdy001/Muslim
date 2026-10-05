import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';

class AzkarSelector extends StatelessWidget {
  const AzkarSelector({
    required this.azkar,
    required this.currentIndex,
    required this.isArabic,
    required this.onSelect,
    required this.onLongPress,
    super.key,
  });

  final List<ZikrEntity> azkar;
  final int currentIndex;
  final bool isArabic;
  final ValueChanged<int> onSelect;
  final ValueChanged<ZikrEntity> onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = colors.isDark;

    return SizedBox(
      height: 48.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: azkar.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final text = isArabic ? azkar[index].textAr : azkar[index].textEn;
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onSelect(index),
            onLongPress: () => onLongPress(azkar[index]),
            child: AnimatedContainer(
              duration: context.durations.normal,
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: context.radius.fullBorder,
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: colors.cardGradient,
                      )
                    : null,
                color: isSelected
                    ? null
                    : (isDark
                          ? colors.surface
                          : colors.surfaceVariant),
                border: Border.all(
                  color: isSelected
                      ? colors.secondary.withValues(alpha: 0.7)
                      : colors.border,
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: context.durations.normal,
                  style: context.typography.labelLarge.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? colors.textSecondary : colors.textPrimary),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.w600,
                    fontSize: isSelected ? 14.sp : 13.sp,
                  ),
                  child: Text(text),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
