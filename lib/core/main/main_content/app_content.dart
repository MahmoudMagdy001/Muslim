import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/layout_screen.dart';
import '../../../screens/settings/provider/font_size_provider.dart';
import '../../../screens/settings/provider/theme_provider.dart';
import '../../theme/app_theme.dart';

/// App content that depends on providers
class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    final fontSize = fontSizeProvider.fontSize;
    final themeFactory = AppThemeFactory(fontSize);

    // Get themes
    final ThemeData lightTheme = themeFactory.lightTheme;
    final ThemeData darkTheme = themeFactory.darkTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LayoutScreen(),
    );
  }
}
