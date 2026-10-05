import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';

/// Modern search section with exact match toggle chip for the Quran surahs index
class SearchSection extends StatelessWidget {
  const SearchSection({
    required this.controller,
    required this.exactSearch,
    required this.onSearchChanged,
    required this.toggleExactSearch,
    required this.clearSearch,
    super.key,
  });

  final TextEditingController controller;
  final bool exactSearch;
  final void Function(String) onSearchChanged;
  final VoidCallback toggleExactSearch;
  final VoidCallback clearSearch;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Row(
          children: [
            // Search Input Field
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: colors.border,
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: context.typography.body.copyWith(
                    color: colors.textPrimary,
                    fontSize: 13.5.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: isArabic ? 'ابحث عن سورة أو آية...' : 'Search Surah or Verse...',
                    hintStyle: context.typography.bodySmall.copyWith(
                      color: colors.textSecondary.withValues(alpha: 0.6),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Container(
                        width: 34.r,
                        height: 34.r,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          size: 18.r,
                          color: colors.primary,
                        ),
                      ),
                    ),
                    suffixIcon: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (context, value, _) => value.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                color: colors.textSecondary,
                                size: 18.r,
                              ),
                              onPressed: clearSearch,
                            )
                          : const SizedBox.shrink(),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: onSearchChanged,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
            ),
            SizedBox(width: 8.w),

            // Exact match toggle chip
            InkWell(
              onTap: toggleExactSearch,
              borderRadius: BorderRadius.circular(14.r),
              child: AnimatedContainer(
                duration: context.durations.fast,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
                decoration: BoxDecoration(
                  color: exactSearch
                      ? colors.secondary
                      : colors.surface,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: exactSearch
                        ? colors.secondary
                        : colors.border,
                    width: 0.8,
                  ),
                  boxShadow: [
                    if (exactSearch)
                      BoxShadow(
                        color: colors.secondary.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: Text(
                  isArabic ? 'تطابق تام' : 'Exact',
                  style: GoogleFonts.cairo(
                    color: exactSearch ? Colors.white : colors.textSecondary,
                    fontSize: 11.sp,
                    fontWeight: exactSearch ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
