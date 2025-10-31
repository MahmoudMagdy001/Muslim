// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/utils/format_helper.dart';

// API Configuration
class PrayerApiConfig {
  static const double latitude = 30.0444;
  static const double longitude = 31.2357;
  static const int method = 5;
  static const String baseUrl = 'https://api.aladhan.com/v1/calendar';
}

// Prayer Names Constants
class PrayerNames {
  static const String fajr = 'الفجر';
  static const String sunrise = 'الشروق';
  static const String dhuhr = 'الظهر';
  static const String asr = 'العصر';
  static const String maghrib = 'المغرب';
  static const String isha = 'العشاء';
}

class MonthPrayerTimesWidget extends StatefulWidget {
  const MonthPrayerTimesWidget({required this.isArabic, super.key});
  final bool isArabic;

  @override
  State<MonthPrayerTimesWidget> createState() => _MonthPrayerTimesWidgetState();
}

class _MonthPrayerTimesWidgetState extends State<MonthPrayerTimesWidget> {
  late Future<List<Map<String, String>>> _prayerTimesFuture;
  late PageController _pageController;
  late ValueNotifier<int> _currentPage;

  @override
  void initState() {
    super.initState();
    _prayerTimesFuture = _getPrayerTimesFromTodayToNextMonth();
    _pageController = PageController();
    _currentPage = ValueNotifier(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('مواقيت الصلاة')),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, String>>>(
          future: _prayerTimesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingWidget();
            }

            if (snapshot.hasError) {
              return _buildErrorWidget();
            }

            final prayerTimes = snapshot.data ?? [];
            if (prayerTimes.isEmpty) {
              return _buildEmptyWidget();
            }

            // Set initial page to today
            final initialPageIndex = prayerTimes.indexWhere(
              (d) => d['isToday'] == 'true',
            );
            if (initialPageIndex != -1 &&
                _pageController.initialPage != initialPageIndex) {
              _pageController = PageController(initialPage: initialPageIndex);
              _currentPage.value = initialPageIndex;
            }

            return _buildPrayerPager(prayerTimes, theme);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() => const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('جاري تحميل مواقيت الصلاة...'),
      ],
    ),
  );

  Widget _buildErrorWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
        const SizedBox(height: 16),
        const Text(
          'حدث خطأ أثناء تحميل البيانات',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _prayerTimesFuture = _getPrayerTimesFromTodayToNextMonth();
            });
          },
          child: const Text('إعادة المحاولة'),
        ),
      ],
    ),
  );

  Widget _buildEmptyWidget() => const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning_amber, size: 64, color: Colors.amber),
        SizedBox(height: 16),
        Text('لا توجد بيانات متاحة', style: TextStyle(fontSize: 16)),
      ],
    ),
  );

  Widget _buildPrayerPager(
    List<Map<String, String>> prayerTimes,
    ThemeData theme,
  ) {
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage.value) {
        _currentPage.value = newPage;
      }
    });

    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (context, index, _) {
        final day = prayerTimes[index];
        final isToday = day['isToday'] == 'true';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // ✅ Header with date and navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    onPressed: index > 0
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    color: index > 0 ? theme.colorScheme.primary : Colors.grey,
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.isArabic
                              ? convertToArabicNumbers(day['gregorianDate']!)
                              : day['gregorianDate']!,
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.isArabic
                              ? convertToArabicNumbers(day['hijriDate']!)
                              : day['hijriDate']!,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: index < prayerTimes.length - 1
                        ? () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    color: index < prayerTimes.length - 1
                        ? theme.colorScheme.primary
                        : Colors.grey,
                  ),
                ],
              ),

              // ✅ Today indicator
              if (isToday)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Card(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        'اليوم',
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // ✅ Prayer times card
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: prayerTimes.length,
                  onPageChanged: (int page) {
                    _currentPage.value = page;
                  },
                  itemBuilder: (context, i) {
                    final item = prayerTimes[i];
                    final isCurrentToday = item['isToday'] == 'true';

                    return Column(
                      children: [
                        Card(
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isCurrentToday
                                  ? theme.colorScheme.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildPrayerTimeRow(
                                  PrayerNames.fajr,
                                  item['fajr']!,
                                  theme,
                                ),
                                _buildDivider(),
                                _buildPrayerTimeRow(
                                  PrayerNames.sunrise,
                                  item['sunrise']!,
                                  theme,
                                ),
                                _buildDivider(),
                                _buildPrayerTimeRow(
                                  PrayerNames.dhuhr,
                                  item['dhuhr']!,
                                  theme,
                                ),
                                _buildDivider(),
                                _buildPrayerTimeRow(
                                  PrayerNames.asr,
                                  item['asr']!,
                                  theme,
                                ),
                                _buildDivider(),
                                _buildPrayerTimeRow(
                                  PrayerNames.maghrib,
                                  item['maghrib']!,
                                  theme,
                                ),
                                _buildDivider(),
                                _buildPrayerTimeRow(
                                  PrayerNames.isha,
                                  item['isha']!,
                                  theme,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ✅ Page indicator
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.isArabic
                                ? convertToArabicNumbers(
                                    '${i + 1} / ${prayerTimes.length}',
                                  )
                                : '${i + 1} / ${prayerTimes.length}',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrayerTimeRow(String prayerName, String time, ThemeData theme) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prayerName,
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              formatTo12Hour(time, true),
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 0.5, color: Colors.grey.shade300);

  // API Methods
  Future<List<Map<String, String>>>
  _getPrayerTimesFromTodayToNextMonth() async {
    try {
      final now = DateTime.now();
      final currentMonth = now.month;
      final currentYear = now.year;
      final today = now.day;

      final DateTime nextMonthDate = DateTime(currentYear, currentMonth + 1);
      final nextMonth = nextMonthDate.month;
      final nextMonthYear = nextMonthDate.year;

      final List<Map<String, String>> allPrayerTimes = [];

      // Fetch current month
      final currentMonthResponse = await http.get(
        Uri.parse(
          '${PrayerApiConfig.baseUrl}/$currentYear/$currentMonth?'
          'latitude=${PrayerApiConfig.latitude}'
          '&longitude=${PrayerApiConfig.longitude}'
          '&method=${PrayerApiConfig.method}',
        ),
      );

      if (currentMonthResponse.statusCode == 200) {
        final currentMonthData = json.decode(currentMonthResponse.body);
        final currentMonthTimes = _processApiData(
          currentMonthData,
          today - 1,
          currentYear,
          currentMonth,
          true,
        );
        allPrayerTimes.addAll(currentMonthTimes);
      } else {
        throw Exception('Failed to load current month data');
      }

      // Fetch next month
      final nextMonthResponse = await http.get(
        Uri.parse(
          '${PrayerApiConfig.baseUrl}/$nextMonthYear/$nextMonth?'
          'latitude=${PrayerApiConfig.latitude}'
          '&longitude=${PrayerApiConfig.longitude}'
          '&method=${PrayerApiConfig.method}',
        ),
      );

      if (nextMonthResponse.statusCode == 200) {
        final nextMonthData = json.decode(nextMonthResponse.body);
        final nextMonthTimes = _processApiData(
          nextMonthData,
          0,
          nextMonthYear,
          nextMonth,
          false,
        );
        allPrayerTimes.addAll(nextMonthTimes);
      }

      return allPrayerTimes;
    } catch (e) {
      // Fallback to mock data
      return _getMockDataFromToday();
    }
  }

  List<Map<String, String>> _processApiData(
    Map<String, dynamic> data,
    int startFromDay,
    int year,
    int month,
    bool isCurrentMonth,
  ) {
    final List<Map<String, String>> prayerTimes = [];
    final days = data['data'] as List;
    final now = DateTime.now();

    for (int i = startFromDay; i < days.length; i++) {
      final dayData = days[i];
      final dayNumber = i + 1;
      final isToday = isCurrentMonth && dayNumber == now.day;
      final timings = dayData['timings'] ?? {};

      prayerTimes.add({
        'gregorianDate': dayData['date']['gregorian']['date'] ?? '',
        'hijriDate':
            '${dayData['date']['hijri']['day']} ${dayData['date']['hijri']['month']['ar']} ${dayData['date']['hijri']['year']}',
        'fajr': _extractTime(timings['Fajr'] ?? '--:--'),
        'sunrise': _extractTime(timings['Sunrise'] ?? '--:--'),
        'dhuhr': _extractTime(timings['Dhuhr'] ?? '--:--'),
        'asr': _extractTime(timings['Asr'] ?? '--:--'),
        'maghrib': _extractTime(timings['Maghrib'] ?? '--:--'),
        'isha': _extractTime(timings['Isha'] ?? '--:--'),
        'isToday': isToday.toString(),
      });
    }

    return prayerTimes;
  }

  List<Map<String, String>> _getMockDataFromToday() {
    final now = DateTime.now();
    final List<Map<String, String>> mock = [];
    final hijriMonths = [
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الآخر',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];

    for (int i = 0; i < 30; i++) {
      final d = now.add(Duration(days: i));
      final hijriMonth = hijriMonths[(d.month - 1) % hijriMonths.length];
      final hijriDay = (i + 1) % 30;
      final hijriYear = 1445 + (i ~/ 354);

      mock.add({
        'gregorianDate': DateFormat('yyyy-MM-dd').format(d),
        'hijriDate': '$hijriDay $hijriMonth $hijriYear',
        'fajr': '04:3${i % 10}',
        'sunrise': '06:1${i % 10}',
        'dhuhr': '12:0${i % 10}',
        'asr': '15:3${i % 10}',
        'maghrib': '17:4${i % 10}',
        'isha': '19:0${i % 10}',
        'isToday': i == 0 ? 'true' : 'false',
      });
    }
    return mock;
  }

  String _extractTime(String time) {
    if (time.contains('(')) return time.split('(')[0].trim();
    return time.split(' ')[0];
  }
}
