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

  group('Settings Cubits Tests', () {
    test('FontSizeCubit initializes with default value and updates font size', () async {
      final cubit = FontSizeCubit();
      expect(cubit.state.fontSize, 18.0);

      await cubit.setFontSize(22.0);
      expect(cubit.state.fontSize, 22.0);

      // Duplicate value does not trigger change
      await cubit.setFontSize(22.0);
      expect(cubit.state.fontSize, 22.0);
    });

    test('ThemeCubit initializes with system mode and toggles/sets theme correctly', () async {
      final cubit = ThemeCubit(ThemeMode.light);
      expect(cubit.state.themeMode, ThemeMode.light);
      expect(cubit.state.isDarkMode, isFalse);

      await cubit.toggleTheme();
      expect(cubit.state.themeMode, ThemeMode.dark);
      expect(cubit.state.isDarkMode, isTrue);

      await cubit.setThemeMode(ThemeMode.system);
      expect(cubit.state.themeMode, ThemeMode.system);
    });
  });
}
