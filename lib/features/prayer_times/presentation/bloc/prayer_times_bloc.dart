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
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_event.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_state.dart';
import 'package:muslim/features/prayer_times/presentation/helper/notification_constants.dart';

export 'prayer_times_event.dart';
export 'prayer_times_state.dart';

/// Bloc managing prayer times state, notification scheduling,
/// and per-prayer notification settings.
class PrayerTimesBloc extends Bloc<PrayerTimesEvent, PrayerTimesState> {
  PrayerTimesBloc({
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
       super(const PrayerTimesState()) {
    on<PrayerTimesInit>(_onInit);
    on<PrayerTimesCheckInitialData>(_onCheckInitialData);
    on<PrayerTimesCheckAllPermissions>(_onCheckAllPermissions);
    on<PrayerTimesFetchPrayerTimes>(_onFetchPrayerTimes);
    on<PrayerTimesLoadNotificationSettings>(_onLoadNotificationSettings);
    on<PrayerTimesTogglePrayerNotification>(_onTogglePrayerNotification);
    on<PrayerTimesRefreshPrayerTimes>(_onRefreshPrayerTimes);
    on<PrayerTimesCountdownTicked>(_onCountdownTicked);
    on<PrayerTimesPrayerTimesUpdated>(_onPrayerTimesUpdated);
  }

  // ponytail: allow locationGranted to be updated dynamically after post-frame permission request
  bool locationGranted;

  final PrayerTimesRepository _prayerTimesRepo;
  final PrayerNotificationRepository _notificationRepo;
  final CalculateNextPrayerUseCase _calculateNextPrayer;

  Timer? _timer;
  Timer? _initialDelayTimer;
  Timer? _midnightTimer;
  bool _isScheduling = false;
  bool _isFetching = false;

  Future<void> _onInit(
    PrayerTimesInit event,
    Emitter<PrayerTimesState> emit,
  ) async {
    if (_isFetching) return;
    await _loadNotificationSettingsInternal(emit);
    await _fetchPrayerTimesInternal(event.isArabic, emit);
  }

  Future<void> _onCheckInitialData(
    PrayerTimesCheckInitialData event,
    Emitter<PrayerTimesState> emit,
  ) async {
    if (state.status == RequestStatus.initial && !_isFetching) {
      add(PrayerTimesEvent.init(isArabic: event.isArabic));
    }
  }

  Future<void> _onCheckAllPermissions(
    PrayerTimesCheckAllPermissions event,
    Emitter<PrayerTimesState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      await requestAllPermissions();
      logSuccess('تم التحقق من جميع الصلاحيات بنجاح');
    } on Object catch (error) {
      logError('خطأ في التحقق من الصلاحيات', error);
      emit(
        state.copyWith(
          status: RequestStatus.failure,
          message: 'يجب منح الصلاحيات المطلوبة لعرض مواقيت الصلاة',
        ),
      );
    }
  }

  Future<void> _onFetchPrayerTimes(
    PrayerTimesFetchPrayerTimes event,
    Emitter<PrayerTimesState> emit,
  ) async {
    await _fetchPrayerTimesInternal(event.isArabic, emit);
  }

  Future<void> _fetchPrayerTimesInternal(
    bool isArabic,
    Emitter<PrayerTimesState> emit,
  ) async {
    if (_isFetching) {
      logInfo('ℹ️ جاري جلب مواقيت الصلاة بالفعل، تم تجاهل الطلب المكرر');
      return;
    }
    _isFetching = true;
    emit(state.copyWith(status: RequestStatus.loading));

    if (!locationGranted) {
      locationGranted = await isLocationPermissionGranted();
    }

    try {
      final times = await _prayerTimesRepo.getPrayerTimes(
        isArabic: isArabic,
        useLocation: locationGranted,
      );
      await _handlePrayerTimesSuccess(times, emit);
      _scheduleMidnightTimer(isArabic: isArabic);
    } on Object catch (e) {
      _handlePrayerTimesError(e.toString(), emit);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _handlePrayerTimesSuccess(
    LocalPrayerTimes times,
    Emitter<PrayerTimesState> emit,
  ) async {
    await _scheduleUpcomingNotifications(times);
    _updateStateWithPrayerTimes(times, emit);
    _startCountdown();
  }

  Future<void> _scheduleUpcomingNotifications(LocalPrayerTimes currentTimes) async {
    final allScheduledTimes = <LocalPrayerTimes>[currentTimes];

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
              cityName: currentTimes.city,
            );
            allScheduledTimes.add(nextDayTimes);
          } on Object catch (_) {}
        }
      }
    } on Object catch (e) {
      logWarning('تعذر جلب أوقات الأيام القادمة في الـ Bloc: $e');
    }

    try {
      await _notificationRepo.scheduleNotifications(allScheduledTimes);
    } on Object catch (e) {
      logWarning('تعذر جدولة الإشعارات: $e');
    }
  }

  void _scheduleMidnightTimer({bool isArabic = true}) {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 0, 0, 5);
    final delay = tomorrow.difference(now);
    _midnightTimer = Timer(delay, () {
      logInfo('🌙 منتصف الليل — جاري تحديث مواقيت الصلاة لليوم الجديد...');
      add(PrayerTimesEvent.fetchPrayerTimes(isArabic: isArabic));
    });
  }

  void _updateStateWithPrayerTimes(
    LocalPrayerTimes times,
    Emitter<PrayerTimesState> emit,
  ) {
    final calculation = _calculateNextPrayer.calculateSync(times);

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

  void _onPrayerTimesUpdated(
    PrayerTimesPrayerTimesUpdated event,
    Emitter<PrayerTimesState> emit,
  ) {
    _updateStateWithPrayerTimes(event.times, emit);
  }

  void _handlePrayerTimesError(
    String message,
    Emitter<PrayerTimesState> emit,
  ) {
    emit(
      state.copyWith(
        status: RequestStatus.failure,
        message: 'من فضلك فعل الاشعارات للحصول علي مواقيت الصلاه\n$message',
      ),
    );
  }

  void _startCountdown() {
    _timer?.cancel();
    _initialDelayTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const PrayerTimesEvent.countdownTicked());
    });
  }

  void _onCountdownTicked(
    PrayerTimesCountdownTicked event,
    Emitter<PrayerTimesState> emit,
  ) {
    final currentTimes = state.localPrayerTimes;
    if (currentTimes == null) return;

    final calculation = _calculateNextPrayer.calculateSync(currentTimes);

    final shouldEmit =
        calculation.timeLeft.inSeconds <= 0 ||
        (state.timeLeft?.inSeconds != calculation.timeLeft.inSeconds);

    if (calculation.timeLeft.inSeconds <= 0) {
      if (!_isScheduling) {
        _isScheduling = true;
        logInfo('🔄 انتهى وقت الصلاة، جاري تحديث الحساب...');
        final isToday = currentTimes.date.day == DateTime.now().day;
        if (!isToday) {
          add(const PrayerTimesEvent.fetchPrayerTimes());
          _isScheduling = false;
        } else {
          _updateStateWithPrayerTimes(currentTimes, emit);
          unawaited(
            _scheduleUpcomingNotifications(currentTimes).whenComplete(() {
              _isScheduling = false;
            }),
          );
        }
      }
    } else if (shouldEmit) {
      emit(
        state.copyWith(
          nextPrayer: calculation.nextPrayer,
          timeLeft: calculation.timeLeft,
          previousPrayerDateTime: calculation.previousPrayerDateTime,
        ),
      );
    }
  }

  Future<void> _onLoadNotificationSettings(
    PrayerTimesLoadNotificationSettings event,
    Emitter<PrayerTimesState> emit,
  ) async {
    await _loadNotificationSettingsInternal(emit);
  }

  Future<void> _loadNotificationSettingsInternal(
    Emitter<PrayerTimesState> emit,
  ) async {
    try {
      final settings = await _notificationRepo.getSettings();
      emit(state.copyWith(notificationSettings: settings));
    } on Object catch (e) {
      logWarning('تعذر تحميل إعدادات الإشعارات: $e');
    }
  }

  Future<void> _onTogglePrayerNotification(
    PrayerTimesTogglePrayerNotification event,
    Emitter<PrayerTimesState> emit,
  ) async {
    final updatedSettings = state.notificationSettings.copyWithPrayer(
      event.type,
      enabled: event.enabled,
    );
    emit(state.copyWith(notificationSettings: updatedSettings));

    try {
      await _notificationRepo.setPrayerEnabled(event.type, enabled: event.enabled);
    } on Object catch (e) {
      logWarning('تعذر حفظ إعدادات الإشعارات: $e');
    }

    if (state.localPrayerTimes != null) {
      await _scheduleUpcomingNotifications(state.localPrayerTimes!);
    }
  }

  Future<void> _onRefreshPrayerTimes(
    PrayerTimesRefreshPrayerTimes event,
    Emitter<PrayerTimesState> emit,
  ) async {
    if (_isFetching) {
      logInfo('ℹ️ جاري تحديث مواقيت الصلاة بالفعل، تم تجاهل الطلب المكرر');
      return;
    }
    logInfo('🔄 تحديث يدوي لمواعيد الصلاة...');
    locationGranted = await isLocationPermissionGranted();
    await _loadNotificationSettingsInternal(emit);
    await _fetchPrayerTimesInternal(event.isArabic, emit);
  }

  // Convenience methods
  Future<void> init({bool isArabic = true}) async =>
      add(PrayerTimesEvent.init(isArabic: isArabic));

  Future<void> checkInitialData({bool isArabic = true}) async =>
      add(PrayerTimesEvent.checkInitialData(isArabic: isArabic));

  Future<void> checkAllPermissions() async =>
      add(const PrayerTimesEvent.checkAllPermissions());

  Future<void> fetchPrayerTimes({bool isArabic = true}) async =>
      add(PrayerTimesEvent.fetchPrayerTimes(isArabic: isArabic));

  Future<void> loadNotificationSettings() async =>
      add(const PrayerTimesEvent.loadNotificationSettings());

  Future<void> togglePrayerNotification(
    PrayerType type, {
    required bool enabled,
  }) async =>
      add(PrayerTimesEvent.togglePrayerNotification(type: type, enabled: enabled));

  Future<void> refreshPrayerTimes({bool isArabic = true}) async =>
      add(PrayerTimesEvent.refreshPrayerTimes(isArabic: isArabic));

  @override
  Future<void> close() {
    _timer?.cancel();
    _initialDelayTimer?.cancel();
    _midnightTimer?.cancel();
    return super.close();
  }
}
