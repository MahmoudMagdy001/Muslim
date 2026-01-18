import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/layout/view/layout_view.dart';
import '../../../features/settings/view_model/theme/theme_cubit.dart';
import '../../../features/settings/view_model/font_size/font_size_cubit.dart';
import '../../service/in_app_rate.dart';
import '../../service/in_app_update.dart';
import '../../theme/app_theme.dart';
import '../../../features/settings/view_model/language/language_cubit.dart';
import '../../../features/settings/view_model/language/language_state.dart';
import '../../../features/quran/service/quran_service.dart';
import '../../../features/quran/view/quran_view.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../di/service_locator.dart';
import 'package:flutter/services.dart';
import '../../service/navigation_service.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUpdateService.checkForUpdate(context);
      RateAppHelper.handleAppLaunch(context);
      _setupNotificationClickChannel();
      _listenToNotificationClick();
      _checkPendingNotificationClick();
    });
  }

  void _checkPendingNotificationClick() {
    final quranService = getIt<QuranService>();
    if (quranService.hasPendingNotificationClick) {
      quranService.consumePendingNotificationClick();
      _handleDeepLink();
    }
  }

  void _setupNotificationClickChannel() {
    print('NotificationNav: Setting up notification click channel');
    const channel = MethodChannel('com.mahmoud.muslim/notification_click');
    channel.setMethodCallHandler((call) async {
      print('NotificationNav: Received method call: ${call.method}');
      if (call.method == 'onNotificationClick') {
        getIt<QuranService>().onNotificationClick();
      }
    });
  }

  void _listenToNotificationClick() {
    getIt<QuranService>().notificationClickStream.listen((bool clicked) {
      print('NotificationNav: notificationClickStream received: $clicked');
      if (clicked) {
        _handleDeepLink();
      }
    });
  }

  void _handleDeepLink() {
    print('NotificationNav: Handling deep link');
    final quranService = getIt<QuranService>();
    final surah = quranService.currentSurah;
    final reciter = quranService.currentReciter;
    final ayah = quranService.audioPlayer.currentIndex != null
        ? quranService.audioPlayer.currentIndex! + 1
        : 1;

    print('NotificationNav: Surah: $surah, Reciter: $reciter, Ayah: $ayah');

    if (surah != null && reciter != null) {
      print('NotificationNav: Navigating to QuranView');
      navigateWithTransition(
        NavigationService.context!,
        QuranView(surahNumber: surah, reciter: reciter, currentAyah: ayah),
        type: TransitionType.fade,
      );
    } else {
      print('NotificationNav: Surah or Reciter is NULL, cannot navigate');
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
                  navigatorKey: NavigationService.navigatorKey,
                  home: const LayoutView(),
                );
              },
            ),
          ),
    ),
  );
}
