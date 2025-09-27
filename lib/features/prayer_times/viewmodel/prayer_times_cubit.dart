import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
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
  Timer? _midnightTimer;
  final DateFormat _timeFormat = DateFormat('HH:mm');

  /// Initializes the cubit and fetches prayer times
  Future<void> init() async {
    await fetchPrayerTimes();
    _scheduleMidnightUpdate();
  }

  /// Fetches prayer times
  Future<void> fetchPrayerTimes() async {
    emit(state.copyWith(status: PrayerTimesStatus.loading));

    try {
      final localPrayerTimes = await repository.getPrayerTimes();
      await _schedulePrayerNotifications(localPrayerTimes);
      _handleSuccessfulPrayerTimesFetch(localPrayerTimes);
    } catch (error) {
      _handlePrayerTimesFetchError(error);
    }
  }

  /// جدولة تحديث تلقائي عند منتصف الليل
  void _scheduleMidnightUpdate() {
    _midnightTimer?.cancel();

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 1);
    final timeToMidnight = midnight.difference(now);

    _midnightTimer = Timer(timeToMidnight, () {
      print('🕛 منتصف الليل - تحديث مواعيد الصلاة تلقائياً');
      fetchPrayerTimes(); // تحديث الصلوات لليوم الجديد
      _scheduleMidnightUpdate(); // إعادة جدولة لليوم التالي
    });

    print('⏰ تم جدولة التحديث التلقائي عند: ${midnight.toLocal()}');
  }

  /// جدولة إشعارات الصلاة - تلقائياً تأخذ في الاعتبار إذا كانت الصلوات انتهت
  Future<void> _schedulePrayerNotifications(LocalPrayerTimes times) async {
    final now = DateTime.now();

    final prayers = {
      'الفجر': times.fajr,
      'الظهر': times.dhuhr,
      'العصر': times.asr,
      'المغرب': times.maghrib,
      'العشاء': times.isha,
    };

    // IDs ثابتة لكل صلاة
    final prayerIds = {
      'الفجر': 1,
      'الظهر': 2,
      'العصر': 3,
      'المغرب': 4,
      'العشاء': 5,
    };

    await AwesomeNotifications().cancelSchedulesByChannelKey('prayer_reminder');
    print('⏳ تم مسح أي إشعارات قديمة...');

    // تحديد إذا كانت جميع صلوات اليوم انتهت
    final areAllPrayersFinished = _areAllPrayersFinished(times);

    int scheduledCount = 0;

    for (final entry in prayers.entries) {
      final prayerName = entry.key;
      final prayerTimeStr = entry.value;

      if (prayerTimeStr == '--:--') {
        print('⚠️ تخطي $prayerName لعدم توفر توقيت (مشكلة في الموقع)');
        continue;
      }

      final parts = prayerTimeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      DateTime prayerDateTime;

      // إذا انتهت جميع الصلوات، نجدول لصلاة الفجر في اليوم التالي
      if (areAllPrayersFinished && prayerName == 'الفجر') {
        prayerDateTime = DateTime(
          now.year,
          now.month,
          now.day + 1,
          hour,
          minute,
        );
        print('🌙 جميع الصلوات انتهت، تم جدولة الفجر للغد');
      } else {
        prayerDateTime = DateTime(now.year, now.month, now.day, hour, minute);
      }

      // إذا كانت الصلاة قد مضت ولم نكن نجدول للغد، نتخطاها
      if (prayerDateTime.isBefore(now) && !areAllPrayersFinished) {
        print('⏭️ تخطي $prayerName لأن وقتها قد مضى');
        continue;
      }

      final scheduled = prayerDateTime.subtract(const Duration(minutes: 1));

      if (scheduled.isAfter(now) ||
          (areAllPrayersFinished && prayerName == 'الفجر')) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: prayerIds[prayerName]!,
            channelKey: 'prayer_reminder',
            title: 'تنبيه $prayerName',
            body: 'باقي دقيقة على صلاة $prayerName',
            wakeUpScreen: true,
          ),
          schedule: NotificationCalendar(
            year: scheduled.year,
            month: scheduled.month,
            day: scheduled.day,
            hour: scheduled.hour,
            minute: scheduled.minute,
            second: 0,
          ),
        );

        scheduledCount++;
        print(
          '✅ تم جدولة إشعار $prayerName قبل الصلاة بدقيقة (${scheduled.toLocal()})',
        );
      } else {
        print(
          '⚠️ تم تخطي إشعار $prayerName لأنه بعد الطرح عدى (${scheduled.toLocal()})',
        );
      }
    }

    print('🎉 تم جدولة $scheduledCount إشعار بنجاح!');

    // إذا لم يتم جدولة أي إشعار (كل الصلوات انتهت)، نضيف إشعار تحديث
    if (scheduledCount == 0 && !areAllPrayersFinished) {
      await _scheduleUpdateNotification();
    }
  }

  /// جدولة إشعار لتذكير المستخدم بتحديث الصلوات
  Future<void> _scheduleUpdateNotification() async {
    final now = DateTime.now();
    final updateTime = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
    ); // قبل منتصف الليل بدقيقة

    if (updateTime.isAfter(now)) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 100,
          // ID خاص بالتحديث
          channelKey: 'prayer_reminder',
          title: 'تحديث مواعيد الصلاة',
          body: 'سيتم تحديث مواعيد الصلاة لليوم الجديد تلقائياً',
          wakeUpScreen: false,
        ),
        schedule: NotificationCalendar(
          year: updateTime.year,
          month: updateTime.month,
          day: updateTime.day,
          hour: updateTime.hour,
          minute: updateTime.minute,
          second: 0,
        ),
      );
      print('🔔 تم جدولة إشعار التحديث لـ ${updateTime.toLocal()}');
    }
  }

  bool _areAllPrayersFinished(LocalPrayerTimes localPrayerTimes) {
    final now = DateTime.now();
    final timingsMap = localPrayerTimes.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      if (prayerTime == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return false;
    }

    return true;
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
        lastUpdated: DateTime.now(),
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

    // إذا انتهى الوقت للصلاة الحالية، نحدث الجدولة
    if (timeLeft.inSeconds <= 0) {
      print('🔄 انتهى وقت الصلاة، جاري تحديث الجدولة...');
      _schedulePrayerNotifications(localPrayerTimes);
    }

    emit(state.copyWith(nextPrayer: nextPrayer, timeLeft: timeLeft));
  }

  String _getNextPrayer(LocalPrayerTimes localPrayerTimes) {
    final now = DateTime.now();
    final timingsMap = localPrayerTimes.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      if (prayerTime == '--:--') continue;

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

  /// دالة عامة لتحديث الصلوات يدوياً (مثلاً من زر في الواجهة)
  Future<void> refreshPrayerTimes() async {
    print('🔄 تحديث يدوي لمواعيد الصلاة...');
    await fetchPrayerTimes();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _midnightTimer?.cancel();
    return super.close();
  }
}
