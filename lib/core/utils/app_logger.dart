// ponytail: minimal log functions directly calling debugPrint
import 'package:flutter/foundation.dart';

void logInfo(String message) => debugPrint('ℹ️ $message');
void logSuccess(String message) => debugPrint('✅ $message');
void logWarning(String message) => debugPrint('⚠️ $message');
void logError(String message, [Object? error, StackTrace? stackTrace]) {
  debugPrint('❌ $message${error != null ? ' | $error' : ''}');
}
