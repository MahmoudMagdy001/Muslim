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
  /// **'Muslim'**
  String get appName;

  ///
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  ///
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLanguage;

  /// Title of the general Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// Button to navigate to the Azkar screen
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkarButton;

  /// Title of the Azkar categories list screen
  ///
  /// In en, this message translates to:
  /// **'Azkar Categories'**
  String get azkarCategoryList;

  /// Error message when no Azkar are available
  ///
  /// In en, this message translates to:
  /// **'No Azkar available right now'**
  String get azkarError;

  /// Text shown while Azkar are loading
  ///
  /// In en, this message translates to:
  /// **'Loading Azkar...'**
  String get azkarLoadingText;

  ///
  ///
  /// In en, this message translates to:
  /// **'The eight categories of Zakat recipients:'**
  String get beneficiaries;

  ///
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get bigFont;

  /// Text displayed at the beginning of some screens or recitations
  ///
  /// In en, this message translates to:
  /// **'In the name of Allah, the Most Gracious, the Most Merciful'**
  String get bismillah;

  /// Title of the bookmarks screen
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarksText;

  /// Button to bookmark a verse
  ///
  /// In en, this message translates to:
  /// **'Bookmark this verse'**
  String get bookmarkVerse;

  /// Confirmation when bookmarking a verse
  ///
  /// In en, this message translates to:
  /// **'Bookmark saved for verse number '**
  String get bookmarkVerseSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calculate your Zakat easily and accurately'**
  String get calculate_easily;

  ///
  ///
  /// In en, this message translates to:
  /// **'Calculate Zakat'**
  String get calculate_zakat;

  /// General cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'In the cause of Allah'**
  String get cause_of_allah;

  ///
  ///
  /// In en, this message translates to:
  /// **'To support Islamic work and charity.'**
  String get cause_of_allah_desc;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change Font Size'**
  String get changeFontSize;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Reciter changed to '**
  String get changeReciterSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

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

  ///
  ///
  /// In en, this message translates to:
  /// **'Set goal'**
  String get chooseGoal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clear goal'**
  String get clear;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those employed to collect Zakat'**
  String get collectors;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those who collect and distribute Zakat.'**
  String get collectors_desc;

  /// Text shown while compass is calibrating
  ///
  /// In en, this message translates to:
  /// **'Preparing compass...'**
  String get compassLoading;

  ///
  ///
  /// In en, this message translates to:
  /// **'You have completed it'**
  String get completeTasbeh;

  ///
  ///
  /// In en, this message translates to:
  /// **'The Muslim must be free and own the nisab.'**
  String get condition_1;

  ///
  ///
  /// In en, this message translates to:
  /// **'Wealth must reach the nisab (approximately 85 grams of gold).'**
  String get condition_2;

  ///
  ///
  /// In en, this message translates to:
  /// **'A full lunar year must pass on the wealth.'**
  String get condition_3;

  ///
  ///
  /// In en, this message translates to:
  /// **'The wealth must be growing or capable of growth.'**
  String get condition_4;

  ///
  ///
  /// In en, this message translates to:
  /// **'Zakat becomes obligatory when these conditions are met:'**
  String get conditions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congrates;

  ///
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueTasbeh;

  ///
  ///
  /// In en, this message translates to:
  /// **'Crops'**
  String get crops;

  ///
  ///
  /// In en, this message translates to:
  /// **'Zakat is due if the crop reaches approximately {nisab_kg} kg.\n\n{natural_rate}% if irrigated by rain or rivers\n{machine_rate}% if irrigated by machines (costly irrigation)'**
  String crops_zakat_description(
    Object machine_rate,
    Object natural_rate,
    Object nisab_kg,
  );

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter crop quantity in kilograms'**
  String get crops_zakat_hint;

  ///
  ///
  /// In en, this message translates to:
  /// **'🌾 Crops Zakat'**
  String get crops_zakat_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those in debt'**
  String get debtors;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those burdened by debt.'**
  String get debtors_desc;

  ///
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defultFont;

  /// Button to delete a saved bookmark
  ///
  /// In en, this message translates to:
  /// **'Delete bookmark'**
  String get deleteBookmark;

  /// Confirmation message before deleting a bookmark
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the bookmark from Surah'**
  String get deleteBookmarkQuestion;

  /// Confirmation after deleting a bookmark
  ///
  /// In en, this message translates to:
  /// **'Bookmark deleted from Surah'**
  String get deleteBookmarkSuccess;

  /// General delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// Label showing distance to the Kaaba
  ///
  /// In en, this message translates to:
  /// **'Distance to Kaaba:'**
  String get distanceToKabaa;

  ///
  ///
  /// In en, this message translates to:
  /// **'Due Zakat'**
  String get due_zakat;

  /// Message when there are no saved bookmarks
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get emptyBookmarks;

  /// Message when there are no saved hadiths
  ///
  /// In en, this message translates to:
  /// **'No saved hadiths yet'**
  String get savedHadithsEmpty;

  /// Message when no tafsir is available
  ///
  /// In en, this message translates to:
  /// **'No tafsir available right now'**
  String get emptyTafsir;

  ///
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your wealth amount and we will calculate your due Zakat'**
  String get enter_amount;

  /// General prefix for error messages
  ///
  /// In en, this message translates to:
  /// **'Error:'**
  String get errorMain;

  /// Button to view full Qiblah map
  ///
  /// In en, this message translates to:
  /// **'Qiblah Map'**
  String get fullMapQiblah;

  ///
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter your goal (e.g. 50)'**
  String get goalExample;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  ///
  ///
  /// In en, this message translates to:
  /// **'Failed to load gold price'**
  String get gold_price_error;

  ///
  ///
  /// In en, this message translates to:
  /// **'The nisab for gold is {nisab_grams} grams.\nRate: {percentage}% of the market value of gold.\n\nCurrent price per gram: {current_price} EGP'**
  String gold_zakat_description(
    Object current_price,
    Object nisab_grams,
    Object percentage,
  );

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter gold weight in grams'**
  String get gold_zakat_hint;

  ///
  ///
  /// In en, this message translates to:
  /// **'🪙 Gold Zakat'**
  String get gold_zakat_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'The Prophet ﷺ said: \"There is no Zakat on property until a year passes on it.\"'**
  String get hadith;

  /// Title of the Hadith books list screen
  ///
  /// In en, this message translates to:
  /// **'Hadith Books'**
  String get hadithBooks;

  /// No description provided for @hadithSources.
  ///
  /// In en, this message translates to:
  /// **'Hadith Sources'**
  String get hadithSources;

  /// Message when no Hadith books are available
  ///
  /// In en, this message translates to:
  /// **'No books available'**
  String get hadithBooksEmpty;

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

  /// Button to navigate to the Hadith screen
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadithButton;

  /// Error message when hadiths fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load hadiths'**
  String get hadithError;

  /// Label for the hadith grade or status
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get hadithStatus;

  /// Title of the hadith list screen
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get hadithsTitle;

  /// Title of the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid value'**
  String get invalid_input_error;

  ///
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// General loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  ///
  ///
  /// In en, this message translates to:
  /// **'Loading gold price...'**
  String get loading_gold_price;

  ///
  ///
  /// In en, this message translates to:
  /// **'Irrigation by machines or with costs'**
  String get machine_irrigation_subtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'⚙️ Machine or costly ({rate}%)'**
  String machine_irrigation_title(Object rate);

  ///
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get money;

  ///
  ///
  /// In en, this message translates to:
  /// **'Zakat is due on money if it reaches the nisab ({nisab} EGP approximately) and a full lunar year has passed.\n\nRate: {percentage}% of total saved money'**
  String money_zakat_description(Object nisab, Object percentage);

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter total saved money in EGP'**
  String get money_zakat_hint;

  ///
  ///
  /// In en, this message translates to:
  /// **'💰 Money Zakat'**
  String get money_zakat_title;

  /// Button to view additional prayer times
  ///
  /// In en, this message translates to:
  /// **'Tap to view more prayer times'**
  String get morePrayerTimesButton;

  ///
  ///
  /// In en, this message translates to:
  /// **'My Zakat'**
  String get my_zakat;

  /// Title of the Names of Allah screen
  ///
  /// In en, this message translates to:
  /// **'Names of Allah'**
  String get namesOfAllah;

  ///
  ///
  /// In en, this message translates to:
  /// **'Natural irrigation without costs'**
  String get natural_irrigation_subtitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'💧 Rain or rivers ({rate}%)'**
  String natural_irrigation_title(Object rate);

  ///
  ///
  /// In en, this message translates to:
  /// **'The needy'**
  String get needy;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those who have some of their needs but not enough.'**
  String get needy_desc;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those whose hearts are to be reconciled'**
  String get new_muslims;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those who are to be inclined towards Islam.'**
  String get new_muslims_desc;

  /// Message when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  ///
  ///
  /// In en, this message translates to:
  /// **'Note: Zakat is obligatory on saved wealth that reaches the nisab and a year has passed on it.'**
  String get note;

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

  ///
  ///
  /// In en, this message translates to:
  /// **'The poor'**
  String get poor;

  ///
  ///
  /// In en, this message translates to:
  /// **'Those who do not have enough for their daily needs.'**
  String get poor_desc;

  /// Title of the prayer times screen
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimesText;

  ///
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// Button to navigate to the Qiblah direction screen
  ///
  /// In en, this message translates to:
  /// **'Qiblah'**
  String get qiblahButton;

  /// Title for the Qiblah direction screen
  ///
  /// In en, this message translates to:
  /// **'Qiblah Direction'**
  String get qiblahDirection;

  ///
  ///
  /// In en, this message translates to:
  /// **'Zakat is for the poor and the needy and those employed to collect it and for bringing hearts together and for freeing captives and for those in debt and for the cause of Allah and for the traveler'**
  String get quran_text;

  ///
  ///
  /// In en, this message translates to:
  /// **'Allah says:'**
  String get quran_verse;

  /// Button to navigate to the Qur'an screen
  ///
  /// In en, this message translates to:
  /// **'Qur\'an'**
  String get quranButton;

  /// Title of the Qur'an screen
  ///
  /// In en, this message translates to:
  /// **'The Holy Qur\'an'**
  String get quranText;

  ///
  ///
  /// In en, this message translates to:
  /// **'Refresh gold price'**
  String get refresh_gold_price;

  /// Button to reset the Tasbeeh counter
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  ///
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get resetTasbeh;

  /// Button to retry after an error
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Section title for the reference in hadiths or azkar
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get revision;

  /// Text shown when the device is aligned with Qiblah
  ///
  /// In en, this message translates to:
  /// **'Aligned with Kaaba'**
  String get salahDirection;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

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

  /// Title of the digital rosary screen
  ///
  /// In en, this message translates to:
  /// **'Digital Tasbeeh'**
  String get sebha;

  ///
  ///
  /// In en, this message translates to:
  /// **'Digital Tasbeeh'**
  String get sebhaTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Font Size'**
  String get selectFontSize;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get selectReciter;

  /// Prompt text for selecting tafsir type
  ///
  /// In en, this message translates to:
  /// **'Select Tafsir'**
  String get selectTafsir;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// Button to navigate to app settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsButton;

  /// Button to share tafsir text
  ///
  /// In en, this message translates to:
  /// **'Share Tafsir'**
  String get shareTafsir;

  ///
  ///
  /// In en, this message translates to:
  /// **'For freeing slaves'**
  String get slaves;

  ///
  ///
  /// In en, this message translates to:
  /// **'To free captives or those oppressed by debt.'**
  String get slaves_desc;

  ///
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get smallFont;

  ///
  ///
  /// In en, this message translates to:
  /// **'Start Zakat Calculation'**
  String get start_calculation;

  /// No description provided for @juzText.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get juzText;

  /// No description provided for @hizbText.
  ///
  /// In en, this message translates to:
  /// **'Hizb'**
  String get hizbText;

  /// Title for the list of Surahs
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahsText;

  ///
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get systemMode;

  /// Button to view the verse tafsir
  ///
  /// In en, this message translates to:
  /// **'Verse Interpretation'**
  String get tafsirVerse;

  ///
  ///
  /// In en, this message translates to:
  /// **'Do you want to restart the count or continue?'**
  String get tasbehQuestion;

  /// Section title for Tasbeeh on the rosary screen
  ///
  /// In en, this message translates to:
  /// **'Tasbeeh'**
  String get tasbih;

  ///
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get trade;

  ///
  ///
  /// In en, this message translates to:
  /// **'Zakat is calculated on: (Goods value + Cash - Debts) × {percentage}%\n\nDue after a full year.\nNisab: {nisab} EGP'**
  String trade_zakat_description(Object nisab, Object percentage);

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter net trade assets in EGP'**
  String get trade_zakat_hint;

  ///
  ///
  /// In en, this message translates to:
  /// **'🛍️ Trade Zakat'**
  String get trade_zakat_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'The wayfarer'**
  String get traveler;

  ///
  ///
  /// In en, this message translates to:
  /// **'A traveler who is cut off from his resources.'**
  String get traveler_desc;

  ///
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unit_kg;

  /// Button to manually update prayer times
  ///
  /// In en, this message translates to:
  /// **'Update Prayer Times'**
  String get updatePrayerTimes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  ///
  ///
  /// In en, this message translates to:
  /// **'When is Zakat due?'**
  String get when_zakat_due;

  /// Field title for the author's name
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get writer;

  /// Title of the Zakat screen
  ///
  /// In en, this message translates to:
  /// **'My Zakat'**
  String get zakat;

  ///
  ///
  /// In en, this message translates to:
  /// **'Zakat Calculator'**
  String get zakat_calculator;

  ///
  ///
  /// In en, this message translates to:
  /// **'Who is Zakat for?'**
  String get zakat_for_whom;

  ///
  ///
  /// In en, this message translates to:
  /// **'Remember: Zakat is only obligatory if wealth reaches nisab and a year has passed'**
  String get zakat_reminder;

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

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @appNotifications.
  ///
  /// In en, this message translates to:
  /// **'App Notifications'**
  String get appNotifications;

  /// No description provided for @enablePrayerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Prayer Notifications'**
  String get enablePrayerNotifications;

  /// No description provided for @enableQuranReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable Quran Reminders'**
  String get enableQuranReminders;

  /// No description provided for @prayerNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Prayer notifications enabled'**
  String get prayerNotificationsEnabled;

  /// No description provided for @prayerNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Prayer notifications disabled'**
  String get prayerNotificationsDisabled;

  /// No description provided for @quranRemindersEnabled.
  ///
  /// In en, this message translates to:
  /// **'Quran reminders enabled'**
  String get quranRemindersEnabled;

  /// No description provided for @quranRemindersDisabled.
  ///
  /// In en, this message translates to:
  /// **'Quran reminders disabled'**
  String get quranRemindersDisabled;

  /// No description provided for @quranReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'📖 Quran Reading Reminder'**
  String get quranReminderTitle;

  /// No description provided for @quranReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget your daily Quran reading 🌿'**
  String get quranReminderBody;

  /// No description provided for @allServices.
  ///
  /// In en, this message translates to:
  /// **'All Services'**
  String get allServices;

  /// Button to add a new custom tasbih
  ///
  /// In en, this message translates to:
  /// **'Add Custom Tasbih'**
  String get addCustomTasbih;

  /// Title for edit tasbih dialog
  ///
  /// In en, this message translates to:
  /// **'Edit Tasbih'**
  String get editTasbih;

  /// Button to delete tasbih
  ///
  /// In en, this message translates to:
  /// **'Delete Tasbih'**
  String get deleteTasbih;

  /// Confirmation message for deleting tasbih
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this Tasbih?'**
  String get deleteTasbihConfirm;

  /// Label for Arabic text field
  ///
  /// In en, this message translates to:
  /// **'Tasbih Text in Arabic'**
  String get tasbihTextAr;

  /// Label for English text field
  ///
  /// In en, this message translates to:
  /// **'Tasbih Text in English'**
  String get tasbihTextEn;

  /// Label for goal field
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get tasbihGoal;

  /// Hint text for Arabic text field
  ///
  /// In en, this message translates to:
  /// **'Example: Astaghfirullah'**
  String get tasbihTextArHint;

  /// Hint text for English text field
  ///
  /// In en, this message translates to:
  /// **'Example: I seek forgiveness from Allah'**
  String get tasbihTextEnHint;

  /// Hint text for goal field
  ///
  /// In en, this message translates to:
  /// **'Example: 100'**
  String get tasbihGoalHint;

  /// Error message for required fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Error message when goal is zero or negative
  ///
  /// In en, this message translates to:
  /// **'Goal must be greater than zero'**
  String get goalMustBePositive;
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
