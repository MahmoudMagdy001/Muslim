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

  /// Main app name displayed in the interface
  ///
  /// In en, this message translates to:
  /// **'Musallim'**
  String get appName;

  /// Button to navigate to the Qur'an screen
  ///
  /// In en, this message translates to:
  /// **'Qur\'an'**
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

  /// Button to navigate to app settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsButton;

  /// Title of the Zakat screen
  ///
  /// In en, this message translates to:
  /// **'My Zakat'**
  String get zakat;

  /// Hadith displayed in the Zakat screen
  ///
  /// In en, this message translates to:
  /// **'The Prophet ﷺ said: \'Charity does not decrease wealth.\''**
  String get zakatDuaa;

  /// Motivational text to start Zakat calculation
  ///
  /// In en, this message translates to:
  /// **'Start calculating your Zakat and remember its great reward'**
  String get zakatStart;

  /// Title of the Names of Allah screen
  ///
  /// In en, this message translates to:
  /// **'Names of Allah'**
  String get namesOfAllah;

  /// Title of the digital rosary screen
  ///
  /// In en, this message translates to:
  /// **'Digital Tasbeeh'**
  String get sebha;

  /// Section title for Tasbeeh on the rosary screen
  ///
  /// In en, this message translates to:
  /// **'Tasbeeh'**
  String get tasbih;

  /// Button to reset the Tasbeeh counter
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Title of the general Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// Title of the Azkar categories list screen
  ///
  /// In en, this message translates to:
  /// **'Azkar Categories'**
  String get azkarCategoryList;

  /// Text shown while Azkar are loading
  ///
  /// In en, this message translates to:
  /// **'Loading Azkar...'**
  String get azkarLoadingText;

  /// Error message when no Azkar are available
  ///
  /// In en, this message translates to:
  /// **'No Azkar available right now'**
  String get azkarError;

  /// Title of the Hadith books list screen
  ///
  /// In en, this message translates to:
  /// **'Hadith Books'**
  String get hadithBooks;

  /// Error message when Hadith books fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load books'**
  String get hadithBooksError;

  /// Search placeholder in Hadith books list
  ///
  /// In en, this message translates to:
  /// **'Search by book name...'**
  String get hadithBooksSearch;

  /// Message when no Hadith books are available
  ///
  /// In en, this message translates to:
  /// **'No books available'**
  String get hadithBooksEmpty;

  /// Field title for the author's name
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get writer;

  /// Label for the number of chapters in a book
  ///
  /// In en, this message translates to:
  /// **'Chapters:'**
  String get numberOfChapters;

  /// Label for the number of hadiths in a book
  ///
  /// In en, this message translates to:
  /// **'Hadiths:'**
  String get numberOfHadiths;

  /// Title for the chapters screen within a Hadith book
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// Message when there are no chapters
  ///
  /// In en, this message translates to:
  /// **'No chapters available'**
  String get chaptersEmpty;

  /// Search text for chapters list
  ///
  /// In en, this message translates to:
  /// **'Search for a chapter...'**
  String get chaptersSearch;

  /// Error message when hadiths fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load hadiths'**
  String get hadithError;

  /// Title of the hadith list screen
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get hadithsTitle;

  /// Label for the hadith grade or status
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get hadithStatus;

  /// Section title for the reference in hadiths or azkar
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get revision;

  /// General prefix for error messages
  ///
  /// In en, this message translates to:
  /// **'Error:'**
  String get errorMain;

  /// Button to retry after an error
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// General loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Message when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// Title of the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Button to manually update prayer times
  ///
  /// In en, this message translates to:
  /// **'Update Prayer Times'**
  String get updatePrayerTimes;

  /// Button to view additional prayer times
  ///
  /// In en, this message translates to:
  /// **'Tap to view more prayer times'**
  String get morePrayerTimesButton;

  /// Title of the prayer times screen
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimesText;

  /// Title of the Qur'an screen
  ///
  /// In en, this message translates to:
  /// **'The Holy Qur\'an'**
  String get quranText;

  /// Title for the list of Surahs
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahsText;

  /// Title of the bookmarks screen
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarksText;

  /// Placeholder text for Surah search
  ///
  /// In en, this message translates to:
  /// **'Search by Surah name...'**
  String get searchForSurahName;

  /// Title of the search results section
  ///
  /// In en, this message translates to:
  /// **'Search Results:'**
  String get searchResult;

  /// Message when there are no saved bookmarks
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get emptyBookmarks;

  /// Button to delete a saved bookmark
  ///
  /// In en, this message translates to:
  /// **'Delete bookmark'**
  String get deleteBookmark;

  /// Confirmation after deleting a bookmark
  ///
  /// In en, this message translates to:
  /// **'Bookmark deleted from Surah'**
  String get deleteBookmarkSuccess;

  /// Confirmation message before deleting a bookmark
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the bookmark from Surah'**
  String get deleteBookmarkQuestion;

  /// General delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// General cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// General confirmation button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// Button to play recitation starting from a specific verse
  ///
  /// In en, this message translates to:
  /// **'Play from this verse'**
  String get playVerseSound;

  /// Button to bookmark a verse
  ///
  /// In en, this message translates to:
  /// **'Bookmark this verse'**
  String get bookmarkVerse;

  /// Button to view the verse tafsir
  ///
  /// In en, this message translates to:
  /// **'Verse Interpretation'**
  String get tafsirVerse;

  /// Confirmation when bookmarking a verse
  ///
  /// In en, this message translates to:
  /// **'Bookmark saved for verse number '**
  String get bookmarkVerseSuccess;

  /// Prompt text for selecting tafsir type
  ///
  /// In en, this message translates to:
  /// **'Select Tafsir'**
  String get selectTafsir;

  /// Message when no tafsir is available
  ///
  /// In en, this message translates to:
  /// **'No tafsir available right now'**
  String get emptyTafsir;

  /// Button to share tafsir text
  ///
  /// In en, this message translates to:
  /// **'Share Tafsir'**
  String get shareTafsir;

  /// Title for the Qiblah direction screen
  ///
  /// In en, this message translates to:
  /// **'Qiblah Direction'**
  String get qiblahDirection;

  /// Label showing distance to the Kaaba
  ///
  /// In en, this message translates to:
  /// **'Distance to Kaaba:'**
  String get distanceToKabaa;

  /// Button to view full Qiblah map
  ///
  /// In en, this message translates to:
  /// **'Qiblah Map'**
  String get fullMapQiblah;

  /// Text shown while compass is calibrating
  ///
  /// In en, this message translates to:
  /// **'Preparing compass...'**
  String get compassLoading;

  /// Text shown when the device is aligned with Qiblah
  ///
  /// In en, this message translates to:
  /// **'Aligned with Kaaba'**
  String get salahDirection;

  /// Text displayed at the beginning of some screens or recitations
  ///
  /// In en, this message translates to:
  /// **'In the name of Allah, the Most Gracious, the Most Merciful'**
  String get bismillah;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change Font Size'**
  String get changeFontSize;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Font Size'**
  String get selectFontSize;

  ///
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get smallFont;

  ///
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defultFont;

  ///
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get bigFont;

  ///
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  ///
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get systemMode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  ///
  ///
  /// In en, this message translates to:
  /// **'Reciter changed to '**
  String get changeReciterSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get selectReciter;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  ///
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  ///
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  ///
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;
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
