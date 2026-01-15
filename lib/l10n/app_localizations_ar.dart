// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'مُسَلِّم';

  @override
  String get appVersion => 'إصدار التطبيق';

  @override
  String get arabicLanguage => 'العربية';

  @override
  String get azkar => 'الأذكار';

  @override
  String get azkarButton => 'الأذكار';

  @override
  String get azkarCategoryList => 'قائمة أنواع الأذكار';

  @override
  String get azkarError => 'لا توجد أذكار متاحة حاليًا';

  @override
  String get azkarLoadingText => 'جاري تحميل الأذكار...';

  @override
  String get beneficiaries => 'مصارف الزكاة الثمانية:';

  @override
  String get bigFont => 'كبير';

  @override
  String get bismillah => 'بسم الله الرحمن الرحيم';

  @override
  String get bookmarksText => 'العلامات';

  @override
  String get bookmarkVerse => 'حفظ علامة على هذه الآية';

  @override
  String get bookmarkVerseSuccess => 'تم حفظ علامة على آية رقم ';

  @override
  String get calculate_easily => 'احسب زكاتك بسهولة ودقة';

  @override
  String get calculate_zakat => 'احسب الزكاة';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get cause_of_allah => 'في سبيل الله';

  @override
  String get cause_of_allah_desc => 'لدعم الدعوة والخير.';

  @override
  String get changeFontSize => 'تغيير حجم الخط';

  @override
  String get changeLanguage => 'تغيير اللغه';

  @override
  String get changeReciterSuccess => 'تم تغيير القارئ إلى ';

  @override
  String get changeTheme => 'تغيير المظهر';

  @override
  String get chapters => 'الأبواب';

  @override
  String get chaptersEmpty => 'لا توجد أبواب';

  @override
  String get chaptersSearch => 'ابحث عن باب...';

  @override
  String get chooseGoal => 'تحديد الهدف';

  @override
  String get clear => 'إزالة الهدف';

  @override
  String get collectors => 'العاملين عليها';

  @override
  String get collectors_desc => 'من يجمعون الزكاة ويوزعونها.';

  @override
  String get compassLoading => 'جاري تجهيز البوصلة...';

  @override
  String get completeTasbeh => 'لقد أكملت';

  @override
  String get condition_1 => 'أن يكون المسلم حرًّا مالكًا للنصاب.';

  @override
  String get condition_2 =>
      'أن يبلغ المال النصاب (ما يعادل 85 جرام ذهب تقريبًا).';

  @override
  String get condition_3 => 'أن يمر على المال حول كامل (سنة هجرية).';

  @override
  String get condition_4 => 'أن يكون المال ناميًا أو قابلًا للنماء.';

  @override
  String get conditions => 'تجب الزكاة عند توافر هذه الشروط:';

  @override
  String get congrates => 'تهانينا ';

  @override
  String get continueTasbeh => 'أكمل';

  @override
  String get crops => 'الزروع';

  @override
  String crops_zakat_description(
    Object machine_rate,
    Object natural_rate,
    Object nisab_kg,
  ) {
    return 'تجب الزكاة إذا بلغ المحصول $nisab_kg كجم تقريبًا.\n\n$natural_rate% إن كانت تُسقى بماء المطر أو الأنهار\n$machine_rate% إن كانت بالآلات (مكلفة السقي)';
  }

  @override
  String get crops_zakat_hint => 'أدخل كمية المحصول بالكيلوجرام';

  @override
  String get crops_zakat_title => '🌾 زكاة الزروع والثمار';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get debtors => 'الغارمين';

  @override
  String get debtors_desc => 'من أثقلهم الدين.';

  @override
  String get defultFont => 'افتراضي';

  @override
  String get deleteBookmark => 'حذف العلامة';

  @override
  String get deleteBookmarkQuestion =>
      'هل أنت متأكد أنك تريد حذف العلامة من سورة';

  @override
  String get deleteBookmarkSuccess => 'تم حذف العلامة من سورة';

  @override
  String get deleteButton => 'حذف';

  @override
  String get distanceToKabaa => 'المسافة إلى الكعبة:';

  @override
  String get due_zakat => 'الزكاة المستحقة';

  @override
  String get emptyBookmarks => 'لا توجد علامات بعد';

  @override
  String get savedHadithsEmpty => 'لا توجد أحاديث محفوظة بعد';

  @override
  String get emptyTafsir => 'لا يوجد تفسير متاح حاليًا';

  @override
  String get englishLanguage => 'الانجليزية';

  @override
  String get enter_amount => 'أدخل قيمة أموالك وسنحسب لك مقدار الزكاة الواجبة';

  @override
  String get errorMain => 'حدث خطأ:';

  @override
  String get fullMapQiblah => 'خريطة القبلة';

  @override
  String get goal => 'الهدف';

  @override
  String get goalExample => 'ضع هدفك (مثلاً 50)';

  @override
  String get gold => 'الذهب';

  @override
  String get gold_price_error => 'تعذر تحميل سعر الذهب';

  @override
  String gold_zakat_description(
    Object current_price,
    Object nisab_grams,
    Object percentage,
  ) {
    return 'النصاب في الذهب هو $nisab_grams جرام.\nالنسبة: $percentage% من القيمة السوقية للذهب.\n\nسعر الجرام الحالي: $current_price جنيه';
  }

  @override
  String get gold_zakat_hint => 'أدخل وزن الذهب بالجرام';

  @override
  String get gold_zakat_title => '🪙 زكاة الذهب';

  @override
  String get hadith => 'قال النبي ﷺ: \"لا زكاة في مال حتى يحول عليه الحول.\"';

  @override
  String get hadithBooks => 'كتب الحديث';

  @override
  String get hadithSources => 'مصادر الأحاديث';

  @override
  String get hadithBooksEmpty => 'لا توجد كتب متاحة';

  @override
  String get hadithBooksError => 'فشل في جلب الكتب';

  @override
  String get hadithBooksSearch => 'ابحث باسم الكتاب...';

  @override
  String get hadithButton => 'الحديث';

  @override
  String get hadithError => 'فشل في تحميل الأحاديث';

  @override
  String get hadithStatus => 'الحكم';

  @override
  String get hadithsTitle => 'الأحاديث';

  @override
  String get homeTitle => 'الصفحة الرئيسية';

  @override
  String get invalid_input_error => 'الرجاء إدخال قيمة صحيحة';

  @override
  String get lightMode => 'الوضع النهاري';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get loading_gold_price => 'جاري تحميل سعر الذهب...';

  @override
  String get machine_irrigation_subtitle => 'السقي بالآلات أو بتكاليف';

  @override
  String machine_irrigation_title(Object rate) {
    return '⚙️ آلة أو مكلف ($rate%)';
  }

  @override
  String get money => 'المال';

  @override
  String money_zakat_description(Object nisab, Object percentage) {
    return 'تجب الزكاة في المال إذا بلغ النصاب ($nisab جنيه تقريبًا) ومر عليه حول قمري كامل.\n\nالنسبة: $percentage% من إجمالي المال المدخر';
  }

  @override
  String get money_zakat_hint => 'أدخل إجمالي المال المدخر بالجنيه';

  @override
  String get money_zakat_title => '💰 زكاة المال';

  @override
  String get morePrayerTimesButton => 'اضغط لعرض المزيد من أوقات الصلاة';

  @override
  String get my_zakat => 'زكاتي';

  @override
  String get namesOfAllah => 'أسماء الله الحسنى';

  @override
  String get natural_irrigation_subtitle => 'السقي الطبيعي بدون تكاليف';

  @override
  String natural_irrigation_title(Object rate) {
    return '💧 مطر أو أنهار ($rate%)';
  }

  @override
  String get needy => 'المساكين';

  @override
  String get needy_desc => 'من يملك بعض حاجته ولكن لا يكفيه.';

  @override
  String get new_muslims => 'المؤلفة قلوبهم';

  @override
  String get new_muslims_desc => 'من يُراد تأليف قلوبهم على الإسلام.';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get note =>
      'ملاحظة: الزكاة واجبة على المال المدخر الذي بلغ النصاب ومر عليه الحول.';

  @override
  String get numberOfChapters => 'عدد الأبواب:';

  @override
  String get numberOfHadiths => 'عدد الأحاديث:';

  @override
  String get okButton => 'حسنًا';

  @override
  String get playVerseSound => 'تشغيل من هذه الآية';

  @override
  String get poor => 'الفقراء';

  @override
  String get poor_desc => 'من لا يملك قوت يومه.';

  @override
  String get prayerTimesText => 'مواقيت الصلاة';

  @override
  String get privacy => 'سياسة الخصوصية';

  @override
  String get qiblahButton => 'القبلة';

  @override
  String get qiblahDirection => 'اتجاه القبلة';

  @override
  String get quran_text =>
      'إِنَّمَا الصَّدَقَاتُ لِلْفُقَرَاءِ وَالْمَسَاكِينِ وَالْعَامِلِينَ عَلَيْهَا وَالْمُؤَلَّفَةِ قُلُوبُهُمْ وَفِي الرِّقَابِ وَالْغَارِمِينَ وَفِي سَبِيلِ اللَّهِ وَابْنِ السَّبِيلِ';

  @override
  String get quran_verse => 'قال الله تعالى:';

  @override
  String get quranButton => 'القرآن';

  @override
  String get quranText => 'القرآن الكريم';

  @override
  String get refresh_gold_price => 'تحديث سعر الذهب';

  @override
  String get reset => 'إعادة';

  @override
  String get resetTasbeh => 'إعادة من البداية';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get revision => 'المرجع';

  @override
  String get salahDirection => 'مُحاذٍ للكعبة';

  @override
  String get save => 'حفظ ';

  @override
  String get searchForSurahName => 'ابحث باسم السورة...';

  @override
  String get searchResult => 'نتائج البحث:';

  @override
  String get sebha => 'السبحة';

  @override
  String get sebhaTitle => 'السبحة الإلكترونية';

  @override
  String get selectFontSize => 'اختر حجم الخط';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get selectReciter => 'اختر القارئ';

  @override
  String get selectTafsir => 'اختر التفسير';

  @override
  String get selectTheme => 'اختيار المظهر';

  @override
  String get settingsButton => 'الإعدادات';

  @override
  String get shareTafsir => 'مشاركة التفسير';

  @override
  String get slaves => 'في الرقاب';

  @override
  String get slaves_desc => 'لتحرير الأسرى أو المديونين ظلمًا.';

  @override
  String get smallFont => 'صغير';

  @override
  String get start_calculation => 'ابدأ حساب الزكاة';

  @override
  String get surahsText => 'السور';

  @override
  String get systemMode => 'حسب النظام';

  @override
  String get tafsirVerse => 'تفسير الآية';

  @override
  String get tasbehQuestion => 'هل تريد إعادة العد من البداية أم تكمل';

  @override
  String get tasbih => 'التسبيح';

  @override
  String get trade => 'التجارة';

  @override
  String trade_zakat_description(Object nisab, Object percentage) {
    return 'تحسب الزكاة على: (قيمة البضائع + النقد - الديون) × $percentage%\n\nتجب بعد مرور الحول.\nالنصاب: $nisab جنيه';
  }

  @override
  String get trade_zakat_hint => 'أدخل صافي أصول التجارة بالجنيه';

  @override
  String get trade_zakat_title => '🛍️ زكاة التجارة';

  @override
  String get traveler => 'ابن السبيل';

  @override
  String get traveler_desc => 'المسافر المنقطع عن بلده.';

  @override
  String get unit_kg => 'كجم';

  @override
  String get updatePrayerTimes => 'تحديث مواقيت الصلاة';

  @override
  String get version => 'الإصدار';

  @override
  String get when_zakat_due => 'متى تجب الزكاة؟';

  @override
  String get writer => 'المؤلف';

  @override
  String get zakat => 'زكاتي';

  @override
  String get zakat_calculator => 'حاسبة الزكاة';

  @override
  String get zakat_for_whom => 'لمن الزكاة؟';

  @override
  String get zakat_reminder =>
      'تذكر: الزكاة واجبة فقط إذا بلغ المال النصاب ومر عليه الحول';

  @override
  String get zakatDuaa => 'قال ﷺ: ما نقص مالٌ من صدقةٍ.';

  @override
  String get zakatStart => 'ابدأ الآن بحساب زكاتك وتذكّر فضلها العظيم';

  @override
  String get aboutUs => 'من نحن';

  @override
  String get appNotifications => 'إشعارات التطبيق';

  @override
  String get enablePrayerNotifications => 'تفعيل إشعارات الأذان';

  @override
  String get enableQuranReminders => 'تفعيل إشعارات تذكير القرآن';

  @override
  String get prayerNotificationsEnabled => 'تم تفعيل إشعارات الأذان';

  @override
  String get prayerNotificationsDisabled => 'تم تعطيل إشعارات الأذان';

  @override
  String get quranRemindersEnabled => 'تم تفعيل إشعارات تذكير القرآن';

  @override
  String get quranRemindersDisabled => 'تم تعطيل إشعارات تذكير القرآن';

  @override
  String get quranReminderTitle => '📖 تذكير بقراءة القرآن';

  @override
  String get quranReminderBody => 'لا تنس وردك من القرآن الكريم 🌿';

  @override
  String get allServices => 'كل الخدمات';

  @override
  String get addCustomTasbih => 'إضافة تسبيح خاص';

  @override
  String get editTasbih => 'تعديل التسبيح';

  @override
  String get deleteTasbih => 'حذف التسبيح';

  @override
  String get deleteTasbihConfirm => 'هل أنت متأكد من حذف هذا التسبيح؟';

  @override
  String get tasbihTextAr => 'نص التسبيح بالعربية';

  @override
  String get tasbihTextEn => 'نص التسبيح بالإنجليزية';

  @override
  String get tasbihGoal => 'الهدف';

  @override
  String get tasbihTextArHint => 'مثال: أستغفر الله';

  @override
  String get tasbihTextEnHint => 'Example: Astaghfirullah';

  @override
  String get tasbihGoalHint => 'مثال: 100';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get goalMustBePositive => 'الهدف يجب أن يكون أكبر من صفر';
}
