import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/font_size/font_size_cubit.dart';
import 'section_card.dart';

class FontSizeSection extends StatelessWidget {
  const FontSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSizeCubit = context.read<FontSizeCubit>();

    return SectionCard(
      title: 'حجم الخط',
      child: BlocBuilder<FontSizeCubit, FontSizeState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FontSizeSlider(fontSizeCubit: fontSizeCubit),
            const SizedBox(height: 8),
            _FontSizeIndicator(fontSize: state.fontSize),
          ],
        ),
      ),
    );
  }
}

class _FontSizeSlider extends StatelessWidget {
  const _FontSizeSlider({required this.fontSizeCubit});
  final FontSizeCubit fontSizeCubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('أصغر', style: theme.textTheme.bodyMedium),
          Expanded(
            child: Slider(
              value: state.fontSize,
              min: 12.0,
              max: 23.0,
              divisions: 11,
              label: state.fontSize.round().toString(),
              onChanged: (value) => fontSizeCubit.setFontSize(value),
            ),
          ),
          Text('أكبر', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _FontSizeIndicator extends StatelessWidget {
  const _FontSizeIndicator({required this.fontSize});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.primaryColor.withAlpha(25),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.primaryColor.withAlpha(76)),
        ),
        child: Text(
          'الحجم: ${fontSize.round()}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
