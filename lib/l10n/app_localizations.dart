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

  /// Title for Azkar category list screen
  ///
  /// In en, this message translates to:
  /// **'List of Azkar Categories'**
  String get azkarCategoryList;

  /// Loading message for Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Loading Azkar...'**
  String get azkarLoadingText;

  /// Error message when no Azkar are available
  ///
  /// In en, this message translates to:
  /// **'No Azkar available at the moment'**
  String get azkarError;

  /// Title text for Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// Label for reference section
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get revision;

  /// Title for Tasbih section
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get tasbih;

  /// Label for reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Title for Hadith books list
  ///
  /// In en, this message translates to:
  /// **'Hadith Books'**
  String get hadithBooks;

  /// Error message when Hadith books fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch books'**
  String get hadithBooksError;

  /// Search hint for Hadith books list
  ///
  /// In en, this message translates to:
  /// **'Search by book name...'**
  String get hadithBooksSearch;

  /// Message shown when no Hadith books are available
  ///
  /// In en, this message translates to:
  /// **'No books available'**
  String get hadithBooksEmpty;

  /// Label for book author
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get writer;

  /// Label showing number of chapters in a book
  ///
  /// In en, this message translates to:
  /// **'Number of Chapters:'**
  String get numberOfChapters;

  /// Label showing number of Hadiths in a book
  ///
  /// In en, this message translates to:
  /// **'Number of Hadiths:'**
  String get numberOfHadiths;

  /// Title for chapters list
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// Generic error prefix text
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get errorMain;

  /// Message shown when no chapters are available
  ///
  /// In en, this message translates to:
  /// **'No chapters available'**
  String get chaptersEmpty;

  /// Search placeholder for chapters list
  ///
  /// In en, this message translates to:
  /// **'Search for a chapter...'**
  String get chaptersSearch;

  /// Error message when Hadiths fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load Hadiths'**
  String get hadithError;

  /// Title for Hadiths list
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get hadithstitle;

  /// Label for Hadith status (authenticity)
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
