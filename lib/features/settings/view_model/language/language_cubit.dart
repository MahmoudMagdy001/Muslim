import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale initialLocale) : super(LanguageState(initialLocale));

  static const _key = 'appLanguage';

  /// تحميل اللغة المخزنة
  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'en';
    return Locale(langCode);
  }

  /// تغيير اللغة وتخزينها
  Future<void> changeLanguage(Locale newLocale) async {
    emit(LanguageState(newLocale));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newLocale.languageCode);
  }
}
