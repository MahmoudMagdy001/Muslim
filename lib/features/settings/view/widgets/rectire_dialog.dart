import 'package:flutter/material.dart';
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
                  return RadioListTile<String>(
                    title: Text(
                      reciter.localizedName(context),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.primaryColor : null,
                      ),
                    ),
                    value: reciter.id,
                  );
                },
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
