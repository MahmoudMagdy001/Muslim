// ignore_for_file: avoid_dynamic_calls, deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/extensions.dart';
import '../../consts/reciters_name_arabic.dart';

class ReciterDialog extends StatefulWidget {
  const ReciterDialog({
    required this.selectedReciterId,
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final String selectedReciterId;
  final AppLocalizations localizations;
  final bool isArabic;

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
    final theme = context.theme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.localizations.selectReciter,
          style: theme.textTheme.titleMedium,
        ),
        Flexible(
          child: ValueListenableBuilder<String>(
            valueListenable: selectedReciterNotifier,
            builder: (context, selectedReciterId, child) => ListView.builder(
              shrinkWrap: true,
              itemCount: recitersNames.length,
              itemBuilder: (context, index) => _ReciterRadioItem(
                reciter: recitersNames[index],
                selectedReciterId: selectedReciterId,
                onChanged: (value) {
                  if (value != null) {
                    selectedReciterNotifier.value = value;
                  }
                },
                isArabic: widget.isArabic,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  widget.localizations.cancelButton,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withAlpha(153),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context, selectedReciterNotifier.value),
                child: Text(widget.localizations.save),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _ReciterRadioItem extends StatelessWidget {
  const _ReciterRadioItem({
    required this.reciter,
    required this.selectedReciterId,
    required this.onChanged,
    required this.isArabic,
  });
  final dynamic reciter;
  final String selectedReciterId;
  final ValueChanged<String?> onChanged;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isSelected = reciter.id == selectedReciterId;

    return RadioListTile<String>(
      title: Text(
        isArabic ? reciter.nameAr : reciter.nameEn,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.primaryColor : null,
        ),
      ),
      value: reciter.id,
      groupValue: selectedReciterId,
      onChanged: onChanged,
    );
  }
}
