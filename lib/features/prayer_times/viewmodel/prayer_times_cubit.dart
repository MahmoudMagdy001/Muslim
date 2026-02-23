import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/service/permissions_sevice.dart';
import '../../../core/utils/app_logger.dart';
import '../helper/notification_constants.dart';
import '../models/prayer_times_model.dart';
import '../models/prayer_type.dart';
import '../repositories/prayer_notification_repository.dart';
import '../repositories/prayer_times_repository.dart';
import '../services/prayer_calculator_service.dart';
import 'prayer_times_state.dart';

/// Cubit managing prayer times state, notification scheduling,
/// and per-prayer notification settings.
class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit({
    PrayerTimesRepository? prayerTimesRepository,
    PrayerNotificationRepository? notificationRepository,
    PrayerCalculatorService? calculatorService,
  }) : _prayerTimesRepository =
           prayerTimesRepository ?? getIt<PrayerTimesRepository>(),
       _notificationRepository =
           notificationRepository ?? getIt<PrayerNotificationRepository>(),
       _calculatorService =
           calculatorService ?? getIt<PrayerCalculatorService>(),
       super(const PrayerTimesState());

  final PrayerTimesRepository _prayerTimesRepository;
  final PrayerNotificationRepository _notificationRepository;
  final PrayerCalculatorService _calculatorService;

  Timer? _timer;
  Timer? _midnightTimer;

  /// Initializes prayer times and loads notification settings.
  Future<void> init({required bool isArabic}) async {
    await loadNotificationSettings();
    await fetchPrayerTimes(isArabic: isArabic);
  }

  /// Checks if data is loaded, if not, initializes it.
  /// Call this in the UI (e.g., BlocBuilder or onInit of the view)
  Future<void> checkInitialData({required bool isArabic}) async {
    if (state.status == RequestStatus.initial) {
      await init(isArabic: isArabic);
    }
  }

  /// Checks and requests all required permissions.
  Future<void> checkAllPermissions() async {
    if (!isClosed) emit(state.copyWith(status: RequestStatus.loading));
    try {
      await requestAllPermissions();
      logSuccess('تم التحقق من جميع الصلاحيات بنجاح');
    } catch (error) {
      logError('خطأ في التحقق من الصلاحيات', error);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: RequestStatus.failure,
            message: 'يجب منح الصلاحيات المطلوبة لعرض مواقيت الصلاة',
          ),
        );
      }
    }
  }

  /// Fetches prayer times for today.
  Future<void> fetchPrayerTimes({required bool isArabic}) async {
    if (!isClosed) emit(state.copyWith(status: RequestStatus.loading));

    try {
      final localPrayerTimes = await _prayerTimesRepository.getPrayerTimes(
        isArabic: isArabic,
      );
      await _handlePrayerTimesSuccess(localPrayerTimes);
    } catch (error) {
      _handlePrayerTimesError(error);
    }
  }

  /// Handles successful prayer times fetch — schedules notifications
  /// and updates state.
  Future<void> _handlePrayerTimesSuccess(LocalPrayerTimes times) async {
    final List<LocalPrayerTimes> allScheduledTimes = [times];

    try {
      final coordinates = await _prayerTimesRepository.getCachedCoordinates();
      if (coordinates != null) {
        final now = DateTime.now();
        for (int i = 1; i < NotificationConstants.scheduleDaysAhead; i++) {
          final nextDate = now.add(Duration(days: i));
          final nextDayTimes = await _prayerTimesRepository
              .getPrayerTimesForDate(
                coordinates,
                nextDate,
                cityName: times.city,
              );
          allScheduledTimes.add(nextDayTimes);
        }
      }
    } catch (e) {
      logWarning('تعذر جلب أوقات الأيام القادمة في الـ Cubit: $e');
    }

    await _notificationRepository.scheduleNotifications(allScheduledTimes);
    _updateStateWithPrayerTimes(times);
    _startCountdown();
  }

  /// Updates state with prayer calculation results.
  void _updateStateWithPrayerTimes(LocalPrayerTimes times) {
    final calculation = _calculatorService.calculateNextPrayer(times);

    if (!isClosed) {
      emit(
        state.copyWith(
          status: RequestStatus.success,
          localPrayerTimes: times,
          nextPrayer: calculation.nextPrayer,
          timeLeft: calculation.timeLeft,
          previousPrayerDateTime: calculation.previousPrayerDateTime,
          lastUpdated: DateTime.now(),
          city: times.city,
        ),
      );
    }
  }

  void _handlePrayerTimesError(Object error) {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: RequestStatus.failure,
          message: 'من فضلك فعل الاشعارات للحصول علي مواقيت الصلاه',
        ),
      );
    }
  }

  /// Starts a per-second countdown for the next prayer.
  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final currentTimes = state.localPrayerTimes;
    if (currentTimes == null) return;

    final calculation = _calculatorService.calculateNextPrayer(currentTimes);

    if (calculation.timeLeft.inSeconds <= 0) {
      logInfo('🔄 انتهى وقت الصلاة، جاري تحديث الجدولة...');
      _handlePrayerTimesSuccess(currentTimes);
    } else {
      if (!isClosed) {
        emit(
          state.copyWith(
            nextPrayer: calculation.nextPrayer,
            timeLeft: calculation.timeLeft,
            previousPrayerDateTime: calculation.previousPrayerDateTime,
          ),
        );
      }
    }
  }

  /// Loads per-prayer notification settings into state.
  Future<void> loadNotificationSettings() async {
    try {
      final settings = await _notificationRepository.getSettings();
      if (!isClosed) emit(state.copyWith(notificationSettings: settings));
    } catch (e) {
      logWarning('تعذر تحميل إعدادات الإشعارات: $e');
    }
  }

  /// Toggles notification for a specific prayer and reschedules.
  Future<void> togglePrayerNotification(
    PrayerType type, {
    required bool enabled,
  }) async {
    // Optimistically update UI
    final updatedSettings = state.notificationSettings.copyWithPrayer(
      type,
      enabled: enabled,
    );
    if (!isClosed) emit(state.copyWith(notificationSettings: updatedSettings));

    // Persist and reschedule
    await _notificationRepository.setPrayerEnabled(type, enabled: enabled);

    if (state.localPrayerTimes != null) {
      final List<LocalPrayerTimes> times = [state.localPrayerTimes!];
      try {
        final coordinates = await _prayerTimesRepository.getCachedCoordinates();
        if (coordinates != null) {
          final now = DateTime.now();
          for (int i = 1; i < NotificationConstants.scheduleDaysAhead; i++) {
            final date = now.add(Duration(days: i));
            times.add(
              await _prayerTimesRepository.getPrayerTimesForDate(
                coordinates,
                date,
                cityName: state.localPrayerTimes!.city,
              ),
            );
          }
        }
      } catch (_) {}
      await _notificationRepository.scheduleNotifications(times);
    }
  }

  /// Manual refresh of prayer times.
  Future<void> refreshPrayerTimes({required bool isArabic}) async {
    logInfo('🔄 تحديث يدوي لمواعيد الصلاة...');
    await checkAllPermissions();
    await init(isArabic: isArabic);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _midnightTimer?.cancel();
    return super.close();
  }
}
