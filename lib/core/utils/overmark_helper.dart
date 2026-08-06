import 'dart:async';
import 'package:flutter/material.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:overmark/overmark.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ponytail: Simple SharedPreferences adapter for Overmark persistent tour storage.
class PrefsOvermarkStorage implements OvermarkStorage {
  @override
  Future<bool> hasShown(String tourId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tour_$tourId') ?? false;
  }

  @override
  Future<void> markShown(String tourId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tour_$tourId', true);
  }
}

class AppTourKeys {
  // Home keys
  static final GlobalKey settingsKey = GlobalKey();
  static final GlobalKey prayerTimesKey = GlobalKey();
  static final GlobalKey zakatKey = GlobalKey();
  static final GlobalKey servicesKey = GlobalKey();

  // Quran keys
  static final GlobalKey quranBookmarksKey = GlobalKey();
  static final GlobalKey quranTabKey = GlobalKey();

  // Hadith keys
  static final GlobalKey hadithSavedKey = GlobalKey();
  static final GlobalKey hadithSearchKey = GlobalKey();

  // Sebha keys
  static final GlobalKey sebhaAddKey = GlobalKey();
  static final GlobalKey sebhaButtonKey = GlobalKey();

  // Azkar & Names of Allah
  static final GlobalKey azkarTitleKey = GlobalKey();
  static final GlobalKey namesSearchKey = GlobalKey();

  // Qiblah
  static final GlobalKey qiblahCompassKey = GlobalKey();
}

class AppTourHelper {
  static const String homeTourId = 'home_app_tour_v1';
  static const String quranTourId = 'quran_app_tour_v1';
  static const String hadithTourId = 'hadith_app_tour_v1';
  static const String sebhaTourId = 'sebha_app_tour_v1';
  static const String azkarTourId = 'azkar_app_tour_v1';
  static const String namesTourId = 'names_app_tour_v1';
  static const String qiblahTourId = 'qiblah_app_tour_v1';

  static OvermarkLabels _getLabels(AppLocalizations l10n) => OvermarkLabels(
        next: l10n.tourNext,
        skip: l10n.tourSkip,
        done: l10n.tourDone,
      );

  static OvermarkTheme _getTheme(BuildContext context) {
    final theme = Theme.of(context);
    return OvermarkTheme(
      buttonColor: theme.colorScheme.primary,
      spotlightBorderColor: theme.colorScheme.primary,
    );
  }

  static Future<void> _runTour(
    BuildContext context, {
    required String tourId,
    required List<OvermarkStep> steps,
    bool force = false,
  }) async {
    // ponytail: Wait for page route transition animation to finish before showing coach marks.
    final route = ModalRoute.of(context);
    if (route != null && route.animation != null) {
      final animation = route.animation!;
      if (!animation.isCompleted) {
        final completer = Completer<void>();
        void statusListener(AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            animation.removeStatusListener(statusListener);
            if (!completer.isCompleted) {
              completer.complete();
            }
          }
        }

        animation.addStatusListener(statusListener);
        await completer.future;
      }
    }

    // Small delay to ensure widget layout is settled
    await Future<void>.delayed(const Duration(milliseconds: 100));

    if (!context.mounted) return;

    final validSteps = steps
        .where((step) => step.anchorKey.currentContext != null)
        .toList();

    if (validSteps.isEmpty) return;

    final l10n = AppLocalizations.of(context);
    final labels = _getLabels(l10n);
    final theme = _getTheme(context);

    if (force) {
      await Overmark.show(
        context,
        steps: validSteps,
        labels: labels,
        theme: theme,
      );
    } else {
      await Overmark.showOnce(
        context,
        tourId: tourId,
        storage: PrefsOvermarkStorage(),
        steps: validSteps,
        labels: labels,
        theme: theme,
      );
    }
  }

  static Future<void> showHomeTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.prayerTimesKey,
        title: l10n.tourPrayerTimesTitle,
        message: l10n.tourPrayerTimesMessage,
      ),
      OvermarkStep(
        anchorKey: AppTourKeys.zakatKey,
        title: l10n.tourZakatTitle,
        message: l10n.tourZakatMessage,
      ),
      OvermarkStep(
        anchorKey: AppTourKeys.servicesKey,
        title: l10n.tourServicesTitle,
        message: l10n.tourServicesMessage,
      ),
      OvermarkStep(
        anchorKey: AppTourKeys.settingsKey,
        title: l10n.tourSettingsTitle,
        message: l10n.tourSettingsMessage,
      ),
    ];

    await _runTour(
      context,
      tourId: homeTourId,
      steps: steps,
      force: force,
    );
  }

  static Future<void> showQuranTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.quranTabKey,
        title: l10n.tourQuranTitle,
        message: l10n.tourQuranMessage,
      ),
      OvermarkStep(
        anchorKey: AppTourKeys.quranBookmarksKey,
        title: l10n.tourBookmarksTitle,
        message: l10n.tourBookmarksMessage,
      ),
    ];

    await _runTour(
      context,
      tourId: quranTourId,
      steps: steps,
      force: force,
    );
  }

  static Future<void> showHadithTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.hadithSearchKey,
        title: l10n.tourHadithTitle,
        message: l10n.tourHadithMessage,
      ),
      OvermarkStep(
        anchorKey: AppTourKeys.hadithSavedKey,
        title: l10n.tourSavedHadithTitle,
        message: l10n.tourSavedHadithMessage,
      ),
    ];

    await _runTour(
      context,
      tourId: hadithTourId,
      steps: steps,
      force: force,
    );
  }

  static Future<void> showSebhaTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.sebhaAddKey,
        title: l10n.tourAddZikrTitle,
        message: l10n.tourAddZikrMessage,
      ),
      OvermarkStep(
        anchorKey: AppTourKeys.sebhaButtonKey,
        title: l10n.tourSebhaTitle,
        message: l10n.tourSebhaMessage,
        shape: OvermarkShape.circle,
      ),
    ];

    await _runTour(
      context,
      tourId: sebhaTourId,
      steps: steps,
      force: force,
    );
  }

  static Future<void> showAzkarTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.azkarTitleKey,
        title: l10n.tourAzkarTitle,
        message: l10n.tourAzkarMessage,
      ),
    ];

    await _runTour(
      context,
      tourId: azkarTourId,
      steps: steps,
      force: force,
    );
  }

  static Future<void> showNamesOfAllahTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.namesSearchKey,
        title: l10n.tourNamesOfAllahTitle,
        message: l10n.tourNamesOfAllahMessage,
      ),
    ];

    await _runTour(
      context,
      tourId: namesTourId,
      steps: steps,
      force: force,
    );
  }

  static Future<void> showQiblahTour(
    BuildContext context, {
    bool force = false,
  }) async {
    final l10n = AppLocalizations.of(context);

    final steps = <OvermarkStep>[
      OvermarkStep(
        anchorKey: AppTourKeys.qiblahCompassKey,
        title: l10n.tourQiblahTitle,
        message: l10n.tourQiblahMessage,
      ),
    ];

    await _runTour(
      context,
      tourId: qiblahTourId,
      steps: steps,
      force: force,
    );
  }
}
