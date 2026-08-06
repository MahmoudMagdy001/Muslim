import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/main/main_content/app_content.dart';
import 'package:muslim/core/main/main_content/app_initializer.dart';
import 'package:muslim/core/service/navigation_service.dart';
import 'package:muslim/core/service/periodic_reminder_channel_factory.dart';
import 'package:muslim/core/service/permissions_sevice.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_channel_factory.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_constants.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:muslim/features/settings/view_model/font_size/font_size_cubit.dart';
import 'package:muslim/features/settings/view_model/language/language_cubit.dart';
import 'package:muslim/features/settings/view_model/rectire/rectire_cubit.dart';
import 'package:muslim/features/settings/view_model/theme/theme_cubit.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Phase 1: Critical initialization only - must complete before runApp
  await setupServiceLocator();
  await InternetStateManagerInitializer.initialize();

  // Initialize notification channels early (required before any notification scheduling)
  await _initializeNotificationChannels();

  // Get cached preferences for immediate theme/language
  final prefs = await SharedPreferences.getInstance();
  final initialLocale = _getLocaleFromPrefs(prefs);
  final initialMode = _getThemeFromPrefs(prefs);
  final initialFontSize = prefs.getDouble('fontSize') ?? 18.0;

  // ponytail: check location permission status without showing a blocking prompt
  final locationGranted = await isLocationPermissionGranted();

  runApp(
    InternetStateManagerInitializer(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<PrayerTimesCubit>()..locationGranted = locationGranted),
          BlocProvider(create: (_) {
            final cubit = getIt<FontSizeCubit>();
            unawaited(cubit.setFontSize(initialFontSize));
            return cubit;
          }),
          BlocProvider(create: (_) {
            final cubit = getIt<ThemeCubit>();
            unawaited(cubit.setThemeMode(initialMode));
            return cubit;
          }),
          BlocProvider(create: (_) {
            final cubit = getIt<LanguageCubit>();
            unawaited(cubit.changeLanguage(initialLocale));
            return cubit;
          }),
          BlocProvider(create: (_) => getIt<ReciterCubit>()),
          BlocProvider(create: (_) => getIt<BookmarksCubit>()),
        ],
        child: const AppContent(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    ),
  );

  // Phase 2: Non-critical initialization after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      // ponytail: request permissions asynchronously post-frame so it doesn't block splash/startup
      final newlyGranted = await requestAllPermissions();

      // ponytail: if location is newly granted, trigger refresh on cubit
      final navContext = navigatorKey.currentContext;
      if (navContext != null && navContext.mounted && newlyGranted) {
        unawaited(navContext.read<PrayerTimesCubit>().refreshPrayerTimes());
      }

      final initializer = AppInitializer(prefs);
      await initializer.initialize();
    } on Object catch (e) {
      debugPrint('Background initialization error: $e');
    }
  });
}

Future<void> _initializeNotificationChannels() async {
  try {
    await AwesomeNotifications().initialize(NotificationConstants.notificationIcon, [
      NotificationChannel(
        channelKey: NotificationConstants.quranChannelKey,
        channelName: NotificationConstants.quranChannelName,
        channelDescription: NotificationConstants.quranChannelDescription,
        defaultColor: NotificationConstants.quranChannelColor,
        ledColor: NotificationConstants.ledColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        icon: NotificationConstants.notificationIcon,
      ),
      createPrayerChannel(),
      createPeriodicReminderChannel(),
    ]);
  } on Object catch (e) {
    debugPrint('Error initializing notification channels: $e');
  }
}

Locale _getLocaleFromPrefs(SharedPreferences prefs) {
  final langCode = prefs.getString('appLanguage') ?? 'ar';
  return Locale(langCode);
}

ThemeMode _getThemeFromPrefs(SharedPreferences prefs) {
  final themeText = prefs.getString('themeMode');
  if (themeText?.contains('dark') ?? false) {
    return ThemeMode.dark;
  } else if (themeText?.contains('light') ?? false) {
    return ThemeMode.light;
  }
  return ThemeMode.system;
}
