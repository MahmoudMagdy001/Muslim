import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/quran_player_cubit/quran_player_state.dart';

class PlayerControlsWidget extends StatefulWidget {
  const PlayerControlsWidget({super.key});

  @override
  State<PlayerControlsWidget> createState() => _PlayerControlsWidgetState();
}

class _PlayerControlsWidgetState extends State<PlayerControlsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 45, top: 15),
      child: BlocBuilder<QuranPlayerCubit, QuranPlayerState>(
        builder: (context, state) {
          String formatDuration(Duration d) {
            final minutes = d.inMinutes
                .remainder(60)
                .toString()
                .padLeft(2, '0');
            final seconds = d.inSeconds
                .remainder(60)
                .toString()
                .padLeft(2, '0');
            return '$minutes:$seconds';
          }

          return Column(
            children: [
              SfSlider(
                enableTooltip: true,
                activeColor: theme.colorScheme.primary,
                inactiveColor: theme.colorScheme.primary.withAlpha(40),
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
                    // ignore: avoid_dynamic_calls
                    Duration(seconds: value.toInt()),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(state.currentPosition),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      formatDuration(state.totalDuration),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    context: context,
                    icon: Icons.skip_previous_rounded,
                    tooltip: 'السابق',
                    onTap: () =>
                        context.read<QuranPlayerCubit>().seekToPrevious(),
                  ),
                  _buildControlButton(
                    context: context,
                    icon: state.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    tooltip: state.isPlaying ? 'إيقاف مؤقت' : 'تشغيل',
                    big: true,
                    onTap: state.isPlaying
                        ? () => context.read<QuranPlayerCubit>().pause()
                        : () => context.read<QuranPlayerCubit>().play(),
                  ),
                  _buildControlButton(
                    context: context,
                    icon: Icons.skip_next_rounded,
                    tooltip: 'التالي',
                    onTap: () => context.read<QuranPlayerCubit>().seekToNext(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildControlButton({
    required BuildContext context,
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool big = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(big ? 16 : 12),
        decoration: BoxDecoration(
          color: big ? colorScheme.primary : theme.cardColor,
          shape: BoxShape.circle,
          boxShadow: big
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.26 * 255).toInt()),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: big ? 28 : 22,
          color: big ? theme.colorScheme.onPrimary : theme.iconTheme.color,
        ),
      ),
    );
  }
}
