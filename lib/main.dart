import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/main/main_content/app_content.dart';
import 'core/main/main_content/app_initializer.dart';
import 'core/main/main_content/error_app.dart';
import 'screens/settings/provider/rectire_provider.dart';
import 'screens/settings/provider/theme_provider.dart';
import 'screens/settings/provider/font_size_provider.dart';

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FontSizeProvider()),
      // ChangeNotifierProvider(create: (_) => QuranAudioService()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => ReciterProvider()),
    ],
    child: const AppContent(),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final prefs = await SharedPreferences.getInstance();
    final initializer = AppInitializer(prefs);
    await initializer.initialize();
    runApp(const MuslimApp());
  } catch (e) {
    runApp(const ErrorApp());
  }
}
