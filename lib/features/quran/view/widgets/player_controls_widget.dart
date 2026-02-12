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
  Widget build(BuildContext context) =>
      BlocBuilder<QuranPlayerCubit, QuranPlayerState>(
        buildWhen: (previous, current) =>
            previous.isPlaying != current.isPlaying,
        builder: (context, state) {
          final isPlaying = state.isPlaying;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(
              horizontal: 10.toW,
              vertical: isPlaying ? 10.toH : 5.toH,
            ),
            padding: EdgeInsets.only(
              left: 14.toW,
              right: 14.toW,
              bottom: isPlaying ? 12.toH : 4.toH,
              top: isPlaying ? 0 : 4.toH,
            ),
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              borderRadius: BorderRadius.circular(isPlaying ? 30.toR : 40.toR),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isPlaying) const _PlayerSlider(),
                _PlayerButtons(isPlaying: isPlaying),
              ],
            ),
          );
        },
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
  const _PlayerButtons({required this.isPlaying});
  final bool isPlaying;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: () => context.read<QuranPlayerCubit>().seekToPrevious(),
        icon: Icon(
          Icons.skip_previous_rounded,
          color: Colors.white,
          size: isPlaying ? 36.toW : 28.toW,
        ),
        tooltip: 'السابق',
      ),
      SizedBox(width: isPlaying ? 24 : 16),
      _buildPlayPauseButton(context, isPlaying),
      SizedBox(width: isPlaying ? 24 : 16),
      IconButton(
        onPressed: () => context.read<QuranPlayerCubit>().seekToNext(),
        icon: Icon(
          Icons.skip_next_rounded,
          color: Colors.white,
          size: isPlaying ? 36.toW : 28.toW,
        ),
        tooltip: 'التالي',
      ),
    ],
  );

  Widget _buildPlayPauseButton(BuildContext context, bool isPlaying) => InkWell(
    onTap: isPlaying
        ? () => context.read<QuranPlayerCubit>().pause()
        : () => context.read<QuranPlayerCubit>().play(),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isPlaying ? 60.toW : 48.toW,
      height: isPlaying ? 60.toH : 48.toH,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        size: isPlaying ? 38.toW : 30.toW,
        color: context.theme.primaryColor,
      ),
    ),
  );
}
