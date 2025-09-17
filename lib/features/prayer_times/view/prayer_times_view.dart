import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/service/location_service.dart';
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
            state.response != null) {
          return _buildSuccessState(context, state);
        }
        return const SizedBox.shrink();
      },
    ),
  );
}

PrayerTimesCubit _createPrayerTimesCubit() => PrayerTimesCubit(
  repository: PrayerTimesNewRepositoryImpl(PrayerTimesService()),
  locationService: LocationService(),
)..init();

Widget _buildLoadingState() => ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: prayerOrder.length,
  itemBuilder: (context, index) => const PrayerTileShimmer(),
);

Widget _buildSuccessState(BuildContext context, PrayerTimesState state) {
  if (state.response == null) {
    return const CustomErrorMessage(errorMessage: '❌ لا توجد بيانات للعرض');
  }

  final timings = state.response!.data.timings;
  final timingsMap = timings.toMap();

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: prayerOrder.length,
    itemBuilder: (context, index) {
      final prayerKey = prayerOrder[index];
      return _buildPrayerTile(
        prayerKey: prayerKey,
        timing: timingsMap[prayerKey],
        isNext: state.nextPrayer == prayerKey,
        timeLeft: state.timeLeft,
      );
    },
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
