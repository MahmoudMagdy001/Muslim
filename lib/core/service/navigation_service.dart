import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?>? push<T>(Route<T> route) =>
      navigatorKey.currentState?.push(route);

  static void pop<T>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}
