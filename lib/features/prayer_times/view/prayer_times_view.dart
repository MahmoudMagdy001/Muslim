import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_error_message.dart';
import '../helper/time_left_format.dart';
import '../viewmodel/prayer_times_cubit.dart';
import '../viewmodel/prayer_times_state.dart';
import '../repository/prayer_times_repository_impl.dart';
import '../service/prayer_times_service.dart';
import '../helper/prayer_consts.dart';
import 'widgets/prayer_tile.dart';
import 'widgets/prayer_tile_shimmer.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => _createPrayerTimesCubit(),
    child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        if (state.status == PrayerTimesStatus.loading) {
          return _buildLoadingState();
        } else if (state.status == PrayerTimesStatus.error) {
          return CustomErrorMessage(errorMessage: state.message);
        } else if (state.status == PrayerTimesStatus.success &&
            state.localPrayerTimes != null) {
          return _buildSuccessState(context, state);
        }
        return const SizedBox.shrink();
      },
    ),
  );
}

PrayerTimesCubit _createPrayerTimesCubit() => PrayerTimesCubit(
  repository: PrayerTimesNewRepositoryImpl(PrayerTimesService()),
)..init();

Widget _buildLoadingState() => GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: prayerOrder.length,
  padding: const EdgeInsets.all(12),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.9,
  ),
  itemBuilder: (context, index) => const PrayerTileShimmer(),
);

Widget _buildSuccessState(BuildContext context, PrayerTimesState state) {
  final theme = Theme.of(context);
  if (state.localPrayerTimes == null) {
    return const CustomErrorMessage(errorMessage: '❌ لا توجد بيانات للعرض');
  }

  final timingsMap = state.localPrayerTimes!.toMap();

  return Card(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? theme.colorScheme.primary.withAlpha(102)
                          : theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.mosque_outlined,
                      size: 20,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الصلاة القادمة',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        '${prayerNamesAr[state.nextPrayer] ?? state.nextPrayer}',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
              if (state.timeLeft != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? theme.colorScheme.primary.withAlpha(102)
                        : theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 20,
                          color: theme.brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          formatTimeLeft(state.timeLeft!),
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.brightness == Brightness.dark
                                ? Colors.white70
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: prayerOrder
                .map(
                  (prayerKey) => _buildPrayerTile(
                    prayerKey: prayerKey,
                    timing: timingsMap[prayerKey],
                    isNext: state.nextPrayer == prayerKey,
                    timeLeft: state.timeLeft,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPrayerTile({
  required String prayerKey,
  required String? timing,
  required bool isNext,
  required Duration? timeLeft,
}) {
  final formattedTime = timing ?? '00:00';
  final formattedTimeLeft = isNext && timeLeft != null
      ? formatTimeLeft(timeLeft)
      : null;

  return PrayerTile(
    prayerKey: prayerKey,
    timing: formattedTime,
    isNext: isNext,
    timeLeft: formattedTimeLeft,
  );
}
