import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../viewmodel/prayer_times_cubit.dart';
import 'all_prayer_times_modal.dart';

class MorePrayerTimesButton extends StatelessWidget {
  const MorePrayerTimesButton({
    required this.theme,
    required this.hijriDate,
    super.key,
  });

  final ThemeData theme;
  final String hijriDate;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => showAllPrayerTimes(context),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Row(
          children: [
            Text(
              'اضغط لعرض المزيد من اوقات الصلاه',
              style: theme.textTheme.bodySmall,
            ),
            const Spacer(),
            Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    ),
  );

  void showAllPrayerTimes(BuildContext context) {
    final state = context.read<PrayerTimesCubit>().state;
    final timingsMap = state.localPrayerTimes?.toMap() ?? {};

    showCustomModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AllPrayerTimesModal(
        timingsMap: timingsMap,
        theme: theme,
        nextPrayer: state.nextPrayer,
        hijriDate: hijriDate,
      ),
    );
  }
}
