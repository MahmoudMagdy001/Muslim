import 'package:flutter/foundation.dart';

/// Simple logging abstraction wrapping [debugPrint].
///
/// Provides consistent log levels and formatting throughout the app.
/// Can be swapped for a more sophisticated logger (e.g. `logger` package)
/// without changing call sites.
abstract final class AppLogger {
  static void info(String message) => debugPrint('ℹ️ $message');

  static void success(String message) => debugPrint('✅ $message');

  static void warning(String message) => debugPrint('⚠️ $message');

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('❌ $message');
    if (error != null) debugPrint('   Error: $error');
    if (stackTrace != null) debugPrint('   $stackTrace');
  }
}
