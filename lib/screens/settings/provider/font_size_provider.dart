import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {
  FontSizeProvider() {
    _initializeFontSize();
  }
  static const double _defaultFontSize = 16.0;
  static const String _fontSizeKey = 'fontSize';

  double _fontSize = _defaultFontSize;
  double get fontSize => _fontSize;

  Future<void> _initializeFontSize() async {
    try {
      await _loadFontSize();
    } catch (error) {
      debugPrint('Error initializing font size: $error');
      // Fall back to default value but still notify listeners
      _fontSize = _defaultFontSize;
      notifyListeners();
    }
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFontSize = prefs.getDouble(_fontSizeKey);

    if (savedFontSize != null) {
      _fontSize = savedFontSize;
    } else {
      _fontSize = _defaultFontSize;
    }
    notifyListeners();
  }

  Future<void> setFontSize(double value) async {
    if (value == _fontSize) return;

    _fontSize = value;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_fontSizeKey, value);
    } catch (error) {
      debugPrint('Error saving font size: $error');
      // Revert the change if saving fails
      await _loadFontSize();
    }
  }
}
