import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ← إضافة هذه المكتبة
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/main/main_content/app_content.dart';
import 'core/main/main_content/app_initializer.dart';
import 'features/quran/service/bookmarks_service.dart';
import 'features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'features/settings/view_model/font_size/font_size_cubit.dart';
import 'features/settings/view_model/language/language_cubit.dart';
import 'features/settings/view_model/rectire/rectire_cubit.dart';
import 'features/settings/view_model/theme/theme_cubit.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ← إضافة SystemChrome هنا قبل أي شيء
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top], // إظهار الـ status bar فقط
  );

  try {
    final prefs = await SharedPreferences.getInstance();
    final initializer = AppInitializer(prefs);
    await initializer.initialize();

    final initialLocale = initializer.getInitialLanguage();
    final initialMode = initializer.getInitialThemeMode();
    final initialFontSize = initializer.getInitialFontSize();

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FontSizeCubit(initialFontSize)),
          BlocProvider(create: (_) => ThemeCubit(initialMode)),
          BlocProvider(create: (_) => ReciterCubit()),
          BlocProvider(create: (_) => BookmarksCubit(BookmarksService())),
          BlocProvider(create: (_) => LanguageCubit(initialLocale)),
        ],
        child: const AppContent(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
