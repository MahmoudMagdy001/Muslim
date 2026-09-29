import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/settings/consts/reciters_name_arabic.dart';
import 'package:muslim/l10n/app_localizations.dart';

class ReciterDialog extends StatefulWidget {
  const ReciterDialog({
    required this.selectedReciterId,
    required this.localizations,
    super.key,
  });

  final String selectedReciterId;
  final AppLocalizations localizations;

  @override
  State<ReciterDialog> createState() => _ReciterDialogState();
}

class _ReciterDialogState extends State<ReciterDialog> {
  late final ValueNotifier<String> selectedReciterNotifier;

  @override
  void initState() {
    super.initState();
    selectedReciterNotifier = ValueNotifier(widget.selectedReciterId);
  }

  @override
  void dispose() {
    selectedReciterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: colors.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.headphones_rounded,
                  color: colors.secondary,
                  size: 22.r,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                widget.localizations.selectReciter,
                style: context.typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Flexible(
            child: ValueListenableBuilder<String>(
              valueListenable: selectedReciterNotifier,
              builder: (context, selectedReciterId, child) => RadioGroup<String>(
                groupValue: selectedReciterId,
                onChanged: (value) {
                  if (value != null) {
                    selectedReciterNotifier.value = value;
                  }
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recitersNames.length,
                  itemBuilder: (context, index) {
                    final reciter = recitersNames[index];
                    final isSelected = reciter.id == selectedReciterId;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Material(
                        color: isSelected ? colors.surfaceVariant : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: isSelected
                              ? BorderSide(color: colors.secondary.withValues(alpha: 0.4))
                              : BorderSide.none,
                        ),
                        child: RadioListTile<String>(
                          activeColor: colors.secondary,
                          title: Text(
                            reciter.localizedName(context),
                            style: context.typography.body.copyWith(
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? colors.primary : colors.textPrimary,
                            ),
                          ),
                          value: reciter.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: colors.textSecondary,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                ),
                child: Text(widget.localizations.cancelButton),
              ),
              SizedBox(width: 8.w),
              FilledButton(
                onPressed: () =>
                    Navigator.pop(context, selectedReciterNotifier.value),
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(widget.localizations.save),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
