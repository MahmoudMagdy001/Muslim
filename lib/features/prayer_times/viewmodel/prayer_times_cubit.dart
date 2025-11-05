import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/service/permissions_sevice.dart';
import '../model/prayer_times_model.dart';
import '../service/prayer_calculator_service.dart';
import '../service/prayer_notification_service.dart';
import '../service/prayer_times_service.dart';
import 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit() : super(const PrayerTimesState()) {
    _prayerTimesService = PrayerTimesService();
    _notificationService = PrayerNotificationService();
    _calculatorService = PrayerCalculatorService();
  }

  late final PrayerTimesService _prayerTimesService;
  late final PrayerNotificationService _notificationService;
  late final PrayerCalculatorService _calculatorService;

  Timer? _timer;
  Timer? _midnightTimer;

  /// التهيئة وجلب مواقيت الصلاة
  Future<void> init({required bool isArabic}) async {
    await fetchPrayerTimes(isArabic: isArabic);
  }

  Future<void> checkAllPermissions() async {
    emit(state.copyWith(status: PrayerTimesStatus.checkingPermissions));
    await requestAllPermissions();
    try {
      debugPrint('✅ تم التحقق من جميع الصلاحيات بنجاح');
    } catch (error) {
      debugPrint('❌ خطأ في التحقق من الصلاحيات: $error');
      emit(
        state.copyWith(
          status: PrayerTimesStatus.permissionError,
          message: 'يجب منح الصلاحيات المطلوبة لعرض مواقيت الصلاة',
        ),
      );
    }
  }

  /// جلب مواقيت الصلاة
  Future<void> fetchPrayerTimes({required bool isArabic}) async {
    emit(state.copyWith(status: PrayerTimesStatus.loading));

    try {
      final localPrayerTimes = await _prayerTimesService.getPrayerTimes(
        isArabic: isArabic,
      );
      await _handlePrayerTimesSuccess(localPrayerTimes);
    } catch (error) {
      _handlePrayerTimesError(error);
    }
  }

  /// معالجة نجاح جلب مواقيت الصلاة
  Future<void> _handlePrayerTimesSuccess(LocalPrayerTimes times) async {
    await _notificationService.schedulePrayerNotifications(times);
    _updateStateWithPrayerTimes(times);
    _startCountdown();
  }

  /// تحديث الحالة بمواقيت الصلاة
  void _updateStateWithPrayerTimes(LocalPrayerTimes times) {
    final calculation = _calculatorService.calculateNextPrayer(times);

    emit(
      state.copyWith(
        status: PrayerTimesStatus.success,
        localPrayerTimes: times,
        nextPrayer: calculation.nextPrayer,
        timeLeft: calculation.timeLeft,
        lastUpdated: DateTime.now(),
        city: times.city,
      ),
    );
  }

  /// معالجة خطأ جلب مواقيت الصلاة
  void _handlePrayerTimesError(Object error) {
    emit(
      state.copyWith(
        status: PrayerTimesStatus.error,
        message: 'من فضلك فعل الاشعارات للحصول علي مواقيت الصلاه',
      ),
    );
  }

  /// بدء العد التنازلي
  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  /// تحديث العد التنازلي
  void _updateCountdown() {
    final currentTimes = state.localPrayerTimes;
    if (currentTimes == null) return;

    final calculation = _calculatorService.calculateNextPrayer(currentTimes);

    // إذا انتهى وقت الصلاة، نحدث الجدولة
    if (calculation.timeLeft.inSeconds <= 0) {
      debugPrint('🔄 انتهى وقت الصلاة، جاري تحديث الجدولة...');
      _handlePrayerTimesSuccess(currentTimes);
    } else {
      emit(
        state.copyWith(
          nextPrayer: calculation.nextPrayer,
          timeLeft: calculation.timeLeft,
        ),
      );
    }
  }

  /// تحديث يدوي لمواقيت الصلاة
  Future<void> refreshPrayerTimes({required bool isArabic}) async {
    debugPrint('🔄 تحديث يدوي لمواعيد الصلاة...');
    await checkAllPermissions();
    init(isArabic: isArabic);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _midnightTimer?.cancel();
    return super.close();
  }
}
