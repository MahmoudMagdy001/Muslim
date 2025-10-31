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
    Object machine_rate,
    Object natural_rate,
    Object nisab_kg,
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
    Object current_price,
    Object nisab_grams,
    Object percentage,
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
  String machine_irrigation_title(Object rate) {
    return '⚙️ Machine or costly ($rate%)';
  }

  @override
  String get money => 'Money';

  @override
  String money_zakat_description(Object nisab, Object percentage) {
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
  String natural_irrigation_title(Object rate) {
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
  String trade_zakat_description(Object nisab, Object percentage) {
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
}
