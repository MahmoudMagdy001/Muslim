import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/settings/view_model/font_size/font_size_cubit.dart';
import 'features/settings/view_model/rectire/rectire_cubit.dart';
import 'features/settings/view_model/theme/theme_cubit.dart';
import 'core/main/main_content/app_content.dart';
import 'core/main/main_content/app_initializer.dart';
import 'core/main/main_content/error_app.dart';

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => FontSizeCubit()),
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => ReciterCubit()),
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
