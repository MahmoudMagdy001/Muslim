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
    String nisab_kg,
    String natural_rate,
    String machine_rate,
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
  String get gold_price_error =>
      'فشل في جلب سعر الذهب. يرجى التحقق من اتصالك بالإنترنت أو إدخال السعر يدوياً.';

  @override
  String gold_zakat_description(
    String nisab_grams,
    String percentage,
    String current_price,
  ) {
    return 'النصاب في الذهب هو $nisab_grams جرام.\nالنسبه: $percentage% من القيمة السوقية للذهب.\n\nسعر الجرام الحالي: $current_price جنيه';
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
  String machine_irrigation_title(String rate) {
    return '⚙️ آلة أو مكلف ($rate%)';
  }

  @override
  String get money => 'المال';

  @override
  String money_zakat_description(String nisab, String percentage) {
    return 'تجب الزكاة في المال إذا بلغ النصاب ($nisab جنيه تقريبًا) ومر عليه حول قمري كامل.\n\nالنسبه: $percentage% من إجمالي المال المدخر';
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
  String natural_irrigation_title(String rate) {
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
  String get qiblahSubtitle => 'وجّه هاتفك نحو القبلة';

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
  String get juzText => 'الجزء';

  @override
  String get hizbText => 'الحزب';

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
  String trade_zakat_description(String percentage, String nisab) {
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
  String get enablePrayerNotifications => 'إشعارات الأذان';

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

  @override
  String get updateAvailableTitle => 'تحديث جديد متاح';

  @override
  String get updateAvailableMessage =>
      'تم إصدار نسخة جديدة من تطبيق المسلم.\nهل ترغب في التحديث الآن لتحصل على أحدث المزايا والتحسينات؟';

  @override
  String get updateNowButton => 'تحديث الآن';

  @override
  String get laterButton => 'لاحقًا';

  @override
  String get rateAppMessage => '🌟 شكراً لتقييمك!';

  @override
  String get rateAppSuccess => 'تم التقييم بنجاح';

  @override
  String get rateAppButton => 'تقييم التطبيق';

  @override
  String get enterGoldPriceManually => 'إدخال سعر الذهب يدوياً';

  @override
  String get goldPricePerGram => 'سعر الجرام (عيار 24)';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get privacyMatters => 'خصوصيتك تهمنا';

  @override
  String get noPersonalData => 'نحن لا نجمع أي بيانات شخصية على الإطلاق';

  @override
  String get privacyPrinciples => 'مبادئ الخصوصية';

  @override
  String get noAccounts => 'لا يوجد حسابات';

  @override
  String get noAccountsDesc => 'التطبيق لا يتطلب إنشاء حساب أو تسجيل دخول';

  @override
  String get noTracking => 'لا تتبع';

  @override
  String get noTrackingDesc => 'لا نتابع أو نراقب استخدامك للتطبيق';

  @override
  String get noPurchases => 'لا مشتريات';

  @override
  String get noPurchasesDesc => 'لا توجد عمليات شراء داخل التطبيق';

  @override
  String get locationDataTitle => 'بيانات الموقع (Location)';

  @override
  String get locationPurpose =>
      '• الغرض: حساب مواقيت الصلاة بدقة واتجاه القبلة.';

  @override
  String get locationAccessMethod =>
      '• طريقة الوصول: يتم الوصول للموقع فقط أثناء استخدامك للتطبيق (Foreground) لتحديث الإحداثيات.';

  @override
  String get locationStorage =>
      '• التخزين: يتم حفظ آخر إحداثيات معروفة محلياً على جهازك لضمان استمرارية عمل التنبيهات بدقة حتى في حالة عدم الاتصال.';

  @override
  String get locationPrivacy =>
      '• الخصوصية: لا يتم إرسال بيانات موقعك لأي خادم خارجي ولا يتم مشاركتها مع أي طرف ثالث.';

  @override
  String get dataCollectionInfo => 'معلومات جمع البيانات';

  @override
  String get dataCollectionDesc =>
      'التطبيق لا يجمع أي بيانات شخصية. كل المعلومات تبقى على جهازك فقط ولا نصل إليها بأي شكل من الأشكال.';

  @override
  String get localStorage => 'التخزين المحلي';

  @override
  String get storageQuranBookmarks => 'الإشارات المرجعية لآيات القرآن';

  @override
  String get storageSavedHadith => 'الأحاديث المحفوظة';

  @override
  String get storageNotificationSettings => 'إعدادات التنبيهات والأذان';

  @override
  String get storageLangTheme => 'تفضيلات اللغة والمظهر';

  @override
  String get storageFontSizeReciters => 'حجم الخط والقراء المفضلين';

  @override
  String get storageLocationCoordinates => 'إحداثيات الموقع (محلياً فقط)';

  @override
  String get haveQuestions => 'لديك استفسارات؟';

  @override
  String get privacyHelp => 'نحن هنا لمساعدتك في أي استفسار حول الخصوصية';

  @override
  String get contactEmail => 'اتصل بنا عبر البريد الإلكتروني';

  @override
  String get cannotOpenEmail => 'لا يمكن فتح تطبيق البريد الإلكتروني';

  @override
  String get lastUpdated => 'آخر تحديث';

  @override
  String get muslimAppTitle => 'تطبيق مُسَلِّم';

  @override
  String get aboutUsDescription =>
      'تطبيق مُسَلِّم هو رفيقك اليومي لتذكيرك بالصلاة وقراءة القرآن والأذكار، صُمم بعناية لتوفير تجربة روحانية سهلة وبسيطة في حياتك اليومية.';

  @override
  String get connectWithUs => 'تواصل معنا';

  @override
  String get sendEmail => 'إرسال بريد إلكتروني';

  @override
  String get visitWebsite => 'زيارة موقعنا';

  @override
  String get emailContactSubject => 'تواصل بخصوص التطبيق - مُسَلِّم';

  @override
  String get emailPrivacySubject => 'استفسار عن سياسة الخصوصية - مُسَلِّم';

  @override
  String get periodicReminderTitle => 'التذكير الدوري';

  @override
  String everyNMinutes(int minutes) {
    return 'كل $minutes دقيقة';
  }

  @override
  String get egpUnit => 'جنيه';

  @override
  String get makkiyah => 'مكية';

  @override
  String get madaniyah => 'مدنية';

  @override
  String get selectTimeInterval => 'اختر الفاصل الزمني';

  @override
  String nMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get fajr => 'الفجر';

  @override
  String get sunrise => 'الشروق';

  @override
  String get dhuhr => 'الظهر';

  @override
  String get asr => 'العصر';

  @override
  String get maghrib => 'المغرب';

  @override
  String get isha => 'العشاء';

  @override
  String get jumuah => 'الجمعة';

  @override
  String get autoLocationUpdates => 'تحديث الموقع تلقائياً';

  @override
  String get autoLocationSubtitle =>
      'تحديث مواقيت الصلاة بناءً على موقعك الحالي';

  @override
  String get autoLocationEnabled => 'تم تفعيل التحديث التلقائي للموقع';

  @override
  String get autoLocationDisabled => 'تم تعطيل التحديث التلقائي للموقع';

  @override
  String versesCount(int count) {
    return '$count آيات';
  }

  @override
  String juzNumberLabel(int number) {
    return 'الجزء $number';
  }

  @override
  String hizbNumberLabel(int number) {
    return 'الحزب $number';
  }

  @override
  String ayahNumberLabel(int number) {
    return 'الآية $number';
  }

  @override
  String surahNumberLabel(int number) {
    return 'سورة رقم $number';
  }

  @override
  String get noResultsFound => 'لا توجد نتائج';

  @override
  String get emptyTafsirText => 'نص التفسير فارغ';

  @override
  String get failedSplitTafsir => 'فشل تقسيم نص التفسير';

  @override
  String get meaningLabel => 'المعنى';

  @override
  String get shareError => 'حدث خطأ أثناء المشاركة';

  @override
  String get namesOfAllahShareText =>
      'أسماء الله الحسنى - مشاركة من تطبيق مُسَلِّم';

  @override
  String get sharedFromMuslimApp => 'تمت المشاركة من تطبيق مُسَلِّم';

  @override
  String get ayatText => 'الآيات';

  @override
  String get tourNext => 'التالي';

  @override
  String get tourSkip => 'تخطي';

  @override
  String get tourDone => 'فهمت';

  @override
  String get tourPrayerTimesTitle => 'مواقيت الصلاة والأذان';

  @override
  String get tourPrayerTimesMessage =>
      'متابعة مواقيت الصلاة القادمة وإعدادات الموقع.';

  @override
  String get tourZakatTitle => 'حاسبة الزكاة';

  @override
  String get tourZakatMessage =>
      'احسب زكاتك بسهولة وتعرف على مصارف الزكاة المستحقة.';

  @override
  String get tourServicesTitle => 'الخدمات الإسلامية';

  @override
  String get tourServicesMessage =>
      'تصفح القرآن الكريم، الأحاديث، الأذكار، السبحة، وأسماء الله.';

  @override
  String get tourSettingsTitle => 'إعدادات التطبيق';

  @override
  String get tourSettingsMessage =>
      'خصص اللغة، المظهر، حجم الخط، واختيار القارئ.';

  @override
  String get tourQuranTitle => 'القرآن الكريم';

  @override
  String get tourQuranMessage => 'تصفح السور والأجزاء والأحزاب بسهولة.';

  @override
  String get tourBookmarksTitle => 'الفواصل والتحفيظ';

  @override
  String get tourBookmarksMessage =>
      'الوصول السريع إلى العلامات المرجعية المحفوظة.';

  @override
  String get tourHadithTitle => 'موسوعة الأحاديث';

  @override
  String get tourHadithMessage => 'استكشف كتب الحديث الشريف والحديث اليومي.';

  @override
  String get tourSavedHadithTitle => 'الأحاديث المحفوظة';

  @override
  String get tourSavedHadithMessage =>
      'استعرض الأحاديث النبوية التي قمت بحفظها.';

  @override
  String get tourSebhaTitle => 'السبحة الإلكترونية';

  @override
  String get tourSebhaMessage => 'اضغط على الزر لتسبيح الله وحساب الأذكار.';

  @override
  String get tourAddZikrTitle => 'إضافة ذكر خاص';

  @override
  String get tourAddZikrMessage => 'أضف أذكارك الخاصة وحدد الأهداف اليومية.';

  @override
  String get tourAzkarTitle => 'الأذكار اليومية';

  @override
  String get tourAzkarMessage =>
      'أذكار الصباح والمساء والمناسبات مرتبة ومبوبة.';

  @override
  String get tourNamesOfAllahTitle => 'أسماء الله الحسنى';

  @override
  String get tourNamesOfAllahMessage =>
      'اقرأ المعاني وشارك بطاقات أسماء الله الحسنى.';

  @override
  String get tourQiblahTitle => 'بوصلة القبلة';

  @override
  String get tourQiblahMessage =>
      'وجه جهازك للتعرف على اتجاه الكعبة المشرفة بدقة.';
}
