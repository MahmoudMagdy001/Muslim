// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../view_model/theme/theme_cubit.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) => _ThemeTile(currentMode: state.themeMode),
  );
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile({required this.currentMode});
  final ThemeMode currentMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String title;
    if (currentMode == ThemeMode.dark) {
      title = 'الوضع الليلي';
    } else if (currentMode == ThemeMode.light) {
      title = 'الوضع النهاري';
    } else {
      title = 'حسب النظام';
    }

    return ListTile(
      leading: const Icon(Icons.brightness_6, size: 28),
      title: Text('اختيار المظهر', style: theme.textTheme.titleMedium),
      trailing: Text(title, style: theme.textTheme.bodySmall),
      onTap: () => _showThemeBottomSheet(context, currentMode, theme),
    );
  }

  void _showThemeBottomSheet(
    BuildContext context,
    ThemeMode currentMode,
    ThemeData theme,
  ) {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('اختر المظهر', style: theme.textTheme.titleMedium),

          RadioListTile<ThemeMode>(
            title: Text('الوضع النهاري', style: theme.textTheme.titleMedium),
            value: ThemeMode.light,
            groupValue: currentMode,
            onChanged: (value) {
              if (value != null) {
                context.read<ThemeCubit>().setThemeMode(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text('الوضع الليلي', style: theme.textTheme.titleMedium),
            value: ThemeMode.dark,
            groupValue: currentMode,
            onChanged: (value) {
              if (value != null) {
                context.read<ThemeCubit>().setThemeMode(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text('حسب النظام', style: theme.textTheme.titleMedium),
            value: ThemeMode.system,
            groupValue: currentMode,
            onChanged: (value) {
              if (value != null) {
                context.read<ThemeCubit>().setThemeMode(value);
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
