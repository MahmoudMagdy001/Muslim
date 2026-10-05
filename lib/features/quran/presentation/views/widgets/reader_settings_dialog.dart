import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/quran/presentation/models/quran_reader_settings.dart';

/// Modal bottom sheet for customizing Quran reader appearance and typography
class ReaderSettingsDialog extends StatefulWidget {
  const ReaderSettingsDialog({
    required this.initialSettings,
    required this.onChanged,
    super.key,
  });

  final QuranReaderSettings initialSettings;
  final ValueChanged<QuranReaderSettings> onChanged;

  static Future<void> show(
    BuildContext context, {
    required QuranReaderSettings currentSettings,
    required ValueChanged<QuranReaderSettings> onChanged,
  }) =>
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ReaderSettingsDialog(
          initialSettings: currentSettings,
          onChanged: onChanged,
        ),
      );

  @override
  State<ReaderSettingsDialog> createState() => _ReaderSettingsDialogState();
}

class _ReaderSettingsDialogState extends State<ReaderSettingsDialog> {
  late QuranReaderTheme _selectedTheme;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialSettings.theme;
    _fontSize = widget.initialSettings.fontSize;
  }

  void _updateSettings() {
    final updated = QuranReaderSettings(
      theme: _selectedTheme,
      fontSize: _fontSize,
    );
    widget.onChanged(updated);
    unawaited(updated.save());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: colors.border, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_stories_rounded,
                      color: colors.secondary,
                      size: 20.r,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      isArabic ? 'إعدادات مظهر القراءة' : 'Reading Display Settings',
                      style: context.typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close_rounded, color: colors.textSecondary, size: 20.r),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Reading Theme Selector
            Text(
              isArabic ? 'مظهر صفحة المصحف' : 'Mushaf Paper Theme',
              style: context.typography.labelLarge.copyWith(
                color: colors.textSecondary,
                fontSize: 12.5.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: QuranReaderTheme.values.map((theme) {
                final isSelected = theme == _selectedTheme;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedTheme = theme);
                      _updateSettings();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? colors.secondary
                              : theme.frameColor.withValues(alpha: 0.35),
                          width: isSelected ? 2.0 : 1.0,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: colors.secondary.withValues(alpha: 0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? colors.secondary : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? colors.secondary
                                    : theme.textColor.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? Icon(Icons.check, size: 14.r, color: Colors.white)
                                : null,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            theme.displayNameAr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 10.5.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: theme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.h),

            // Font Size Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? 'حجم الخط القرآني' : 'Quran Font Size',
                  style: context.typography.labelLarge.copyWith(
                    color: colors.textSecondary,
                    fontSize: 12.5.sp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.2),
                      width: 0.6,
                    ),
                  ),
                  child: Text(
                    isArabic
                        ? convertToArabicNumbers(_fontSize.toInt().toString())
                        : _fontSize.toInt().toString(),
                    style: context.typography.titleSmall.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),

            // Font Size Slider with - and + buttons
            Row(
              children: [
                IconButton(
                  onPressed: _fontSize > 18.0
                      ? () {
                          setState(() => _fontSize = (_fontSize - 1).clamp(18.0, 34.0));
                          _updateSettings();
                        }
                      : null,
                  icon: Icon(Icons.text_decrease_rounded, color: colors.primary, size: 22.r),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.border,
                      thumbColor: colors.secondary,
                      trackHeight: 4.h,
                    ),
                    child: Slider(
                      value: _fontSize,
                      min: 18.0,
                      max: 34.0,
                      divisions: 16,
                      onChanged: (val) {
                        setState(() => _fontSize = val);
                        _updateSettings();
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _fontSize < 34.0
                      ? () {
                          setState(() => _fontSize = (_fontSize + 1).clamp(18.0, 34.0));
                          _updateSettings();
                        }
                      : null,
                  icon: Icon(Icons.text_increase_rounded, color: colors.primary, size: 22.r),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Live Preview Card
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: _selectedTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _selectedTheme.frameColor.withValues(alpha: 0.5),
                  width: 0.8,
                ),
              ),
              child: Text(
                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(
                  fontSize: _fontSize.sp,
                  color: _selectedTheme.textColor,
                  fontWeight: FontWeight.bold,
                  height: 1.8,
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
