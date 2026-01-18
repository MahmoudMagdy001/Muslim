import '../../../../core/widgets/base_app_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../model/zikr_model.dart';

class CustomZikrDialog extends StatefulWidget {
  const CustomZikrDialog({required this.localizations, this.zikr, super.key});

  final AppLocalizations localizations;
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
      return widget.localizations.fieldRequired;
    }
    return null;
  }

  String? _validateGoal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return widget.localizations.fieldRequired;
    }
    final goal = int.tryParse(value);
    if (goal == null || goal <= 0) {
      return widget.localizations.goalMustBePositive;
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
    final isEditing = widget.zikr != null;

    return BaseAppDialog(
      title: isEditing
          ? widget.localizations.editTasbih
          : widget.localizations.addCustomTasbih,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: _textArController,
              decoration: InputDecoration(
                labelText: widget.localizations.tasbihTextAr,
                hintText: widget.localizations.tasbihTextArHint,
                border: const OutlineInputBorder(),
              ),
              validator: _validateRequired,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _goalController,
              decoration: InputDecoration(
                labelText: widget.localizations.tasbihGoal,
                hintText: widget.localizations.tasbihGoalHint,
                border: const OutlineInputBorder(),
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
          child: Text(widget.localizations.cancelButton),
        ),
        FilledButton(onPressed: _save, child: Text(widget.localizations.save)),
      ],
    );
  }
}
