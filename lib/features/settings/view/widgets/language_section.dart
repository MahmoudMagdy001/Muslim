// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/custom_modal_sheet.dart';
import 'package:muslim/features/settings/view_model/language/language_cubit.dart';
import 'package:muslim/features/settings/view_model/language/language_state.dart';
import 'package:muslim/l10n/app_localizations.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({
    required this.localizations,
    required this.theme,
    super.key,
  });
  final AppLocalizations localizations;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final currentLocale = state.locale;

          final title = currentLocale.languageCode == 'ar'
              ? localizations.arabicLanguage
              : localizations.englishLanguage;

          return ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              localizations.changeLanguage,
              style: theme.textTheme.titleMedium,
            ),
            trailing: Text(title, style: theme.textTheme.bodySmall),
            onTap: () => _showLanguageBottomSheet(context, currentLocale),
          );
        },
      );

  void _showLanguageBottomSheet(BuildContext context, Locale currentLocale) {
    final theme = context.theme;
    final cubit = context.read<LanguageCubit>();

    unawaited(
      showCustomModalBottomSheet<void>(
        context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.selectLanguage,
            style: theme.textTheme.titleMedium,
          ),
          RadioListTile<Locale>(
            title: Text(
              localizations.arabicLanguage,
              style: theme.textTheme.titleMedium,
            ),
            value: const Locale('ar'),
            groupValue: currentLocale,
            onChanged: (value) async {
              if (value != null) {
                await cubit.changeLanguage(value);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
          RadioListTile<Locale>(
            title: Text(
              localizations.englishLanguage,
              style: theme.textTheme.titleMedium,
            ),
            value: const Locale('en'),
            groupValue: currentLocale,
            onChanged: (value) async {
              if (value != null) {
                await cubit.changeLanguage(value);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    ),);
  }
}
