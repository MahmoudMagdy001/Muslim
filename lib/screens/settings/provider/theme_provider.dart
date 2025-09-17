import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _initializeTheme();
  }
  static const String _themeKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _initializeTheme() async {
    try {
      await _loadTheme();
    } catch (error) {
      debugPrint('Error initializing theme: $error');
      // Fall back to default value but still notify listeners
      _themeMode = ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    final newThemeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newThemeMode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (themeMode == _themeMode) return;

    final previousThemeMode = _themeMode;
    _themeMode = themeMode;
    notifyListeners();

    try {
      await _saveTheme();
    } catch (error) {
      debugPrint('Error saving theme: $error');
      // Revert the change if saving fails
      _themeMode = previousThemeMode;
      notifyListeners();
    }
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeMode.toString());
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeText = prefs.getString(_themeKey);

    if (themeText != null) {
      if (themeText.contains('dark')) {
        _themeMode = ThemeMode.dark;
      } else if (themeText.contains('light')) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
      notifyListeners();
    }
  }
}
