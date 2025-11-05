// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../view_model/language/language_cubit.dart';
import '../../view_model/language/language_state.dart';

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

          final String title = currentLocale.languageCode == 'ar'
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
    final theme = Theme.of(context);
    final cubit = context.read<LanguageCubit>();

    showCustomModalBottomSheet(
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
            onChanged: (value) {
              if (value != null) {
                cubit.changeLanguage(value);
                Navigator.pop(context);
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
            onChanged: (value) {
              if (value != null) {
                cubit.changeLanguage(value);
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
