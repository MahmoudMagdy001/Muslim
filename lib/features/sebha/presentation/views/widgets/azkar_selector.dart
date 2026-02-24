import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/zikr_entity.dart';

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
    final isDark = context.theme.brightness == Brightness.dark;

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: azkar.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final text = isArabic ? azkar[index].textAr : azkar[index].textEn;
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onSelect(index),
            onLongPress: () => onLongPress(azkar[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: isSelected
                    ? LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF3D2E6B), const Color(0xFF251A45)]
                            : [AppColors.primary, const Color(0xFF7C6FB3)],
                      )
                    : null,
                color: isSelected
                    ? null
                    : (isDark
                          ? Colors.white.withAlpha(15)
                          : AppColors.primary.withAlpha(15)),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : (isDark
                            ? Colors.white.withAlpha(20)
                            : AppColors.primary.withAlpha(30)),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(40),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark
                              ? Colors.white70
                              : AppColors.primary.withAlpha(180)),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: isSelected ? 15 : 14,
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
