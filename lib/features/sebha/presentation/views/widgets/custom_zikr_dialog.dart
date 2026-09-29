import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';

class CustomZikrDialog extends StatefulWidget {
  const CustomZikrDialog({this.zikr, super.key});

  final ZikrEntity? zikr;

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
      final zikr = ZikrEntity(
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
    final colors = context.colors;

    return BaseAppDialog(
      icon: isEditing ? Icons.edit_rounded : Icons.add_rounded,
      iconColor: colors.secondary,
      title: isEditing ? l10n.editTasbih : l10n.addCustomTasbih,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            TextFormField(
              controller: _textArController,
              decoration: InputDecoration(
                labelText: l10n.tasbihTextAr,
                hintText: l10n.tasbihTextArHint,
                prefixIcon: Icon(
                  Icons.text_fields_rounded,
                  color: colors.secondary,
                  size: 20.r,
                ),
              ),
              validator: _validateRequired,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 14.h),
            TextFormField(
              controller: _goalController,
              decoration: InputDecoration(
                labelText: l10n.tasbihGoal,
                hintText: l10n.tasbihGoalHint,
                prefixIcon: Icon(
                  Icons.flag_rounded,
                  color: colors.secondary,
                  size: 20.r,
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
            foregroundColor: colors.textSecondary,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          ),
          child: Text(l10n.cancelButton),
        ),
        FilledButton.icon(
          onPressed: _save,
          icon: Icon(
            isEditing ? Icons.check_rounded : Icons.add_rounded,
            size: 16.r,
          ),
          label: Text(l10n.save),
          style: FilledButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }
}
