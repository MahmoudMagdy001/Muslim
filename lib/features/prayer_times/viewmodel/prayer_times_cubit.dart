import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../helper/prayer_consts.dart';
import '../model/prayer_times_model.dart';
import '../repository/prayer_times_repository.dart';
import 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit({required this.repository})
    : super(const PrayerTimesState());

  final PrayerTimesRepository repository;

  Timer? _timer;
  final DateFormat _timeFormat = DateFormat('HH:mm');

  /// Initializes the cubit and fetches prayer times
  Future<void> init() async {
    await fetchPrayerTimes();
  }

  /// Fetches prayer times
  Future<void> fetchPrayerTimes() async {
    emit(state.copyWith(status: PrayerTimesStatus.loading));

    try {
      final localPrayerTimes = await repository.getPrayerTimes();
      _handleSuccessfulPrayerTimesFetch(localPrayerTimes);
    } catch (error) {
      _handlePrayerTimesFetchError(error);
    }
  }

  void _handleSuccessfulPrayerTimesFetch(LocalPrayerTimes localPrayerTimes) {
    final nextPrayer = _getNextPrayer(localPrayerTimes);
    final target = _getNextPrayerDateTime(localPrayerTimes, nextPrayer);
    final timeLeft = target.difference(DateTime.now());

    emit(
      state.copyWith(
        status: PrayerTimesStatus.success,
        localPrayerTimes: localPrayerTimes,
        nextPrayer: nextPrayer,
        timeLeft: timeLeft,
      ),
    );

    _startCountdown(localPrayerTimes);
  }

  void _handlePrayerTimesFetchError(Object error) {
    emit(
      state.copyWith(
        status: PrayerTimesStatus.error,
        message: 'فشل في جلب مواقيت الصلاة: ${error.toString()}',
      ),
    );
  }

  void _startCountdown(LocalPrayerTimes localPrayerTimes) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown(localPrayerTimes);
    });
  }

  void _updateCountdown(LocalPrayerTimes localPrayerTimes) {
    final nextPrayer = _getNextPrayer(localPrayerTimes);
    final target = _getNextPrayerDateTime(localPrayerTimes, nextPrayer);
    final timeLeft = target.difference(DateTime.now());

    emit(state.copyWith(nextPrayer: nextPrayer, timeLeft: timeLeft));
  }

  String _getNextPrayer(LocalPrayerTimes localPrayerTimes) {
    final now = DateTime.now();
    final timingsMap = localPrayerTimes.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return prayer;
    }

    return 'Fajr';
  }

  DateTime _getNextPrayerDateTime(
    LocalPrayerTimes localPrayerTimes,
    String prayer,
  ) {
    final now = DateTime.now();
    final timingsMap = localPrayerTimes.toMap();
    final prayerTime = timingsMap[prayer]!;

    if (prayer == 'Fajr' && _areAllPrayersFinished(localPrayerTimes)) {
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

  bool _areAllPrayersFinished(LocalPrayerTimes localPrayerTimes) {
    final now = DateTime.now();
    final timingsMap = localPrayerTimes.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return false;
    }

    return true;
  }

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

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
