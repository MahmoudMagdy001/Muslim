import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);
}
