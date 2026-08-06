// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Muslim';

  @override
  String get appVersion => 'App Version';

  @override
  String get arabicLanguage => 'Arabic';

  @override
  String get azkar => 'Azkar';

  @override
  String get azkarButton => 'Azkar';

  @override
  String get azkarCategoryList => 'Azkar Categories';

  @override
  String get azkarError => 'No Azkar available right now';

  @override
  String get azkarLoadingText => 'Loading Azkar...';

  @override
  String get beneficiaries => 'The eight categories of Zakat recipients:';

  @override
  String get bigFont => 'Large';

  @override
  String get bismillah =>
      'In the name of Allah, the Most Gracious, the Most Merciful';

  @override
  String get bookmarksText => 'Bookmarks';

  @override
  String get bookmarkVerse => 'Bookmark this verse';

  @override
  String get bookmarkVerseSuccess => 'Bookmark saved for verse number ';

  @override
  String get calculate_easily => 'Calculate your Zakat easily and accurately';

  @override
  String get calculate_zakat => 'Calculate Zakat';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get cause_of_allah => 'In the cause of Allah';

  @override
  String get cause_of_allah_desc => 'To support Islamic work and charity.';

  @override
  String get changeFontSize => 'Change Font Size';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get changeReciterSuccess => 'Reciter changed to ';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get chapters => 'Chapters';

  @override
  String get chaptersEmpty => 'No chapters available';

  @override
  String get chaptersSearch => 'Search for a chapter...';

  @override
  String get chooseGoal => 'Set goal';

  @override
  String get clear => 'Clear goal';

  @override
  String get collectors => 'Those employed to collect Zakat';

  @override
  String get collectors_desc => 'Those who collect and distribute Zakat.';

  @override
  String get compassLoading => 'Preparing compass...';

  @override
  String get completeTasbeh => 'You have completed it';

  @override
  String get condition_1 => 'The Muslim must be free and own the nisab.';

  @override
  String get condition_2 =>
      'Wealth must reach the nisab (approximately 85 grams of gold).';

  @override
  String get condition_3 => 'A full lunar year must pass on the wealth.';

  @override
  String get condition_4 => 'The wealth must be growing or capable of growth.';

  @override
  String get conditions =>
      'Zakat becomes obligatory when these conditions are met:';

  @override
  String get congrates => 'Congratulations';

  @override
  String get continueTasbeh => 'Continue';

  @override
  String get crops => 'Crops';

  @override
  String crops_zakat_description(
    String nisab_kg,
    String natural_rate,
    String machine_rate,
  ) {
    return 'Zakat is due if the crop reaches approximately $nisab_kg kg.\n\n$natural_rate% if irrigated by rain or rivers\n$machine_rate% if irrigated by machines (costly irrigation)';
  }

  @override
  String get crops_zakat_hint => 'Enter crop quantity in kilograms';

  @override
  String get crops_zakat_title => '🌾 Crops Zakat';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get debtors => 'Those in debt';

  @override
  String get debtors_desc => 'Those burdened by debt.';

  @override
  String get defultFont => 'Default';

  @override
  String get deleteBookmark => 'Delete bookmark';

  @override
  String get deleteBookmarkQuestion =>
      'Are you sure you want to delete the bookmark from Surah';

  @override
  String get deleteBookmarkSuccess => 'Bookmark deleted from Surah';

  @override
  String get deleteButton => 'Delete';

  @override
  String get distanceToKabaa => 'Distance to Kaaba:';

  @override
  String get due_zakat => 'Due Zakat';

  @override
  String get emptyBookmarks => 'No bookmarks yet';

  @override
  String get savedHadithsEmpty => 'No saved hadiths yet';

  @override
  String get emptyTafsir => 'No tafsir available right now';

  @override
  String get englishLanguage => 'English';

  @override
  String get enter_amount =>
      'Enter your wealth amount and we will calculate your due Zakat';

  @override
  String get errorMain => 'Error:';

  @override
  String get fullMapQiblah => 'Qiblah Map';

  @override
  String get goal => 'Goal';

  @override
  String get goalExample => 'Enter your goal (e.g. 50)';

  @override
  String get gold => 'Gold';

  @override
  String get gold_price_error => 'Failed to load gold price';

  @override
  String gold_zakat_description(
    String nisab_grams,
    String percentage,
    String current_price,
  ) {
    return 'The nisab for gold is $nisab_grams grams.\nRate: $percentage% of the market value of gold.\n\nCurrent price per gram: $current_price EGP';
  }

  @override
  String get gold_zakat_hint => 'Enter gold weight in grams';

  @override
  String get gold_zakat_title => '🪙 Gold Zakat';

  @override
  String get hadith =>
      'The Prophet ﷺ said: \"There is no Zakat on property until a year passes on it.\"';

  @override
  String get hadithBooks => 'Hadith Books';

  @override
  String get hadithSources => 'Hadith Sources';

  @override
  String get hadithBooksEmpty => 'No books available';

  @override
  String get hadithBooksError => 'Failed to load books';

  @override
  String get hadithBooksSearch => 'Search by book name...';

  @override
  String get hadithButton => 'Hadith';

  @override
  String get hadithError => 'Failed to load hadiths';

  @override
  String get hadithStatus => 'Status';

  @override
  String get hadithsTitle => 'Hadiths';

  @override
  String get homeTitle => 'Home';

  @override
  String get invalid_input_error => 'Please enter a valid value';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get loading => 'Loading...';

  @override
  String get loading_gold_price => 'Loading gold price...';

  @override
  String get machine_irrigation_subtitle =>
      'Irrigation by machines or with costs';

  @override
  String machine_irrigation_title(String rate) {
    return '⚙️ Machine or costly ($rate%)';
  }

  @override
  String get money => 'Money';

  @override
  String money_zakat_description(String nisab, String percentage) {
    return 'Zakat is due on money if it reaches the nisab ($nisab EGP approximately) and a full lunar year has passed.\n\nRate: $percentage% of total saved money';
  }

  @override
  String get money_zakat_hint => 'Enter total saved money in EGP';

  @override
  String get money_zakat_title => '💰 Money Zakat';

  @override
  String get morePrayerTimesButton => 'Tap to view more prayer times';

  @override
  String get my_zakat => 'My Zakat';

  @override
  String get namesOfAllah => 'Names of Allah';

  @override
  String get natural_irrigation_subtitle => 'Natural irrigation without costs';

  @override
  String natural_irrigation_title(String rate) {
    return '💧 Rain or rivers ($rate%)';
  }

  @override
  String get needy => 'The needy';

  @override
  String get needy_desc => 'Those who have some of their needs but not enough.';

  @override
  String get new_muslims => 'Those whose hearts are to be reconciled';

  @override
  String get new_muslims_desc => 'Those who are to be inclined towards Islam.';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get note =>
      'Note: Zakat is obligatory on saved wealth that reaches the nisab and a year has passed on it.';

  @override
  String get numberOfChapters => 'Chapters:';

  @override
  String get numberOfHadiths => 'Hadiths:';

  @override
  String get okButton => 'OK';

  @override
  String get playVerseSound => 'Play from this verse';

  @override
  String get poor => 'The poor';

  @override
  String get poor_desc => 'Those who do not have enough for their daily needs.';

  @override
  String get prayerTimesText => 'Prayer Times';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get qiblahButton => 'Qiblah';

  @override
  String get qiblahDirection => 'Qiblah Direction';

  @override
  String get qiblahSubtitle => 'Point your phone toward the Qiblah';

  @override
  String get quran_text =>
      'Zakat is for the poor and the needy and those employed to collect it and for bringing hearts together and for freeing captives and for those in debt and for the cause of Allah and for the traveler';

  @override
  String get quran_verse => 'Allah says:';

  @override
  String get quranButton => 'Qur\'an';

  @override
  String get quranText => 'The Holy Qur\'an';

  @override
  String get refresh_gold_price => 'Refresh gold price';

  @override
  String get reset => 'Reset';

  @override
  String get resetTasbeh => 'Restart';

  @override
  String get retry => 'Retry';

  @override
  String get revision => 'Reference';

  @override
  String get salahDirection => 'Aligned with Kaaba';

  @override
  String get save => 'Save';

  @override
  String get searchForSurahName => 'Search by Surah name...';

  @override
  String get searchResult => 'Search Results:';

  @override
  String get sebha => 'Digital Tasbeeh';

  @override
  String get sebhaTitle => 'Digital Tasbeeh';

  @override
  String get selectFontSize => 'Select Font Size';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectReciter => 'Select Reciter';

  @override
  String get selectTafsir => 'Select Tafsir';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get settingsButton => 'Settings';

  @override
  String get shareTafsir => 'Share Tafsir';

  @override
  String get slaves => 'For freeing slaves';

  @override
  String get slaves_desc => 'To free captives or those oppressed by debt.';

  @override
  String get smallFont => 'Small';

  @override
  String get start_calculation => 'Start Zakat Calculation';

  @override
  String get juzText => 'Juz';

  @override
  String get hizbText => 'Hizb';

  @override
  String get surahsText => 'Surahs';

  @override
  String get systemMode => 'System Mode';

  @override
  String get tafsirVerse => 'Verse Interpretation';

  @override
  String get tasbehQuestion => 'Do you want to restart the count or continue?';

  @override
  String get tasbih => 'Tasbeeh';

  @override
  String get trade => 'Trade';

  @override
  String trade_zakat_description(String percentage, String nisab) {
    return 'Zakat is calculated on: (Goods value + Cash - Debts) × $percentage%\n\nDue after a full year.\nNisab: $nisab EGP';
  }

  @override
  String get trade_zakat_hint => 'Enter net trade assets in EGP';

  @override
  String get trade_zakat_title => '🛍️ Trade Zakat';

  @override
  String get traveler => 'The wayfarer';

  @override
  String get traveler_desc => 'A traveler who is cut off from his resources.';

  @override
  String get unit_kg => 'kg';

  @override
  String get updatePrayerTimes => 'Update Prayer Times';

  @override
  String get version => 'Version';

  @override
  String get when_zakat_due => 'When is Zakat due?';

  @override
  String get writer => 'Author';

  @override
  String get zakat => 'My Zakat';

  @override
  String get zakat_calculator => 'Zakat Calculator';

  @override
  String get zakat_for_whom => 'Who is Zakat for?';

  @override
  String get zakat_reminder =>
      'Remember: Zakat is only obligatory if wealth reaches nisab and a year has passed';

  @override
  String get zakatDuaa =>
      'The Prophet ﷺ said: \'Charity does not decrease wealth.\'';

  @override
  String get zakatStart =>
      'Start calculating your Zakat and remember its great reward';

  @override
  String get aboutUs => 'About Us';

  @override
  String get appNotifications => 'App Notifications';

  @override
  String get enablePrayerNotifications => 'Enable Prayer Notifications';

  @override
  String get enableQuranReminders => 'Enable Quran Reminders';

  @override
  String get prayerNotificationsEnabled => 'Prayer notifications enabled';

  @override
  String get prayerNotificationsDisabled => 'Prayer notifications disabled';

  @override
  String get quranRemindersEnabled => 'Quran reminders enabled';

  @override
  String get quranRemindersDisabled => 'Quran reminders disabled';

  @override
  String get quranReminderTitle => '📖 Quran Reading Reminder';

  @override
  String get quranReminderBody => 'Don\'t forget your daily Quran reading 🌿';

  @override
  String get allServices => 'All Services';

  @override
  String get addCustomTasbih => 'Add Custom Tasbih';

  @override
  String get editTasbih => 'Edit Tasbih';

  @override
  String get deleteTasbih => 'Delete Tasbih';

  @override
  String get deleteTasbihConfirm =>
      'Are you sure you want to delete this Tasbih?';

  @override
  String get tasbihTextAr => 'Tasbih Text in Arabic';

  @override
  String get tasbihTextEn => 'Tasbih Text in English';

  @override
  String get tasbihGoal => 'Goal';

  @override
  String get tasbihTextArHint => 'Example: Astaghfirullah';

  @override
  String get tasbihTextEnHint => 'Example: I seek forgiveness from Allah';

  @override
  String get tasbihGoalHint => 'Example: 100';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get goalMustBePositive => 'Goal must be greater than zero';

  @override
  String get updateAvailableTitle => 'New Update Available';

  @override
  String get updateAvailableMessage =>
      'A new version of the Muslim app is available.\nDo you want to update now to get the latest features and improvements?';

  @override
  String get updateNowButton => 'Update Now';

  @override
  String get laterButton => 'Later';

  @override
  String get rateAppMessage => '🌟 Thanks for rating!';

  @override
  String get rateAppSuccess => 'Rated successfully';

  @override
  String get rateAppButton => 'Rate App';

  @override
  String get enterGoldPriceManually => 'Enter Gold Price Manually';

  @override
  String get goldPricePerGram => 'Price per Gram (24K)';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get privacyMatters => 'Your Privacy Matters';

  @override
  String get noPersonalData => 'We do not collect any personal data at all';

  @override
  String get privacyPrinciples => 'Privacy Principles';

  @override
  String get noAccounts => 'No Accounts';

  @override
  String get noAccountsDesc =>
      'The app does not require account creation or login';

  @override
  String get noTracking => 'No Tracking';

  @override
  String get noTrackingDesc => 'We do not track or monitor your app usage';

  @override
  String get noPurchases => 'No Purchases';

  @override
  String get noPurchasesDesc => 'There are no in-app purchases';

  @override
  String get locationDataTitle => 'Location Data';

  @override
  String get locationPurpose =>
      '• Purpose: Calculating accurate prayer times and Qibla direction.';

  @override
  String get locationAccessMethod =>
      '• Access Method: Location is accessed only while using the app (Foreground) to update coordinates.';

  @override
  String get locationStorage =>
      '• Storage: Last known coordinates are saved locally on your device to ensure accurate alerts even offline.';

  @override
  String get locationPrivacy =>
      '• Privacy: Your location data is not sent to any external server and is not shared with third parties.';

  @override
  String get dataCollectionInfo => 'Data Collection Info';

  @override
  String get dataCollectionDesc =>
      'The app does not collect any personal data. All information remains on your device only and we do not access it in any way.';

  @override
  String get localStorage => 'Local Storage';

  @override
  String get storageQuranBookmarks => 'Quran Ayah Bookmarks';

  @override
  String get storageSavedHadith => 'Saved Hadiths';

  @override
  String get storageNotificationSettings => 'Notification Settings';

  @override
  String get storageLangTheme => 'Language & Theme Preferences';

  @override
  String get storageFontSizeReciters => 'Font Size & Reciters';

  @override
  String get storageLocationCoordinates => 'Location Coordinates (Local only)';

  @override
  String get haveQuestions => 'Have Questions?';

  @override
  String get privacyHelp => 'We are here to help with any privacy questions';

  @override
  String get contactEmail => 'Contact Us via Email';

  @override
  String get cannotOpenEmail => 'Cannot open email app';

  @override
  String get lastUpdated => 'Last Updated';

  @override
  String get muslimAppTitle => 'Muslim App';

  @override
  String get aboutUsDescription =>
      'Muslim App is your daily companion for prayer reminders, Quran reading, and Azkar. Carefully designed to provide a simple and easy spiritual experience in your daily life.';

  @override
  String get connectWithUs => 'Connect with Us';

  @override
  String get sendEmail => 'Send an Email';

  @override
  String get visitWebsite => 'Visit our Website';

  @override
  String get emailContactSubject => 'Contact regarding the app - Muslim';

  @override
  String get emailPrivacySubject => 'Privacy Policy Inquiry - Muslim';

  @override
  String get periodicReminderTitle => 'Periodic Reminder';

  @override
  String everyNMinutes(int minutes) {
    return 'Every $minutes minutes';
  }

  @override
  String get egpUnit => 'EGP';

  @override
  String get makkiyah => 'Meccan';

  @override
  String get madaniyah => 'Medinan';

  @override
  String get selectTimeInterval => 'Select Time Interval';

  @override
  String nMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get jumuah => 'Jumuah';

  @override
  String get autoLocationUpdates => 'Auto Location Updates';

  @override
  String get autoLocationSubtitle =>
      'Update prayer times based on your current location';

  @override
  String get autoLocationEnabled => 'Auto location updates enabled';

  @override
  String get autoLocationDisabled => 'Auto location updates disabled';

  @override
  String versesCount(int count) {
    return '$count Verses';
  }

  @override
  String juzNumberLabel(int number) {
    return 'Juz $number';
  }

  @override
  String hizbNumberLabel(int number) {
    return 'Hizb $number';
  }

  @override
  String ayahNumberLabel(int number) {
    return 'Ayah $number';
  }

  @override
  String surahNumberLabel(int number) {
    return 'Surah $number';
  }

  @override
  String get noResultsFound => 'No results found';

  @override
  String get emptyTafsirText => 'Tafsir text is empty';

  @override
  String get failedSplitTafsir => 'Failed to split tafsir text';

  @override
  String get meaningLabel => 'Meaning';

  @override
  String get shareError => 'Error sharing image';

  @override
  String get namesOfAllahShareText => 'Names of Allah - Shared from Muslim App';

  @override
  String get sharedFromMuslimApp => 'Shared from Muslim App';

  @override
  String get ayatText => 'Verses';

  @override
  String get tourNext => 'Next';

  @override
  String get tourSkip => 'Skip';

  @override
  String get tourDone => 'Got it';

  @override
  String get tourPrayerTimesTitle => 'Prayer Times & Azan';

  @override
  String get tourPrayerTimesMessage =>
      'Track upcoming prayer times and location settings.';

  @override
  String get tourZakatTitle => 'Zakat Calculator';

  @override
  String get tourZakatMessage =>
      'Calculate your Zakat easily and check eligible categories.';

  @override
  String get tourServicesTitle => 'Islamic Features';

  @override
  String get tourServicesMessage =>
      'Access Holy Quran, Hadiths, Azkar, Sebha, and Allah Names.';

  @override
  String get tourSettingsTitle => 'App Settings';

  @override
  String get tourSettingsMessage =>
      'Customize language, theme, font size, and reciters.';

  @override
  String get tourQuranTitle => 'Holy Quran';

  @override
  String get tourQuranMessage => 'Browse Surahs, Juz, and Hizb sections.';

  @override
  String get tourBookmarksTitle => 'Saved Bookmarks';

  @override
  String get tourBookmarksMessage =>
      'Quickly access your saved Quran bookmarks.';

  @override
  String get tourHadithTitle => 'Hadith Collection';

  @override
  String get tourHadithMessage =>
      'Explore authentic Hadith books and daily Hadiths.';

  @override
  String get tourSavedHadithTitle => 'Saved Hadiths';

  @override
  String get tourSavedHadithMessage =>
      'View your saved Hadiths for quick reference.';

  @override
  String get tourSebhaTitle => 'Digital Sebha';

  @override
  String get tourSebhaMessage =>
      'Tap the button to increment your Tasbih counter.';

  @override
  String get tourAddZikrTitle => 'Custom Zikr';

  @override
  String get tourAddZikrMessage =>
      'Add your own custom Azkar and set personal goals.';

  @override
  String get tourAzkarTitle => 'Daily Azkar';

  @override
  String get tourAzkarMessage =>
      'Morning, evening, and situational Azkar categorized for convenience.';

  @override
  String get tourNamesOfAllahTitle => '99 Names of Allah';

  @override
  String get tourNamesOfAllahMessage =>
      'Read meanings and share beautiful cards of Allah\'s names.';

  @override
  String get tourQiblahTitle => 'Qiblah Compass';

  @override
  String get tourQiblahMessage =>
      'Align your device to find the precise Kaaba direction.';
}
