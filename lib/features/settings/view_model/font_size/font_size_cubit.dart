import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State class
class FontSizeState {
  FontSizeState({required this.fontSize});
  final double fontSize;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FontSizeState &&
          runtimeType == other.runtimeType &&
          fontSize == other.fontSize;

  @override
  int get hashCode => fontSize.hashCode;
}

// Cubit class
class FontSizeCubit extends Cubit<FontSizeState> {
  FontSizeCubit(double initialFontSize)
    : super(FontSizeState(fontSize: initialFontSize));

  static const double _defaultFontSize = 16.0;
  static const String _fontSizeKey = 'fontSize';

  static Future<double> loadInitialFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_fontSizeKey) ?? _defaultFontSize;
  }

  Future<void> setFontSize(double value) async {
    if (value == state.fontSize) return;

    emit(FontSizeState(fontSize: value));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_fontSizeKey, value);
    } catch (error) {
      debugPrint('Error saving font size: $error');
    }
  }
}
