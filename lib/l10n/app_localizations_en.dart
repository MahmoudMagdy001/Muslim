// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get azkarCategoryList => 'List of Azkar Categories';

  @override
  String get azkarLoadingText => 'Loading Azkar...';

  @override
  String get azkarError => 'No Azkar available at the moment';

  @override
  String get azkar => 'Azkar';

  @override
  String get revision => 'Reference';

  @override
  String get tasbih => 'Tasbih';

  @override
  String get reset => 'Reset';

  @override
  String get hadithBooks => 'Hadith Books';

  @override
  String get hadithBooksError => 'Failed to fetch books';

  @override
  String get hadithBooksSearch => 'Search by book name...';

  @override
  String get hadithBooksEmpty => 'No books available';

  @override
  String get writer => 'Author';

  @override
  String get numberOfChapters => 'Number of Chapters:';

  @override
  String get numberOfHadiths => 'Number of Hadiths:';

  @override
  String get chapters => 'Chapters';

  @override
  String get errorMain => 'An error occurred:';

  @override
  String get chaptersEmpty => 'No chapters available';

  @override
  String get chaptersSearch => 'Search for a chapter...';

  @override
  String get hadithError => 'Failed to load Hadiths';

  @override
  String get hadithstitle => 'Hadiths';

  @override
  String get hadithStatus => 'Status';
}
