import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/service/location_service.dart';
import '../helper/prayer_consts.dart';
import '../model/prayer_times_model.dart';
import '../repository/prayer_times_repository.dart';
import 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit({
    required this.repository,
    required this.locationService,
  }) : super(const PrayerTimesState());

  final PrayerTimesRepository repository;
  final LocationService locationService;

  Timer? _timer;
  StreamSubscription<ServiceStatus>? _locationSubscription;
  final DateFormat _timeFormat = DateFormat('HH:mm');

  /// Initializes the cubit and sets up location service listeners
  Future<void> init() async {
    _setupLocationServiceListener();
    await _loadPrayerTimesIfGranted();
  }

  /// Sets up listener for location service status changes
  void _setupLocationServiceListener() {
    _locationSubscription = locationService.serviceStatusStream.listen(
      (ServiceStatus status) async {
        if (status == ServiceStatus.enabled) {
          await _loadPrayerTimesIfGranted();
        } else {
          _handleLocationServiceDisabled();
        }
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: PrayerTimesStatus.error,
            message: 'خطأ في خدمة الموقع: ${error.toString()}',
          ),
        );
      },
    );
  }

  /// Handles when location service is disabled
  void _handleLocationServiceDisabled() {
    _timer?.cancel();
    emit(
      state.copyWith(
        status: PrayerTimesStatus.error,
        message: 'من فضلك شغل خدمة الموقع لمعرفة مواقيت الصلاة',
      ),
    );
  }

  /// Loads prayer times if location permissions are granted
  Future<void> _loadPrayerTimesIfGranted() async {
    try {
      final status = await locationService.checkLocationStatus();
      
      if (status.isGranted) {
        await fetchPrayerTimes();
      } else {
        emit(
          state.copyWith(
            status: PrayerTimesStatus.error,
            message: 'الموقع مش متفعل أو الصلاحية مرفوضة',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: PrayerTimesStatus.error,
          message: 'خطأ في التحقق من حالة الموقع: ${error.toString()}',
        ),
      );
    }
  }

  /// Fetches prayer times from the repository
  Future<void> fetchPrayerTimes() async {
    emit(state.copyWith(status: PrayerTimesStatus.loading));
    
    try {
      final response = await repository.getPrayerTimes();
      final timings = response.data.timings;

      await _handleSuccessfulPrayerTimesFetch(timings, response);
    } catch (error) {
      _handlePrayerTimesFetchError(error);
    }
  }

  /// Handles successful prayer times fetch
  Future<void> _handleSuccessfulPrayerTimesFetch(
    Timings timings,
    PrayerTimesResponse response,
  ) async {
    final nextPrayer = _getNextPrayer(timings);
    final target = _getNextPrayerDateTime(timings, nextPrayer);
    final timeLeft = target.difference(DateTime.now());

    emit(
      state.copyWith(
        status: PrayerTimesStatus.success,
        response: response,
        timings: timings,
        nextPrayer: nextPrayer,
        timeLeft: timeLeft,
      ),
    );

    _startCountdown(timings);
  }

  /// Handles errors during prayer times fetch
  void _handlePrayerTimesFetchError(Object error) {
    emit(
      state.copyWith(
        status: PrayerTimesStatus.error,
        message: 'فشل في جلب مواقيت الصلاة: ${error.toString()}',
      ),
    );
  }

  /// Starts the countdown timer for prayer times
  void _startCountdown(Timings timings) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown(timings);
    });
  }

  /// Updates the countdown for the next prayer
  void _updateCountdown(Timings timings) {
    final nextPrayer = _getNextPrayer(timings);
    final target = _getNextPrayerDateTime(timings, nextPrayer);
    final timeLeft = target.difference(DateTime.now());

    emit(state.copyWith(nextPrayer: nextPrayer, timeLeft: timeLeft));
  }

  /// Gets the next prayer name based on current time
  String _getNextPrayer(Timings timings) {
    final now = DateTime.now();
    final timingsMap = timings.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer];
      if (prayerTime == null) continue;
      
      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return prayer;
    }
    
    // If all prayers for today have passed, return Fajr for next day
    return 'Fajr';
  }

  /// Gets the DateTime for the next prayer
  DateTime _getNextPrayerDateTime(Timings timings, String prayer) {
    final now = DateTime.now();
    final timingsMap = timings.toMap();
    final prayerTime = timingsMap[prayer]!;

    // Handle case where all prayers for today have passed
    if (prayer == 'Fajr' && _areAllPrayersFinished(timings)) {
      final parsedTime = _timeFormat.parse(prayerTime);
      return DateTime(
        now.year,
        now.month,
        now.day + 1,
        parsedTime.hour,
        parsedTime.minute,
      );
    }

    final parsedTime = _timeFormat.parse(prayerTime);
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  /// Checks if all prayers for the current day have finished
  bool _areAllPrayersFinished(Timings timings) {
    final now = DateTime.now();
    final timingsMap = timings.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer];
      if (prayerTime == null) continue;
      
      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return false;
    }
    
    return true;
  }

  /// Parses prayer time string to DateTime
  DateTime _parsePrayerTime(String timeString, DateTime referenceDate) {
    final parsed = _timeFormat.parse(timeString);
    return DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      parsed.hour,
      parsed.minute,
    );
  }

  /// Clean up resources when cubit is closed
  @override
  Future<void> close() {
    _timer?.cancel();
    _locationSubscription?.cancel();
    return super.close();
  }
}