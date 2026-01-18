import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ← إضافة هذه المكتبة
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/main/main_content/app_content.dart';
import 'core/main/main_content/app_initializer.dart';
import 'core/di/service_locator.dart';
import 'features/prayer_times/viewmodel/prayer_times_cubit.dart';
import 'features/quran/service/bookmarks_service.dart';
import 'features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'features/settings/view_model/font_size/font_size_cubit.dart';
import 'features/settings/view_model/language/language_cubit.dart';
import 'features/settings/view_model/rectire/rectire_cubit.dart';
import 'features/settings/view_model/theme/theme_cubit.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await InternetStateManagerInitializer.initialize();

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
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
          BlocProvider(create: (_) => PrayerTimesCubit()..init(isArabic: true)),
          BlocProvider(create: (_) => FontSizeCubit(initialFontSize)),
          BlocProvider(create: (_) => ThemeCubit(initialMode)),
          BlocProvider(create: (_) => ReciterCubit()),
          BlocProvider(
            create: (_) => BookmarksCubit(getIt<BookmarksService>()),
          ),
          BlocProvider(create: (_) => LanguageCubit(initialLocale)),
        ],
        child: InternetStateManagerInitializer(
          options: InternetStateOptions(
            checkConnectionPeriodic: const Duration(seconds: 5),
          ),
          child: const AppContent(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
