import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/service_locator.dart';
import 'core/main/main_content/app_content.dart';
import 'core/main/main_content/app_initializer.dart';
import 'core/service/periodic_reminder_channel_factory.dart';
import 'features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'features/prayer_times/presentation/helper/notification_channel_factory.dart';
import 'features/prayer_times/presentation/helper/notification_constants.dart';
import 'features/quran/service/bookmarks_service.dart';
import 'features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'features/settings/view_model/font_size/font_size_cubit.dart';
import 'features/settings/view_model/language/language_cubit.dart';
import 'features/settings/view_model/periodic_reminder/periodic_reminder_cubit.dart';
import 'features/settings/view_model/rectire/rectire_cubit.dart';
import 'features/settings/view_model/theme/theme_cubit.dart';
import 'l10n/app_localizations.dart';

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

  runApp(
    InternetStateManagerInitializer(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PrayerTimesCubit()),
          BlocProvider(create: (_) => FontSizeCubit(initialFontSize)),
          BlocProvider(create: (_) => ThemeCubit(initialMode)),
          BlocProvider(create: (_) => ReciterCubit()),
          BlocProvider(
            create: (_) => BookmarksCubit(getIt<BookmarksService>()),
          ),
          BlocProvider(create: (_) => LanguageCubit(initialLocale)),
          BlocProvider(create: (_) => getIt<PeriodicReminderCubit>()),
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

      final initializer = AppInitializer(prefs);
      await initializer.initialize();
    } catch (e) {
      debugPrint('Background initialization error: $e');
    }
  });
}

Future<void> _initializeNotificationChannels() async {
  try {
    await AwesomeNotifications()
        .initialize(NotificationConstants.notificationIcon, [
          NotificationChannel(
            channelKey: 'quran_channel',
            channelName: 'Quran Reminders',
            channelDescription: 'Reminders to read Quran',
            defaultColor: const Color(0xFF33A1E0),
            importance: NotificationImportance.High,
            channelShowBadge: true,
            icon: NotificationConstants.notificationIcon,
          ),
          createPrayerChannel(),
          createPeriodicReminderChannel(),
        ]);
  } catch (e) {
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
