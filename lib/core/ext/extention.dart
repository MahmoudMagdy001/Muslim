import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  /// الوصول إلى الترجمة بسهولة
  AppLocalizations get localization => AppLocalizations.of(this);

  /// للوصول إلى الثيم
  ThemeData get theme => Theme.of(this);
}

// enums/display_mode.dart
enum DisplayMode {
  horizontal, // الطريقة القديمة
  vertical, // كل آية في سطر
}
