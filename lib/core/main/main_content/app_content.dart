import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/layout_screen.dart';
import '../../../features/settings/view_model/theme/theme_cubit.dart';
import '../../../features/settings/view_model/font_size/font_size_cubit.dart';
import '../../theme/app_theme.dart';

/// App content that depends on cubits
class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) => BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, fontSizeState) {
        final fontSize = fontSizeState.fontSize;
        final themeFactory = AppThemeFactory(fontSize);

        // Get themes
        final ThemeData lightTheme = themeFactory.lightTheme;
        final ThemeData darkTheme = themeFactory.darkTheme;

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
          home: const LayoutScreen(),
        );
      },
    ),
  );
}
