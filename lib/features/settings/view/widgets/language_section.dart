// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../view_model/language/language_cubit.dart';
import '../../view_model/language/language_state.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) => _LanguageTile(currentLocale: state.locale),
      );
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.currentLocale});
  final Locale currentLocale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String title;
    if (currentLocale.languageCode == 'ar') {
      title = 'العربية';
    } else {
      title = 'English';
    }

    return ListTile(
      leading: const Icon(Icons.language, size: 28),
      title: Text('اختيار اللغة', style: theme.textTheme.titleMedium),
      trailing: Text(title, style: theme.textTheme.bodySmall),
      onTap: () => _showLanguageBottomSheet(context, currentLocale, theme),
    );
  }

  void _showLanguageBottomSheet(
    BuildContext context,
    Locale currentLocale,
    ThemeData theme,
  ) {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('اختر اللغة', style: theme.textTheme.titleMedium),
          RadioListTile<Locale>(
            title: Text('العربية', style: theme.textTheme.titleMedium),
            value: const Locale('ar'),
            groupValue: currentLocale,
            onChanged: (value) {
              if (value != null) {
                context.read<LanguageCubit>().changeLanguage(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<Locale>(
            title: Text('English', style: theme.textTheme.titleMedium),
            value: const Locale('en'),
            groupValue: currentLocale,
            onChanged: (value) {
              if (value != null) {
                context.read<LanguageCubit>().changeLanguage(value);
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
