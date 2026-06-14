// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/widgets/custom_modal_sheet.dart';
import 'package:muslim/features/settings/view_model/theme/theme_cubit.dart';
import 'package:muslim/l10n/app_localizations.dart';

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

          unawaited(
            showCustomModalBottomSheet<void>(
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
                      onChanged: (value) async {
                        if (value != null) {
                          await cubit.setThemeMode(value);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
