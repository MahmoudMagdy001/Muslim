// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../view_model/theme/theme_cubit.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({required this.localizations, super.key});
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) =>
        _ThemeTile(currentMode: state.themeMode, localizations: localizations),
  );
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile({required this.currentMode, required this.localizations});
  final ThemeMode currentMode;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String title;
    if (currentMode == ThemeMode.dark) {
      title = localizations.darkMode;
    } else if (currentMode == ThemeMode.light) {
      title = localizations.lightMode;
    } else {
      title = localizations.systemMode;
    }

    return ListTile(
      leading: const Icon(Icons.brightness_6, size: 28),
      title: Text(
        localizations.changeTheme,
        style: theme.textTheme.titleMedium,
      ),
      trailing: Text(title, style: theme.textTheme.bodySmall),
      onTap: () =>
          _showThemeBottomSheet(context, currentMode, theme, localizations),
    );
  }

  void _showThemeBottomSheet(
    BuildContext context,
    ThemeMode currentMode,
    ThemeData theme,
    AppLocalizations localizations,
  ) {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(localizations.selectTheme, style: theme.textTheme.titleMedium),

          RadioListTile<ThemeMode>(
            title: Text(
              localizations.lightMode,
              style: theme.textTheme.titleMedium,
            ),
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
            title: Text(
              localizations.darkMode,
              style: theme.textTheme.titleMedium,
            ),
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
            title: Text(
              localizations.systemMode,
              style: theme.textTheme.titleMedium,
            ),
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
