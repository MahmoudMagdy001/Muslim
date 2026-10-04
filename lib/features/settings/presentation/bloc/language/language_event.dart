import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_event.freezed.dart';

@freezed
sealed class LanguageEvent with _$LanguageEvent {
  const factory LanguageEvent.changeLanguage(Locale newLocale) = LanguageChangeLanguage;
}
