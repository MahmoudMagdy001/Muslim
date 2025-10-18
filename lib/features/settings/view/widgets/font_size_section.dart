// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../view_model/font_size/font_size_cubit.dart';

class FontSizeSection extends StatelessWidget {
  const FontSizeSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FontSizeCubit, FontSizeState>(
        builder: (context, state) =>
            _FontSizeSwitch(currentSize: state.fontSize),
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
      title: Text('تغيير حجم الخط', style: theme.textTheme.titleMedium),
      trailing: Text(
        _getLabelForFontSize(currentSize),
        style: theme.textTheme.bodySmall,
      ),
      onTap: () => _showFontSizeModal(context, currentSize, theme),
    );
  }

  void _showFontSizeModal(
    BuildContext context,
    double currentSize,
    ThemeData theme,
  ) {
    final fontSizeCubit = context.read<FontSizeCubit>();
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('اختر حجم الخط', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          RadioListTile<double>(
            title: Text('صغير', style: theme.textTheme.titleMedium),
            value: 14,
            groupValue: currentSize.roundToDouble(),
            onChanged: (value) {
              fontSizeCubit.setFontSize(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<double>(
            title: Text('افتراضي', style: theme.textTheme.titleMedium),
            value: 18,
            groupValue: currentSize.roundToDouble(),
            onChanged: (value) {
              fontSizeCubit.setFontSize(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<double>(
            title: Text('كبير', style: theme.textTheme.titleMedium),
            value: 22,
            groupValue: currentSize.roundToDouble(),
            onChanged: (value) {
              fontSizeCubit.setFontSize(value!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  String _getLabelForFontSize(double size) {
    if (size.round() == 14) return 'صغير';
    if (size.round() == 18) return 'افتراضي';
    if (size.round() == 22) return 'كبير';
    return '${size.round()}';
  }
}
