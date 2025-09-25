import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/font_size/font_size_cubit.dart';
import 'section_card.dart';

class FontSizeSection extends StatelessWidget {
  const FontSizeSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    title: 'حجم الخط',
    child: BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, state) => _FontSizeSwitch(currentSize: state.fontSize),
    ),
  );
}

class _FontSizeSwitch extends StatelessWidget {
  const _FontSizeSwitch({required this.currentSize});
  final double currentSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: const Icon(Icons.text_fields, size: 28),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تغيير حجم الخط', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            _getLabelForFontSize(currentSize),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () => _showFontSizeDialog(context, currentSize),
    );
  }

  void _showFontSizeDialog(BuildContext context, double currentSize) {
    final fontSizeCubit = context.read<FontSizeCubit>();

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('اختر حجم الخط'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<double>(
                title: const Text('صغير'),
                value: 14,
                groupValue: currentSize.roundToDouble(),
                onChanged: (value) {
                  fontSizeCubit.setFontSize(value!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<double>(
                title: const Text('متوسط'),
                value: 18,
                groupValue: currentSize.roundToDouble(),
                onChanged: (value) {
                  fontSizeCubit.setFontSize(value!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<double>(
                title: const Text('كبير'),
                value: 22,
                groupValue: currentSize.roundToDouble(),
                onChanged: (value) {
                  fontSizeCubit.setFontSize(value!);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLabelForFontSize(double size) {
    if (size.round() == 14) return 'صغير';
    if (size.round() == 18) return 'متوسط';
    if (size.round() == 22) return 'كبير';
    return '${size.round()}';
  }
}
