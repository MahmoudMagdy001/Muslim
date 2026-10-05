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
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_bloc.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_channel_factory.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_constants.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/font_size/font_size_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/language/language_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/reciter/reciter_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/theme/theme_bloc.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // === Phase 1: Critical only — must complete before runApp ===
  // DI registration (all lazy singletons/factories, effectively sync)
  await setupServiceLocator();
  // Required by InternetStateManagerInitializer widget constructor
  await InternetStateManagerInitializer.initialize();
  // Initialize notification channels before runApp to prevent scheduling race conditions
  await _initializeNotificationChannels();
  // Cached preferences for immediate theme/language/font
  final prefs = await SharedPreferences.getInstance();
  final initialLocale = _getLocaleFromPrefs(prefs);
  final initialMode = _getThemeFromPrefs(prefs);
  final initialFontSize = prefs.getDouble('fontSize') ?? 18.0;
  final locationGranted = await isLocationPermissionGranted();

  // === runApp — show UI as fast as possible ===
  runApp(
    InternetStateManagerInitializer(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<PrayerTimesBloc>()..locationGranted = locationGranted,
          ),
          BlocProvider(create: (_) {
            final bloc = getIt<FontSizeBloc>();
            unawaited(bloc.setFontSize(initialFontSize));
            return bloc;
          }),
          BlocProvider(create: (_) {
            final bloc = getIt<ThemeBloc>();
            unawaited(bloc.setThemeMode(initialMode));
            return bloc;
          }),
          BlocProvider(create: (_) {
            final bloc = getIt<LanguageBloc>();
            unawaited(bloc.changeLanguage(initialLocale));
            return bloc;
          }),
          BlocProvider(create: (_) => getIt<ReciterBloc>()),
          BlocProvider(create: (_) => getIt<BookmarksBloc>()),
        ],
        child: const AppContent(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    ),
  );

  // === Phase 2: Non-critical — after first frame renders ===
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      // Request permissions asynchronously post-frame if not already granted
      final isLocationGrantedNow = await requestAllPermissions();

      // Only refresh prayer times if location permission was NOT granted initially,
      // but was newly granted after user interaction in this session.
      if (isLocationGrantedNow && !locationGranted) {
        final navContext = navigatorKey.currentContext;
        if (navContext != null && navContext.mounted) {
          unawaited(navContext.read<PrayerTimesBloc>().refreshPrayerTimes());
        }
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
