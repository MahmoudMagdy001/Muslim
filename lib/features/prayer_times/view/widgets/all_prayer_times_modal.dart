// import 'package:flutter/material.dart';

// import '../../../../core/utils/format_helper.dart';
// import '../../../../core/utils/navigation_helper.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../../helper/prayer_consts.dart';
// import 'month_prayer_times_widget.dart';

// class AllPrayerTimesModal extends StatelessWidget {
//   const AllPrayerTimesModal({
//     required this.timingsMap,
//     required this.theme,
//     required this.nextPrayer,
//     required this.hijriDate,
//     required this.localizations,
//     required this.isArabic,
//     super.key,
//   });

//   final Map<String, String> timingsMap;
//   final ThemeData theme;
//   final String? nextPrayer;
//   final String hijriDate;
//   final AppLocalizations localizations;
//   final bool isArabic;

//   @override
//   Widget build(BuildContext context) => Column(
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.mosque_rounded, size: 24),
//                         const SizedBox(width: 8),
//                         Text(
//                           localizations.prayerTimesText,
//                           style: theme.textTheme.headlineSmall,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.calendar_month_outlined,
//                           size: 16,
//                           color: theme.colorScheme.primary,
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           hijriDate,
//                           style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.colorScheme.primary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: () => navigateWithTransition(
//                       type: TransitionType.fade,
//                       context,
//                       MonthPrayerTimesWidget(isArabic: isArabic),
//                     ),
//                     child: const Text('عرض الشهر'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),

//       Padding(
//         padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//         child: Column(
//           children: prayerOrder.map((prayerKey) {
//             final locale = Localizations.localeOf(context);
//             final isArabic = locale.languageCode == 'ar';

//             final timing = timingsMap[prayerKey] ?? '00:00';
//             final isNext = nextPrayer == prayerKey;

//             return Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: isNext
//                     ? Border.all(color: theme.colorScheme.primary)
//                     : null,
//               ),
//               child: ListTile(
//                 title: Text(
//                   isArabic ? prayerNamesAr[prayerKey] ?? prayerKey : prayerKey,
//                   style: theme.textTheme.titleMedium!.copyWith(
//                     fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
//                     color: isNext ? theme.colorScheme.primary : null,
//                   ),
//                 ),
//                 trailing: Text(
//                   formatTo12Hour(timing, isArabic),
//                   style: theme.textTheme.titleMedium!.copyWith(
//                     fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
//                     color: isNext ? theme.colorScheme.primary : null,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ],
//   );
// }
