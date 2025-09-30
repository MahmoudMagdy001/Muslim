import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/main/main_content/app_content.dart';
import 'core/main/main_content/app_initializer.dart';
import 'features/quran/service/bookmarks_service.dart';
import 'features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'features/settings/view_model/font_size/font_size_cubit.dart';
import 'features/settings/view_model/rectire/rectire_cubit.dart';
import 'features/settings/view_model/theme/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final prefs = await SharedPreferences.getInstance();
    final initializer = AppInitializer(prefs);
    await initializer.initialize();

    final themeText = prefs.getString('themeMode');
    ThemeMode initialMode;
    if (themeText?.contains('dark') ?? false) {
      initialMode = ThemeMode.dark;
    } else if (themeText?.contains('light') ?? false) {
      initialMode = ThemeMode.light;
    } else {
      initialMode = ThemeMode.system;
    }

    final initialFontSize = prefs.getDouble('fontSize') ?? 18.0;

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FontSizeCubit(initialFontSize)),
          BlocProvider(create: (_) => ThemeCubit(initialMode)),
          BlocProvider(create: (_) => ReciterCubit()),
          BlocProvider(create: (_) => BookmarksCubit(BookmarksService())),
        ],
        child: const AppContent(),
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
