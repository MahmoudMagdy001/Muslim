import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/base_app_dialog.dart';
import '../../model/zikr_model.dart';

class CustomZikrDialog extends StatefulWidget {
  const CustomZikrDialog({this.zikr, super.key});

  final ZikrModel? zikr;

  @override
  State<CustomZikrDialog> createState() => _CustomZikrDialogState();
}

class _CustomZikrDialogState extends State<CustomZikrDialog> {
  late final TextEditingController _textArController;
  late final TextEditingController _goalController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textArController = TextEditingController(text: widget.zikr?.textAr ?? '');
    _goalController = TextEditingController(
      text: widget.zikr?.count.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _textArController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequired;
    }
    return null;
  }

  String? _validateGoal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequired;
    }
    final goal = int.tryParse(value);
    if (goal == null || goal <= 0) {
      return context.l10n.goalMustBePositive;
    }
    return null;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final zikr = ZikrModel(
        id: widget.zikr?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        textAr: _textArController.text.trim(),
        textEn: _textArController.text.trim(),
        count: int.parse(_goalController.text.trim()),
        isCustom: true,
      );
      Navigator.pop(context, zikr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isEditing = widget.zikr != null;
    final isDark = context.theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return BaseAppDialog(
      titleWidget: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isEditing ? Icons.edit_rounded : Icons.add_rounded,
              color: primaryColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isEditing ? l10n.editTasbih : l10n.addCustomTasbih,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: _textArController,
              decoration: InputDecoration(
                labelText: l10n.tasbihTextAr,
                hintText: l10n.tasbihTextArHint,
                prefixIcon: Icon(
                  Icons.text_fields_rounded,
                  color: primaryColor.withAlpha(150),
                ),
                filled: true,
                fillColor: primaryColor.withAlpha(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor.withAlpha(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: context.colorScheme.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: context.colorScheme.error,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              validator: _validateRequired,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _goalController,
              decoration: InputDecoration(
                labelText: l10n.tasbihGoal,
                hintText: l10n.tasbihGoalHint,
                prefixIcon: Icon(
                  Icons.flag_rounded,
                  color: primaryColor.withAlpha(150),
                ),
                filled: true,
                fillColor: primaryColor.withAlpha(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor.withAlpha(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: context.colorScheme.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: context.colorScheme.error,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              keyboardType: TextInputType.number,
              validator: _validateGoal,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: isDark ? Colors.white60 : AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(l10n.cancelButton),
        ),
        FilledButton.icon(
          onPressed: _save,
          icon: Icon(
            isEditing ? Icons.check_rounded : Icons.add_rounded,
            size: 18,
          ),
          label: Text(l10n.save),
          style: FilledButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
