import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../model/hadith_model.dart';
import '../../service/hadith/hadith_service.dart';
import 'hadith_state.dart';
import '../../service/hadith/hadith_storage_service.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit({
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
    HadithService? hadithService,
    HadithStorageService? storageService,
  }) : _hadithService = hadithService ?? getIt<HadithService>(),
       _storageService = storageService ?? getIt<HadithStorageService>(),
       super(const HadithState());

  final String bookSlug;
  final String chapterNumber;
  final String chapterName;

  final HadithService _hadithService;
  final HadithStorageService _storageService;

  final Map<String, ValueNotifier<bool>> _hadithSavedMap = {};

  bool isHadithSaved(String hadithId) =>
      _hadithSavedMap[hadithId]?.value ?? false;

  ValueNotifier<bool>? getHadithNotifier(String hadithId) =>
      _hadithSavedMap[hadithId];

  Future<void> initializeData() async {
    emit(state.copyWith(status: HadithStatus.loading));

    try {
      // تحميل البيانات المحفوظة أولاً
      final savedHadiths = await _storageService.loadSavedHadiths();

      // إعداد الـ notifiers للحديث المحفوظة
      for (final h in savedHadiths) {
        _hadithSavedMap[h['id'].toString()] = ValueNotifier(true);
      }

      // تحميل الأحاديث
      final hadiths = await _hadithService.fetchHadithsForChapter(
        bookSlug: bookSlug,
        chapterNumber: chapterNumber,
      );

      // إعداد الـ keys والـ notifiers بشكل غير متزامن
      await _prepareHadithData(hadiths);

      emit(
        state.copyWith(
          status: HadithStatus.success,
          hadiths: hadiths,
          savedHadiths: savedHadiths,
          dataLoaded: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HadithStatus.error,
          message: 'Failed to load hadiths: $e',
        ),
      );
    }
  }

  Future<void> _prepareHadithData(List<HadithModel> hadiths) async {
    // تقسيم العملية إلى مهام صغيرة لتجنب حجب الـ UI
    for (var i = 0; i < hadiths.length; i++) {
      final hadith = hadiths[i];

      if (!_hadithSavedMap.containsKey(hadith.id)) {
        _hadithSavedMap[hadith.id] = ValueNotifier(false);
      }

      // إعطاء فرصة للـ UI للتحديث كل 10 أحاديث
      if (i % 10 == 0) {
        await Future.delayed(const Duration(milliseconds: 1));
      }
    }
  }

  Future<void> toggleHadithSave(HadithModel hadith, bool isArabic) async {
    final id = hadith.id;

    if (!_hadithSavedMap.containsKey(id)) {
      _hadithSavedMap[id] = ValueNotifier(false);
    }

    final notifier = _hadithSavedMap[id]!;

    try {
      if (notifier.value) {
        await _storageService.removeHadith(id);
        notifier.value = false;
      } else {
        final data = {
          'id': hadith.id,
          'heading': isArabic ? hadith.headingArabic : hadith.headingEnglish,
          'text': isArabic ? hadith.hadithArabic : hadith.hadithEnglish,
          'status': isArabic
              ? _statusMap[hadith.status] ?? hadith.status
              : hadith.status,
          'bookSlug': bookSlug,
          'chapterNumber': chapterNumber,
          'chapterName': chapterName,
        };
        await _storageService.saveHadith(data);
        notifier.value = true;
      }
    } catch (e) {
      rethrow;
    }
  }

  static const Map<String, String> _statusMap = {
    'Sahih': 'صحيح',
    'sahih': 'صحيح',
    'Hasan': 'حسن',
    'hasan': 'حسن',
    'Da`eef': 'ضعيف',
    'da`eef': 'ضعيف',
  };

  String getStatus(String status, bool isArabic) =>
      isArabic ? _statusMap[status] ?? status : status;
}
