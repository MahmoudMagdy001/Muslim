// // ignore_for_file: avoid_dynamic_calls, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:hijri/hijri_calendar.dart';
// import '../../../../core/utils/custom_loading_indicator.dart';
// import '../../../../core/utils/format_helper.dart';
// import '../../service/prayer_times_service.dart';

// class MonthPrayerTimesWidget extends StatefulWidget {
//   const MonthPrayerTimesWidget({required this.isArabic, super.key});
//   final bool isArabic;

//   @override
//   State<MonthPrayerTimesWidget> createState() => _MonthPrayerTimesWidgetState();
// }

// class _MonthPrayerTimesWidgetState extends State<MonthPrayerTimesWidget> {
//   late Future<List<Map<String, String>>> _prayerTimesFuture;
//   late PageController _pageController;
//   late ValueNotifier<int> _currentPage;
//   final _service = PrayerTimesService();

//   @override
//   void initState() {
//     super.initState();
//     _prayerTimesFuture = _getPrayerTimesFromService();
//     _pageController = PageController();
//     _currentPage = ValueNotifier(0);
//   }

//   Future<List<Map<String, String>>> _getPrayerTimesFromService() async {
//     try {
//       final monthlyData = await _service.getPrayerTimes(
//         isArabic: widget.isArabic,
//         forMonth: true,
//       );

//       final now = DateTime.now();
//       final List<Map<String, String>> result = [];
//       int day = 1;

//       for (final item in monthlyData) {
//         final currentDate = DateTime(now.year, now.month, day);
//         final hijri = HijriCalendar.fromDate(currentDate);

//         final hijriDate = _getHijriDate(hijri, widget.isArabic);

//         final isToday = day == now.day;

//         result.add({
//           'gregorianDate': DateFormat('dd-MM-yyyy').format(currentDate),
//           'hijriDate': hijriDate,
//           'fajr': item.fajr,
//           'dhuhr': item.dhuhr,
//           'asr': item.asr,
//           'maghrib': item.maghrib,
//           'isha': item.isha,
//           'isToday': isToday.toString(),
//         });

//         day++;
//       }

//       return result;
//     } catch (e) {
//       debugPrint('❌ خطأ أثناء جلب البيانات من السيرفيس: $e');
//       return [];
//     }
//   }

//   /// دالة لحساب التاريخ الهجري لأي يوم
//   static String _getHijriDate(HijriCalendar hijri, bool isArabic) {
//     final day = isArabic
//         ? convertToArabicNumbers(hijri.hDay.toString())
//         : hijri.hDay.toString();
//     final year = isArabic
//         ? convertToArabicNumbers(hijri.hYear.toString())
//         : hijri.hYear.toString();
//     final monthName = isArabic
//         ? getArabicMonthName(hijri.hMonth)
//         : getEnglishHijriMonthName(hijri.hMonth);
//     return '$day $monthName $year ${isArabic ? 'هـ' : 'Hijri'}';
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _currentPage.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('مواقيت الصلاة')),
//       body: SafeArea(
//         child: FutureBuilder<List<Map<String, String>>>(
//           future: _prayerTimesFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return _buildLoadingWidget();
//             }

//             if (snapshot.hasError) {
//               return _buildErrorWidget();
//             }

//             final prayerTimes = snapshot.data ?? [];
//             if (prayerTimes.isEmpty) {
//               return _buildEmptyWidget();
//             }

//             final initialPageIndex = prayerTimes.indexWhere(
//               (d) => d['isToday'] == 'true',
//             );
//             if (initialPageIndex != -1 &&
//                 _pageController.initialPage != initialPageIndex) {
//               _pageController = PageController(initialPage: initialPageIndex);
//               _currentPage.value = initialPageIndex;
//             }

//             return _buildPrayerPager(prayerTimes, theme);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingWidget() =>
//       const CustomLoadingIndicator(text: 'جاري تحميل مواقيت الصلاه');

//   Widget _buildErrorWidget() => Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Icon(Icons.error_outline, size: 64, color: Colors.grey),
//         const SizedBox(height: 16),
//         const Text('حدث خطأ أثناء تحميل البيانات'),
//         const SizedBox(height: 16),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _prayerTimesFuture = _getPrayerTimesFromService();
//             });
//           },
//           child: const Text('إعادة المحاولة'),
//         ),
//       ],
//     ),
//   );

//   Widget _buildEmptyWidget() => const Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.warning_amber, size: 64, color: Colors.amber),
//         SizedBox(height: 16),
//         Text('لا توجد بيانات متاحة'),
//       ],
//     ),
//   );

