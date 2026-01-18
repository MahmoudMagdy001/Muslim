import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class AppStyles {
  const AppStyles._();

  static TextStyle titleBold(BuildContext context) => TextStyle(
    fontSize: 22.toSp,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.primary,
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontSize: 16.toSp,
    color: Theme.of(context).textTheme.bodyMedium?.color,
  );

  static final BorderRadius cardRadius = BorderRadius.circular(15.toR);
  static final EdgeInsets screenPadding = EdgeInsets.all(16.toR);
}
