// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../view_model/font_size/font_size_cubit.dart';

class FontSizeSection extends StatelessWidget {
  const FontSizeSection({
    required this.localizations,
    required this.theme,
    super.key,
  });

  final AppLocalizations localizations;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final fontSizeCubit = context.read<FontSizeCubit>();

    return BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, state) => ListTile(
        leading: const Icon(Icons.text_fields),
        title: Text(
          localizations.changeFontSize,
          style: theme.textTheme.titleMedium,
        ),
        trailing: Text(
          _getLabelForFontSize(state.fontSize),
          style: theme.textTheme.bodySmall,
        ),
        onTap: () => _showFontSizeModal(context, state.fontSize, fontSizeCubit),
      ),
    );
  }

  void _showFontSizeModal(
    BuildContext context,
    double currentSize,
    FontSizeCubit cubit,
  ) {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.selectFontSize,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          RadioListTile<double>(
            title: Text(
              localizations.smallFont,
              style: theme.textTheme.titleMedium,
            ),
            value: 14,
            groupValue: currentSize.roundToDouble(),
            onChanged: (value) {
              cubit.setFontSize(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<double>(
            title: Text(
              localizations.defultFont,
              style: theme.textTheme.titleMedium,
            ),
            value: 18,
            groupValue: currentSize.roundToDouble(),
            onChanged: (value) {
              cubit.setFontSize(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<double>(
            title: Text(
              localizations.bigFont,
              style: theme.textTheme.titleMedium,
            ),
            value: 22,
            groupValue: currentSize.roundToDouble(),
            onChanged: (value) {
              cubit.setFontSize(value!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  String _getLabelForFontSize(double size) {
    if (size.round() == 14) return localizations.smallFont;
    if (size.round() == 18) return localizations.defultFont;
    if (size.round() == 22) return localizations.bigFont;
    return '${size.round()}';
  }
}
