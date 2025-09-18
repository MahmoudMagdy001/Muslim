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
  FontSizeCubit() : super(FontSizeState(fontSize: _defaultFontSize)) {
    _initializeFontSize();
  }
  static const double _defaultFontSize = 16.0;
  static const String _fontSizeKey = 'fontSize';

  Future<void> _initializeFontSize() async {
    try {
      await _loadFontSize();
    } catch (error) {
      debugPrint('Error initializing font size: $error');
      emit(FontSizeState(fontSize: _defaultFontSize));
    }
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFontSize = prefs.getDouble(_fontSizeKey);

    if (savedFontSize != null) {
      emit(FontSizeState(fontSize: savedFontSize));
    } else {
      emit(FontSizeState(fontSize: _defaultFontSize));
    }
  }

  Future<void> setFontSize(double value) async {
    if (value == state.fontSize) return;

    emit(FontSizeState(fontSize: value));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_fontSizeKey, value);
    } catch (error) {
      debugPrint('Error saving font size: $error');
      await _loadFontSize();
    }
  }
}
