import 'package:flutter/material.dart';

enum TransitionType { slideFromBottom, fade, scale }

mixin _TransitionBuilders {
  static Widget fade(Animation<double> animation, Widget child) =>
      FadeTransition(opacity: animation, child: child);

  static Widget scale(Animation<double> animation, Widget child) =>
      ScaleTransition(scale: animation, child: child);

  static Widget slideFromBottom(Animation<double> animation, Widget child) {
    // Predefined static tween — avoids recreation
    final tween = Tween(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.ease));
    return SlideTransition(position: animation.drive(tween), child: child);
  }
}

Future<T?> navigateWithTransition<T>(
  BuildContext context,
  Widget page, {
  TransitionType type = TransitionType.slideFromBottom,
  Duration duration = const Duration(milliseconds: 700),
}) => Navigator.of(context).push<T>(
  PageRouteBuilder(
    transitionDuration: duration,
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, animation, _, child) {
      switch (type) {
        case TransitionType.fade:
          return _TransitionBuilders.fade(animation, child);
        case TransitionType.scale:
          return _TransitionBuilders.scale(animation, child);
        case TransitionType.slideFromBottom:
          return _TransitionBuilders.slideFromBottom(animation, child);
      }
    },
  ),
);
