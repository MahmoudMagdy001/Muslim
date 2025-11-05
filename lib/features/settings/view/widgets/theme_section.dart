// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../view_model/theme/theme_cubit.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({
    required this.localizations,
    required this.theme,
    super.key,
  });
  final AppLocalizations localizations;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) {
      final currentMode = state.themeMode;

      String title;
      if (currentMode == ThemeMode.dark) {
        title = localizations.darkMode;
      } else if (currentMode == ThemeMode.light) {
        title = localizations.lightMode;
      } else {
        title = localizations.systemMode;
      }

      return ListTile(
        leading: const Icon(Icons.brightness_6),
        title: Text(
          localizations.changeTheme,
          style: theme.textTheme.titleMedium,
        ),
        trailing: Text(title, style: theme.textTheme.bodySmall),
        onTap: () {
          final cubit = context.read<ThemeCubit>();

          showCustomModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  localizations.selectTheme,
                  style: theme.textTheme.titleMedium,
                ),
                ...[ThemeMode.light, ThemeMode.dark, ThemeMode.system].map(
                  (mode) => RadioListTile<ThemeMode>(
                    title: Text(
                      mode == ThemeMode.light
                          ? localizations.lightMode
                          : mode == ThemeMode.dark
                          ? localizations.darkMode
                          : localizations.systemMode,
                      style: theme.textTheme.titleMedium,
                    ),
                    value: mode,
                    groupValue: currentMode,
                    onChanged: (value) {
                      if (value != null) {
                        cubit.setThemeMode(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      );
    },
  );
}
