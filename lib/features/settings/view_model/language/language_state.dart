import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LanguageState extends Equatable {
  const LanguageState(this.locale);
  final Locale locale;

  @override
  List<Object?> get props => [locale];
}
