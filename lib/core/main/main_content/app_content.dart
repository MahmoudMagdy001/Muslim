import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/layout/view/layout_view.dart';
import '../../../features/settings/view_model/theme/theme_cubit.dart';
import '../../../features/settings/view_model/font_size/font_size_cubit.dart';
import '../../theme/app_theme.dart';

/// App content that depends on cubits
import '../../../features/settings/view_model/language/language_cubit.dart';
import '../../../features/settings/view_model/language/language_state.dart';

class AppContent extends StatelessWidget {
  const AppContent({
    required this.localizationsDelegates,
    required this.supportedLocales,
    super.key,
  });

  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) => BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, fontSizeState) =>
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              final fontSize = fontSizeState.fontSize;
              final themeFactory = AppThemeFactory(fontSize);
              final lightTheme = themeFactory.lightTheme;
              final darkTheme = themeFactory.darkTheme;

              return MaterialApp(
                themeAnimationStyle: const AnimationStyle(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 500),
                  reverseCurve: Curves.easeOut,
                  reverseDuration: Duration(milliseconds: 500),
                ),

                debugShowCheckedModeBanner: false,
                themeMode: themeState.themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                locale: languageState.locale,
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: const LayoutView(),
              );
            },
          ),
    ),
  );
}
