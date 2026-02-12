import 'package:flutter/foundation.dart';

/// Simple logging abstraction wrapping [debugPrint].
///
/// Provides consistent log levels and formatting throughout the app.
/// Can be swapped for a more sophisticated logger (e.g. `logger` package)
/// without changing call sites.
void logInfo(String message) => debugPrint('ℹ️ $message');

void logSuccess(String message) => debugPrint('✅ $message');

void logWarning(String message) => debugPrint('⚠️ $message');

void logError(String message, [Object? error, StackTrace? stackTrace]) {
  debugPrint('❌ $message');
  if (error != null) debugPrint('   Error: $error');
  if (stackTrace != null) debugPrint('   $stackTrace');
}
