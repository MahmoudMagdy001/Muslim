// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get azkarCategoryList => 'قائمة أنواع الأذكار';

  @override
  String get azkarLoadingText => 'جاري تحميل الأذكار...';

  @override
  String get azkarError => 'لا توجد أذكار متاحة حاليًا';

  @override
  String get azkar => 'الأذكار';

  @override
  String get revision => 'المرجع';

  @override
  String get tasbih => 'التسبيح';

  @override
  String get reset => 'إعادة التعيين';

  @override
  String get hadithBooks => 'كتب الحديث';

  @override
  String get hadithBooksError => 'فشل في جلب الكتب';

  @override
  String get hadithBooksSearch => 'ابحث باسم الكتاب...';

  @override
  String get hadithBooksEmpty => 'لا توجد كتب متاحة';

  @override
  String get writer => 'المؤلف';

  @override
  String get numberOfChapters => 'عدد الأبواب:';

  @override
  String get numberOfHadiths => 'عدد الأحاديث:';

  @override
  String get chapters => 'أبواب';

  @override
  String get errorMain => 'حدث خطأ:';

  @override
  String get chaptersEmpty => 'لا توجد أبواب';

  @override
  String get chaptersSearch => 'ابحث عن باب...';

  @override
  String get hadithError => 'فشل في تحميل الأحاديث';

  @override
  String get hadithstitle => 'أحاديث';

  @override
  String get hadithStatus => 'الحكم';
}
