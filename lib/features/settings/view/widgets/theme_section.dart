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
      builder: (context, state) => _ThemeSwitch(isDarkMode: state.isDarkMode),
    ),
  );
}

class _ThemeSwitch extends StatelessWidget {
  const _ThemeSwitch({required this.isDarkMode});
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode, size: 28),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isDarkMode ? 'الوضع الليلي' : 'الوضع النهاري',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            isDarkMode
                ? 'التبديل إلى الوضع النهاري'
                : 'التبديل إلى الوضع الليلي',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
      ),
    );
  }
}
