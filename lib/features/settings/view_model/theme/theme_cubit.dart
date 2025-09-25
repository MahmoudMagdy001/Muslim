import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State class
class ThemeState {
  ThemeState({required this.themeMode});
  final ThemeMode themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode;

  @override
  int get hashCode => themeMode.hashCode;
}

// Cubit class
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(ThemeMode initialMode) : super(ThemeState(themeMode: initialMode));

  static const String _themeKey = 'themeMode';

  Future<void> toggleTheme() async {
    final newThemeMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newThemeMode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (themeMode == state.themeMode) return;

    final previousState = state;
    emit(ThemeState(themeMode: themeMode));

    try {
      await _saveTheme(themeMode);
    } catch (error) {
      debugPrint('Error saving theme: $error');

      emit(previousState);
    }
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode.toString());
  }
}
