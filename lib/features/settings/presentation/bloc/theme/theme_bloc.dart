import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/settings/presentation/bloc/theme/theme_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'theme_event.dart';

part 'theme_bloc.freezed.dart';

// State class
@freezed
abstract class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState({required ThemeMode themeMode}) = _ThemeState;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

// Bloc class
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc([ThemeMode initialMode = ThemeMode.system])
    : super(ThemeState(themeMode: initialMode)) {
    on<ThemeToggleTheme>(_onToggleTheme);
    on<ThemeSetThemeMode>(_onSetThemeMode);
  }

  static const String _themeKey = 'themeMode';

  Future<void> _onToggleTheme(
    ThemeToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final newThemeMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _handleSetThemeMode(newThemeMode, emit);
  }

  Future<void> _onSetThemeMode(
    ThemeSetThemeMode event,
    Emitter<ThemeState> emit,
  ) async {
    await _handleSetThemeMode(event.themeMode, emit);
  }

  Future<void> _handleSetThemeMode(
    ThemeMode themeMode,
    Emitter<ThemeState> emit,
  ) async {
    if (themeMode == state.themeMode) return;

    final previousState = state;
    emit(ThemeState(themeMode: themeMode));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeMode.toString());
    } on Object catch (error) {
      debugPrint('Error saving theme: $error');
      emit(previousState);
    }
  }

  // Convenience methods
  Future<void> toggleTheme() async => add(const ThemeEvent.toggleTheme());
  Future<void> setThemeMode(ThemeMode themeMode) async =>
      add(ThemeEvent.setThemeMode(themeMode));
}
