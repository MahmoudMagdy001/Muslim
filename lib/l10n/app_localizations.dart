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

  /// The main application name displayed in the interface
  ///
  /// In en, this message translates to:
  /// **'Musallem'**
  String get appName;

  /// Button to navigate to the Holy Quran screen
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quranButton;

  /// Button to navigate to the Hadith screen
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadithButton;

  /// Button to navigate to the Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkarButton;

  /// Button to navigate to the Qiblah direction screen
  ///
  /// In en, this message translates to:
  /// **'Qiblah'**
  String get qiblahButton;

  /// Button to navigate to the app settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsButton;

  /// Title for the Zakat section in the app
  ///
  /// In en, this message translates to:
  /// **'My Zakat'**
  String get zakat;

  /// Prophetic saying displayed on the Zakat screen
  ///
  /// In en, this message translates to:
  /// **'The Prophet ﷺ said: Charity does not decrease wealth.'**
  String get zakatDuaa;

  /// Motivational text encouraging users to start calculating their Zakat
  ///
  /// In en, this message translates to:
  /// **'Start calculating your Zakat now and remember its great virtue.'**
  String get zakatStart;

  /// Title for the Names of Allah screen
  ///
  /// In en, this message translates to:
  /// **'Names of Allah'**
  String get namesOfAllah;

  /// Title for the digital Sebha screen
  ///
  /// In en, this message translates to:
  /// **'Sebha'**
  String get sebha;

  /// Title for the Tasbih section in the Sebha screen
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get tasbih;

  /// Button to reset the counter in the Sebha
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Title for the general Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// Title for the Azkar category list screen
  ///
  /// In en, this message translates to:
  /// **'Azkar Categories'**
  String get azkarCategoryList;

  /// Text displayed while Azkar data is loading
  ///
  /// In en, this message translates to:
  /// **'Loading Azkar...'**
  String get azkarLoadingText;

  /// Error message when no Azkar are available
  ///
  /// In en, this message translates to:
  /// **'No Azkar available at the moment'**
  String get azkarError;

  /// Title for the Hadith books list screen
  ///
  /// In en, this message translates to:
  /// **'Hadith Books'**
  String get hadithBooks;

  /// Error message when fetching Hadith books fails
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch books'**
  String get hadithBooksError;

  /// Search hint text in the Hadith books list
  ///
  /// In en, this message translates to:
  /// **'Search by book name...'**
  String get hadithBooksSearch;

  /// Message when no Hadith books are available
  ///
  /// In en, this message translates to:
  /// **'No books available'**
  String get hadithBooksEmpty;

  /// Label for the book author field
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get writer;

  /// Text showing the number of chapters in a book
  ///
  /// In en, this message translates to:
  /// **'Number of chapters:'**
  String get numberOfChapters;

  /// Text showing the number of hadiths in a book
  ///
  /// In en, this message translates to:
  /// **'Number of hadiths:'**
  String get numberOfHadiths;

  /// Title for the list of chapters in a Hadith book
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// Message when a Hadith book has no chapters
  ///
  /// In en, this message translates to:
  /// **'No chapters available'**
  String get chaptersEmpty;

  /// Search hint for the chapters list
  ///
  /// In en, this message translates to:
  /// **'Search for a chapter...'**
  String get chaptersSearch;

  /// Error message when hadiths fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load hadiths'**
  String get hadithError;

  /// Title for the hadith list screen
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get hadithsTitle;

  /// Label for displaying the hadith's authenticity or grading
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get hadithStatus;

  /// Label for the reference section in hadiths or azkar
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get revision;

  /// General error prefix text used in messages
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get errorMain;

  /// Button to retry after an error occurs
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// General loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Message shown when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'No Internet connection'**
  String get noInternet;

  /// Title for the main home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Button to refresh prayer times
  ///
  /// In en, this message translates to:
  /// **'Update Prayer Times'**
  String get updatePrayerTimes;

  /// Button hint to show full prayer schedule
  ///
  /// In en, this message translates to:
  /// **'Tap to view more prayer times'**
  String get morePrayerTimesButton;

  /// Label for prayer times section
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimesText;

  /// Label for Quran section
  ///
  /// In en, this message translates to:
  /// **'Holy Quran'**
  String get quranText;

  /// Label for Surah list screen
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahsText;

  /// Label for the bookmarks section
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarksText;

  /// Hint text for searching surahs
  ///
  /// In en, this message translates to:
  /// **'Search by surah name...'**
  String get searchForSurahName;

  /// Label for displaying search results
  ///
  /// In en, this message translates to:
  /// **'Search results:'**
  String get searchResult;

  /// Message shown when no bookmarks are saved
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get emptyBookmarks;
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
