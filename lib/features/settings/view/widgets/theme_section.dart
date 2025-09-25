import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/theme/theme_cubit.dart';
import 'section_card.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    title: 'المظهر',
    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => _ThemeTile(currentMode: state.themeMode),
    ),
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
      leading: Icon(
        currentMode == ThemeMode.dark
            ? Icons.dark_mode
            : currentMode == ThemeMode.light
            ? Icons.light_mode
            : Icons.brightness_auto,
        size: 28,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('اضغط لاختيار المظهر', style: theme.textTheme.bodySmall),
        ],
      ),

      onTap: () => _showThemeDialog(context, currentMode),
    );
  }

  void _showThemeDialog(BuildContext context, ThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SimpleDialog(
          title: const Text('اختر المظهر'),
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('الوضع النهاري'),
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
              title: const Text('الوضع الليلي'),
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
              title: const Text('حسب النظام'),
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeCubit>().setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
