import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/layout/view/layout_view.dart';
import '../../../features/settings/view_model/theme/theme_cubit.dart';
import '../../../features/settings/view_model/font_size/font_size_cubit.dart';
import '../../service/in_app_update.dart';
import '../../theme/app_theme.dart';
import '../../../features/settings/view_model/language/language_cubit.dart';
import '../../../features/settings/view_model/language/language_state.dart';

class AppContent extends StatefulWidget {
  const AppContent({
    required this.localizationsDelegates,
    required this.supportedLocales,
    super.key,
  });

  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUpdateService.checkForUpdate(context);
    });
  }

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

              final theme = Theme.of(context);
              final isDark = theme.brightness == Brightness.dark;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    systemNavigationBarIconBrightness: isDark
                        ? Brightness.light
                        : Brightness.dark,
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: isDark
                        ? Brightness.light
                        : Brightness.dark,
                    statusBarBrightness: isDark
                        ? Brightness.dark
                        : Brightness.light,
                    systemNavigationBarContrastEnforced: false,
                    systemStatusBarContrastEnforced: false,
                  ),
                );
              });

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
                localizationsDelegates: widget.localizationsDelegates,
                supportedLocales: widget.supportedLocales,
                home: const LayoutView(),
              );
            },
          ),
    ),
  );
}
