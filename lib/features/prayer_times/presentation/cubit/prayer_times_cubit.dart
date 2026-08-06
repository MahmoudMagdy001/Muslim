import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/service/permissions_sevice.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:muslim/features/prayer_times/domain/usecases/calculate_next_prayer_usecase.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_state.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_constants.dart';

/// Cubit managing prayer times state, notification scheduling,
/// and per-prayer notification settings.
class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit({
    this.locationGranted = false,
    PrayerTimesRepository? prayerTimesRepository,
    PrayerNotificationRepository? prayerNotificationRepository,
    CalculateNextPrayerUseCase? calculateNextPrayerUseCase,
  }) : _prayerTimesRepo =
           prayerTimesRepository ?? getIt<PrayerTimesRepository>(),
       _notificationRepo =
           prayerNotificationRepository ?? getIt<PrayerNotificationRepository>(),
       _calculateNextPrayer =
           calculateNextPrayerUseCase ?? getIt<CalculateNextPrayerUseCase>(),
       super(const PrayerTimesState());

  // ponytail: allow locationGranted to be updated dynamically after post-frame permission request
  bool locationGranted;

  final PrayerTimesRepository _prayerTimesRepo;
  final PrayerNotificationRepository _notificationRepo;
  final CalculateNextPrayerUseCase _calculateNextPrayer;

  Timer? _timer;
  Timer? _initialDelayTimer;
  Timer? _midnightTimer;

  /// Initializes prayer times and loads notification settings.
  Future<void> init({bool isArabic = true}) async {
    await loadNotificationSettings();
    await fetchPrayerTimes(isArabic: isArabic);
  }

  /// Checks if data is loaded, if not, initializes it.
  /// Call this in the UI (e.g., BlocBuilder or onInit of the view)
  Future<void> checkInitialData({bool isArabic = true}) async {
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
    } on Object catch (error) {
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

  /// Fetches prayer times for today. Only fetches location-based times if permission was granted.
  Future<void> fetchPrayerTimes({bool isArabic = true}) async {
    if (!isClosed) emit(state.copyWith(status: RequestStatus.loading));

    try {
      final times = await _prayerTimesRepo.getPrayerTimes(
        isArabic: isArabic,
        useLocation: locationGranted,
      );
      await _handlePrayerTimesSuccess(times);
    } on Object catch (e) {
      _handlePrayerTimesError(e.toString());
    }
  }

  /// Handles successful prayer times fetch — schedules notifications
  /// and updates state.
  Future<void> _handlePrayerTimesSuccess(LocalPrayerTimes times) async {
    final allScheduledTimes = <LocalPrayerTimes>[times];

    try {
      final coordinates = await _prayerTimesRepo.getCachedCoordinates();
      if (coordinates != null) {
        final now = DateTime.now();
        for (var i = 1; i < NotificationConstants.scheduleDaysAhead; i++) {
          final nextDate = now.add(Duration(days: i));
          try {
            final nextDayTimes = await _prayerTimesRepo.getPrayerTimesForDate(
              coordinates,
              nextDate,
              cityName: times.city,
            );
            allScheduledTimes.add(nextDayTimes);
          } on Object catch (_) {}
        }
      }
    } on Object catch (e) {
      logWarning('تعذر جلب أوقات الأيام القادمة في الـ Cubit: $e');
    }

    try {
      await _notificationRepo.scheduleNotifications(allScheduledTimes);
    } on Object catch (e) {
      logWarning('تعذر جدولة الإشعارات: $e');
    }
    
    _updateStateWithPrayerTimes(times);
    _startCountdown();
  }

  /// Updates state with prayer calculation results.
  void _updateStateWithPrayerTimes(LocalPrayerTimes times) {
    // using calculateSync because we need it immediately for state update
    final calculation = _calculateNextPrayer.calculateSync(times);

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

  void _handlePrayerTimesError(String message) {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: RequestStatus.failure,
          message: 'من فضلك فعل الاشعارات للحصول علي مواقيت الصلاه\n$message',
        ),
      );
    }
  }

  /// Starts a per-second countdown for the next prayer.
  void _startCountdown() {
    _timer?.cancel();
    _initialDelayTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final currentTimes = state.localPrayerTimes;
    if (currentTimes == null) return;

    final calculation = _calculateNextPrayer.calculateSync(currentTimes);

    // Only emit state if there's a significant change or prayer time reached
    final shouldEmit =
        calculation.timeLeft.inSeconds <= 0 ||
        (state.timeLeft?.inSeconds != calculation.timeLeft.inSeconds);

    if (calculation.timeLeft.inSeconds <= 0) {
      logInfo('🔄 انتهى وقت الصلاة، جاري تحديث الجدولة...');
      unawaited(_handlePrayerTimesSuccess(currentTimes));
    } else if (shouldEmit && !isClosed) {
      emit(
        state.copyWith(
          nextPrayer: calculation.nextPrayer,
          timeLeft: calculation.timeLeft,
          previousPrayerDateTime: calculation.previousPrayerDateTime,
        ),
      );
    }
  }

  /// Loads per-prayer notification settings into state.
  Future<void> loadNotificationSettings() async {
    try {
      final settings = await _notificationRepo.getSettings();
      if (!isClosed) emit(state.copyWith(notificationSettings: settings));
    } on Object catch (e) {
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
    try {
      await _notificationRepo.setPrayerEnabled(type, enabled: enabled);
    } on Object catch (e) {
      logWarning('تعذر حفظ إعدادات الإشعارات: $e');
    }

    if (state.localPrayerTimes != null) {
      final times = <LocalPrayerTimes>[state.localPrayerTimes!];
      try {
        final coordinates = await _prayerTimesRepo.getCachedCoordinates();
        if (coordinates != null) {
          final now = DateTime.now();
          for (var i = 1; i < NotificationConstants.scheduleDaysAhead; i++) {
            final date = now.add(Duration(days: i));
            try {
              final nextDayTimes = await _prayerTimesRepo.getPrayerTimesForDate(
                coordinates,
                date,
                cityName: state.localPrayerTimes!.city,
              );
              times.add(nextDayTimes);
            } on Object catch (_) {}
          }
        }
      } on Object catch (_) {}
      try {
        await _notificationRepo.scheduleNotifications(times);
      } on Object catch (_) {}
    }
  }

  /// Manual refresh of prayer times.
  Future<void> refreshPrayerTimes({bool isArabic = true}) async {
    logInfo('🔄 تحديث يدوي لمواعيد الصلاة...');
    // ponytail: update locationGranted status dynamically when refreshing
    locationGranted = await requestAllPermissions();
    await init(isArabic: isArabic);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _initialDelayTimer?.cancel();
    _midnightTimer?.cancel();
    return super.close();
  }
}
