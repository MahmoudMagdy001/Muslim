import 'package:flutter/material.dart';

import '../../consts/reciters_name_arabic.dart';

class ReciterDialog extends StatefulWidget {
  const ReciterDialog({required this.selectedReciterId, super.key});
  final String selectedReciterId;

  @override
  State<ReciterDialog> createState() => _ReciterDialogState();
}

class _ReciterDialogState extends State<ReciterDialog> {
  late String _selectedReciterId;

  @override
  void initState() {
    super.initState();
    _selectedReciterId = widget.selectedReciterId;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text('اختر القارئ', style: theme.textTheme.titleLarge),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: recitersArabic.length,
            itemBuilder: (context, index) => _ReciterRadioItem(
              reciter: recitersArabic[index],
              selectedReciterId: _selectedReciterId,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedReciterId = value);
                }
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _selectedReciterId),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _ReciterRadioItem extends StatelessWidget {
  const _ReciterRadioItem({
    required this.reciter,
    required this.selectedReciterId,
    required this.onChanged,
  });
  final dynamic reciter;
  final String selectedReciterId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = reciter.id == selectedReciterId;

    return RadioListTile<String>(
      title: Text(
        reciter.name,
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
