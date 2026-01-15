import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/quran_player_cubit/quran_player_state.dart';

class PlayerControlsWidget extends StatelessWidget {
  const PlayerControlsWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 10.toH),
    padding: EdgeInsets.only(left: 14.toW, right: 14.toW, bottom: 12.toH),
    decoration: BoxDecoration(
      color: context.theme.primaryColor,
      borderRadius: BorderRadius.circular(30.toR),
    ),
    child: const Column(
      mainAxisSize: MainAxisSize.min,
      children: [_PlayerSlider(), _PlayerButtons()],
    ),
  );
}

class _PlayerSlider extends StatelessWidget {
  const _PlayerSlider();

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<QuranPlayerCubit, QuranPlayerState>(
        buildWhen: (previous, current) =>
            previous.currentPosition != current.currentPosition ||
            previous.totalDuration != current.totalDuration,
        builder: (context, state) => Column(
          children: [
            SfSlider(
              activeColor: Colors.white,
              inactiveColor: Colors.white.withAlpha(80),
              value: state.currentPosition.inSeconds.toDouble().clamp(
                0.0,
                state.totalDuration.inSeconds.toDouble().clamp(
                  1.0,
                  double.infinity,
                ),
              ),
              max: state.totalDuration.inSeconds > 0
                  ? state.totalDuration.inSeconds.toDouble()
                  : 1,
              onChanged: (value) {
                context.read<QuranPlayerCubit>().seek(
                  Duration(seconds: (value as double).toInt()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.toW),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(state.currentPosition),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _formatDuration(state.totalDuration),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _PlayerButtons extends StatelessWidget {
  const _PlayerButtons();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<QuranPlayerCubit, QuranPlayerState, bool>(
        selector: (state) => state.isPlaying,
        builder: (context, isPlaying) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () =>
                  context.read<QuranPlayerCubit>().seekToPrevious(),
              icon: Icon(
                Icons.skip_previous_rounded,
                color: Colors.white,
                size: 36.toW,
              ),
              tooltip: 'السابق',
            ),
            const SizedBox(width: 24),
            _buildPlayPauseButton(context, isPlaying),
            const SizedBox(width: 24),
            IconButton(
              onPressed: () => context.read<QuranPlayerCubit>().seekToNext(),
              icon: Icon(
                Icons.skip_next_rounded,
                color: Colors.white,
                size: 36.toW,
              ),
              tooltip: 'التالي',
            ),
          ],
        ),
      );

  Widget _buildPlayPauseButton(BuildContext context, bool isPlaying) => InkWell(
    onTap: isPlaying
        ? () => context.read<QuranPlayerCubit>().pause()
        : () => context.read<QuranPlayerCubit>().play(),
    child: Container(
      width: 60.toW,
      height: 60.toH,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        size: 38.toW,
        color: context.theme.primaryColor,
      ),
    ),
  );
}
