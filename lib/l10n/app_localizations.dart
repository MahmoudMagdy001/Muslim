import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @azkarCategoryList.
  ///
  /// In en, this message translates to:
  /// **'List of Azkar Categories'**
  String get azkarCategoryList;

  /// No description provided for @azkarLoadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading Azkar...'**
  String get azkarLoadingText;

  /// No description provided for @azkarError.
  ///
  /// In en, this message translates to:
  /// **'No Azkar available at the moment'**
  String get azkarError;

  /// No description provided for @azkar.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// No description provided for @revision.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get revision;

  /// No description provided for @tasbih.
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get tasbih;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @hadithBooks.
  ///
  /// In en, this message translates to:
  /// **'Hadith Books'**
  String get hadithBooks;

  /// No description provided for @hadithBooksError.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch books'**
  String get hadithBooksError;

  /// No description provided for @hadithBooksSearch.
  ///
  /// In en, this message translates to:
  /// **'Search by book name...'**
  String get hadithBooksSearch;

  /// No description provided for @hadithBooksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No books available'**
  String get hadithBooksEmpty;

  /// No description provided for @writer.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get writer;

  /// No description provided for @numberOfChapters.
  ///
  /// In en, this message translates to:
  /// **'Number of Chapters:'**
  String get numberOfChapters;

  /// No description provided for @numberOfHadiths.
  ///
  /// In en, this message translates to:
  /// **'Number of Hadiths:'**
  String get numberOfHadiths;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @errorMain.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get errorMain;

  /// No description provided for @chaptersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No chapters available'**
  String get chaptersEmpty;

  /// No description provided for @chaptersSearch.
  ///
  /// In en, this message translates to:
  /// **'Search for a chapter...'**
  String get chaptersSearch;

  /// No description provided for @hadithError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load Hadiths'**
  String get hadithError;

  /// No description provided for @hadithstitle.
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get hadithstitle;

  /// No description provided for @hadithStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get hadithStatus;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
