import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/settings/presentation/bloc/font_size/font_size_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'font_size_event.dart';

part 'font_size_bloc.freezed.dart';

// State class
@freezed
abstract class FontSizeState with _$FontSizeState {
  const factory FontSizeState({required double fontSize}) = _FontSizeState;
}

// Bloc class
class FontSizeBloc extends Bloc<FontSizeEvent, FontSizeState> {
  FontSizeBloc([double initialFontSize = _defaultFontSize])
    : super(FontSizeState(fontSize: initialFontSize)) {
    on<FontSizeSetFontSize>(_onSetFontSize);
  }

  static const double _defaultFontSize = 18.0;
  static const String _fontSizeKey = 'fontSize';

  static Future<double> loadInitialFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_fontSizeKey) ?? _defaultFontSize;
  }

  Future<void> _onSetFontSize(
    FontSizeSetFontSize event,
    Emitter<FontSizeState> emit,
  ) async {
    if (event.value == state.fontSize) return;

    emit(FontSizeState(fontSize: event.value));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_fontSizeKey, event.value);
    } on Object catch (error) {
      debugPrint('Error saving font size: $error');
    }
  }

  // Convenience method
  Future<void> setFontSize(double value) async =>
      add(FontSizeEvent.setFontSize(value));
}
