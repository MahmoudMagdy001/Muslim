import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.freezed.dart';

@freezed
sealed class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.toggleTheme() = ThemeToggleTheme;
  const factory ThemeEvent.setThemeMode(ThemeMode themeMode) = ThemeSetThemeMode;
}