//   Widget _buildPrayerPager(
//     List<Map<String, String>> prayerTimes,
//     ThemeData theme,
//   ) {
//     _pageController.addListener(() {
//       final newPage = _pageController.page?.round() ?? 0;
//       if (newPage != _currentPage.value) _currentPage.value = newPage;
//     });

//     return ValueListenableBuilder<int>(
//       valueListenable: _currentPage,
//       builder: (context, index, _) {
//         final day = prayerTimes[index];
//         final isToday = day['isToday'] == 'true';
//         final gregorianDate = DateFormat(
//           'dd-MM-yyyy',
//         ).parse(day['gregorianDate']!);

//         // اسم اليوم
//         final weekday = widget.isArabic
//             ? DateFormat('EEEE', 'ar').format(gregorianDate)
//             : DateFormat('EEEE', 'en').format(gregorianDate);

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_rounded),
//                     onPressed: index > 0
//                         ? () => _pageController.previousPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           )
//                         : null,
//                     color: index > 0 ? theme.colorScheme.primary : Colors.grey,
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         // تحويل التاريخ النصي إلى DateTime
//                         Column(
//                           children: [
//                             Text(
//                               weekday, // اسم اليوم
//                               style: theme.textTheme.titleMedium!.copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 color: theme.colorScheme.onSurface.withOpacity(
//                                   0.8,
//                                 ),
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               widget.isArabic
//                                   ? convertToArabicNumbers(
//                                       day['gregorianDate']!,
//                                     )
//                                   : day['gregorianDate']!,
//                               style: theme.textTheme.titleLarge!.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: theme.colorScheme.primary,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               day['hijriDate']!,
//                               style: theme.textTheme.bodyMedium!.copyWith(
//                                 color: theme.colorScheme.onSurface.withOpacity(
//                                   0.7,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.arrow_forward_ios_rounded),
//                     onPressed: index < prayerTimes.length - 1
//                         ? () => _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           )
//                         : null,
//                     color: index < prayerTimes.length - 1
//                         ? theme.colorScheme.primary
//                         : Colors.grey,
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   itemCount: prayerTimes.length,
//                   onPageChanged: (int page) {
//                     _currentPage.value = page;
//                   },
//                   itemBuilder: (context, i) {
//                     final item = prayerTimes[i];
//                     final isCurrentToday = item['isToday'] == 'true';
//                     return Column(
//                       children: [
//                         Card(
//                           elevation: 4,
//                           clipBehavior: Clip.antiAlias,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             side: BorderSide(
//                               color: isCurrentToday
//                                   ? theme.colorScheme.primary
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                           ),
//                           child: Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 24,
//                               vertical: 20,
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 _buildPrayerTimeRow(
//                                   'الفجر',
//                                   item['fajr']!,
//                                   theme,
//                                 ),
//                                 _buildDivider(),
//                                 _buildPrayerTimeRow(
//                                   'الظهر',
//                                   item['dhuhr']!,
//                                   theme,
//                                 ),
//                                 _buildDivider(),
//                                 _buildPrayerTimeRow(
//                                   'العصر',
//                                   item['asr']!,
//                                   theme,
//                                 ),
//                                 _buildDivider(),
//                                 _buildPrayerTimeRow(
//                                   'المغرب',
//                                   item['maghrib']!,
//                                   theme,
//                                 ),
//                                 _buildDivider(),
//                                 _buildPrayerTimeRow(
//                                   'العشاء',
//                                   item['isha']!,
//                                   theme,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: theme.colorScheme.primary.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             widget.isArabic
//                                 ? convertToArabicNumbers(
//                                     '${i + 1} / ${prayerTimes.length}',
//                                   )
//                                 : '${i + 1} / ${prayerTimes.length}',
//                             style: theme.textTheme.bodyMedium!.copyWith(
//                               color: theme.colorScheme.primary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               if (isToday)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Text(
//                     'اليوم',
//                     style: theme.textTheme.titleSmall!.copyWith(
//                       color: theme.colorScheme.primary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPrayerTimeRow(String name, String time, ThemeData theme) =>
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(name, style: theme.textTheme.titleMedium),
//             Text(
//               formatTo12Hour(time, true),
//               style: theme.textTheme.titleSmall!.copyWith(
//                 color: theme.colorScheme.primary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       );

//   Widget _buildDivider() => Divider(height: 1, color: Colors.grey.shade300);
// }
