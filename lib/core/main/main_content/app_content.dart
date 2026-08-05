import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/service/in_app_rate.dart';
import 'package:muslim/core/service/in_app_update.dart';
import 'package:muslim/core/service/navigation_service.dart';
import 'package:muslim/core/theme/app_theme.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/layout/view/layout_view.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/quran/view/quran_view.dart';
import 'package:muslim/features/settings/view_model/font_size/font_size_cubit.dart';
import 'package:muslim/features/settings/view_model/language/language_cubit.dart';
import 'package:muslim/features/settings/view_model/language/language_state.dart';
import 'package:muslim/features/settings/view_model/theme/theme_cubit.dart';

class AppContent extends StatefulWidget {
  const AppContent({
    required this.localizationsDelegates,
    required this.supportedLocales,
    super.key,
  });

  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  StreamSubscription<bool>? _notificationClickSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(AppUpdateService.checkForUpdate(context));
      unawaited(RateAppHelper.handleAppLaunch(context));
      _setupNotificationClickChannel();
      _listenToNotificationClick();
      _checkPendingNotificationClick();
    });
  }

  @override
  void dispose() {
    // ponytail: cancel subscription to avoid stream leak
    unawaited(_notificationClickSubscription?.cancel());
    super.dispose();
  }

  void _checkPendingNotificationClick() {
    final quranService = getIt<QuranService>();
    if (quranService.hasPendingNotificationClick) {
      quranService.consumePendingNotificationClick();
      _handleDeepLink();
    }
  }

  void _setupNotificationClickChannel() {
    debugPrint('NotificationNav: Setting up notification click channel');
    const channel = MethodChannel('com.mahmoud.muslim/notification_click');
    // ignore: cascade_invocations
    channel.setMethodCallHandler((call) async {
      debugPrint('NotificationNav: Received method call: ${call.method}');
      if (call.method == 'onNotificationClick') {
        getIt<QuranService>().onNotificationClick();
      }
    });
  }

  void _listenToNotificationClick() {
    _notificationClickSubscription =
        getIt<QuranService>().notificationClickStream.listen((clicked) {
      debugPrint('NotificationNav: notificationClickStream received: $clicked');
      if (clicked) {
        _handleDeepLink();
      }
    });
  }

  void _handleDeepLink() {
    debugPrint('NotificationNav: Handling deep link');
    final quranService = getIt<QuranService>();
    final surah = quranService.currentSurah;
    final reciter = quranService.currentReciter;
    final ayah = quranService.audioPlayer.currentIndex != null
        ? quranService.audioPlayer.currentIndex! + 1
        : 1;

    debugPrint(
      'NotificationNav: Surah: $surah, Reciter: $reciter, Ayah: $ayah',
    );

    if (surah != null && reciter != null) {
      debugPrint('NotificationNav: Navigating to QuranView');
      unawaited(
        navigateWithTransition<void>(
          navigatorKey.currentContext!,
          QuranView(surahNumber: surah, reciter: reciter, currentAyah: ayah),
          type: TransitionType.fade,
        ),
      );
    } else {
      debugPrint('NotificationNav: Surah or Reciter is NULL, cannot navigate');
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) => BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, fontSizeState) =>
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) => ScreenUtilInit(
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                final fontSize = fontSizeState.fontSize;
                final themeFactory = AppThemeFactory(fontSize);
                final lightTheme = themeFactory.lightTheme;
                final darkTheme = themeFactory.darkTheme;

                return MaterialApp(
                  themeAnimationStyle: const AnimationStyle(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                    reverseCurve: Curves.easeOut,
                    reverseDuration: Duration(milliseconds: 500),
                  ),
                  debugShowCheckedModeBanner: false,
                  themeMode: themeState.themeMode,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  locale: languageState.locale,
                  localizationsDelegates: widget.localizationsDelegates,
                  supportedLocales: widget.supportedLocales,
                  navigatorKey: navigatorKey,
                  home: const LayoutView(),
                );
              },
            ),
          ),
    ),
  );
}
