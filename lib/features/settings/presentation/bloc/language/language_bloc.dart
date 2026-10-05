import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/language/language_event.dart';
import 'package:muslim/features/settings/presentation/bloc/language/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc([Locale initialLocale = const Locale('ar')])
    : super(LanguageState(initialLocale)) {
    on<LanguageChangeLanguage>(_onChangeLanguage);
  }

  static const _key = 'appLanguage';

  /// تحميل اللغة المخزنة
  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'en';
    return Locale(langCode);
  }

  Future<void> _onChangeLanguage(
    LanguageChangeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageState(event.newLocale));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, event.newLocale.languageCode);
  }

  /// تغيير اللغة وتخزينها
  Future<void> changeLanguage(Locale newLocale) async =>
      add(LanguageEvent.changeLanguage(newLocale));
}
