import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/features/settings/presentation/bloc/font_size/font_size_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/theme/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Settings Blocs Tests', () {
    test('FontSizeBloc initializes with default value and updates font size', () async {
      final bloc = FontSizeBloc();
      expect(bloc.state.fontSize, 18.0);

      await bloc.setFontSize(22.0);
      expect(bloc.state.fontSize, 22.0);

      // Duplicate value does not trigger change
      await bloc.setFontSize(22.0);
      expect(bloc.state.fontSize, 22.0);
    });

    test('ThemeBloc initializes with system mode and toggles/sets theme correctly', () async {
      final bloc = ThemeBloc(ThemeMode.light);
      expect(bloc.state.themeMode, ThemeMode.light);
      expect(bloc.state.isDarkMode, isFalse);

      await bloc.toggleTheme();
      expect(bloc.state.themeMode, ThemeMode.dark);
      expect(bloc.state.isDarkMode, isTrue);

      await bloc.setThemeMode(ThemeMode.system);
      expect(bloc.state.themeMode, ThemeMode.system);
    });
  });
}
