#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class com.google.firebase.** { *; } # If using Firebase

# Retain generic type information for use by reflection by converters and serialization
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod

# Default flutter proguard rules
# https://github.com/flutter/flutter/wiki/Obfuscating-Dart-Code
-keep class io.flutter.embedding.engine.FlutterJNI { *; }

# Suppress warnings for Play Store classes (deferred components)
# Generated from missing_rules.txt
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# Awesome Notifications
-keep class me.carda.awesome_notifications.** { *; }
-keep enum me.carda.awesome_notifications.enumerators.** { *; }

# WorkManager - Critical for periodic reminders in release mode
-keep class androidx.work.** { *; }
-keep class androidx.work.impl.** { *; }
-keep class androidx.work.impl.background.systemjob.** { *; }
-keep class androidx.work.impl.utils.** { *; }
-keep class dev.fluttercommunity.workmanager.** { *; }
-dontwarn androidx.work.**

# Keep WorkManager callback dispatcher
-keepattributes *Annotation*
-keepclassmembers class * {
  @io.flutter.embedding.engine.dart.DartExecutor$DartEntrypoint <methods>;
}

# Keep plugin registrant for background execution
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
-keep class io.flutter.embedding.engine.plugins.PluginRegistry { *; }

# Keep Dart/Flutter entry points for background execution
-keepattributes *Annotation*
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations

# Keep all classes that might be entry points for background tasks
-keep class com.mahmoud.muslim.** { *; }

# SharedPreferences and other critical background services
-keep class android.content.SharedPreferences { *; }
-keep class androidx.core.app.NotificationManagerCompat { *; }
