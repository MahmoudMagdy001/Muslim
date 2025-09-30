import 'package:flutter/material.dart';

enum TransitionType { slideFromBottom, fade, scale }

Future<T?> navigateWithTransition<T>(
  BuildContext context,
  Widget page, {
  TransitionType type = TransitionType.slideFromBottom,
  Duration duration = const Duration(milliseconds: 700),
}) => Navigator.of(context).push<T>(
  PageRouteBuilder(
    transitionDuration: duration,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.scale:
          return ScaleTransition(scale: animation, child: child);
        case TransitionType.slideFromBottom:
          final tween = Tween(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
      }
    },
  ),
);
