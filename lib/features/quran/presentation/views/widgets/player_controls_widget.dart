import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_state.dart';
import 'package:quran/quran.dart' as quran;
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Modern Islamic floating dock player controls
class PlayerControlsWidget extends StatelessWidget {
  const PlayerControlsWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<QuranPlayerBloc, QuranPlayerState>(
        buildWhen: (previous, current) =>
            previous.isPlaying != current.isPlaying ||
            previous.currentAyah != current.currentAyah ||
            previous.currentSurah != current.currentSurah,
        builder: (context, state) {
          final isPlaying = state.isPlaying;
          final colors = context.colors;

          return AnimatedContainer(
            duration: context.durations.normal,
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: isPlaying ? 10.h : 6.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: isPlaying ? 10.h : 6.h,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors.isDark
                    ? [
                        const Color(0xFF183D33),
                        const Color(0xFF102721),
                      ]
                    : [
                        const Color(0xFF143B33),
                        const Color(0xFF1E4E43),
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(isPlaying ? 24.r : 32.r),
              border: Border.all(
                color: colors.secondary.withValues(alpha: 0.45),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.28),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isPlaying && state.currentSurah != null && state.currentAyah != null)
                  _PlayerHeaderInfo(
                    surah: state.currentSurah!,
                    ayah: state.currentAyah!,
                  ),
                if (isPlaying) const _PlayerSlider(),
                _PlayerButtons(isPlaying: isPlaying),
              ],
            ),
          );
        },
      );
}

class _PlayerHeaderInfo extends StatelessWidget {
  const _PlayerHeaderInfo({
    required this.surah,
    required this.ayah,
  });

  final int surah;
  final int ayah;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final surahName = isArabic ? quran.getSurahNameArabic(surah) : quran.getSurahName(surah);
    final ayahText = isArabic
        ? 'آية ${convertToArabicNumbers(ayah.toString())}'
        : 'Verse $ayah';

    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.volume_up_rounded,
            size: 14.r,
            color: const Color(0xFFFFD54F),
          ),
          SizedBox(width: 6.w),
          Text(
            'سورة $surahName • $ayahText',
            style: context.typography.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.5.sp,
            ),
          ),
        ],
      ),
    );
  }
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
      BlocBuilder<QuranPlayerBloc, QuranPlayerState>(
        buildWhen: (previous, current) =>
            previous.currentPosition != current.currentPosition ||
            previous.totalDuration != current.totalDuration,
        builder: (context, state) => Column(
          children: [
            SfSlider(
              activeColor: const Color(0xFFFFD54F),
              inactiveColor: Colors.white.withValues(alpha: 0.25),
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
              onChanged: (value) async {
                await context.read<QuranPlayerBloc>().seek(
                  Duration(seconds: (value as double).toInt()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(state.currentPosition),
                    style: context.typography.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    _formatDuration(state.totalDuration),
                    style: context.typography.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 10.sp,
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
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => context.read<QuranPlayerBloc>().seekToPrevious(),
          icon: Icon(
            Icons.skip_previous_rounded,
            color: Colors.white,
            size: isPlaying ? 28.r : 24.r,
          ),
          tooltip: 'السابق',
        ),
        SizedBox(width: isPlaying ? 20.w : 14.w),
        _PlayPauseButton(isPlaying: isPlaying),
        SizedBox(width: isPlaying ? 20.w : 14.w),
        IconButton(
          onPressed: () => context.read<QuranPlayerBloc>().seekToNext(),
          icon: Icon(
            Icons.skip_next_rounded,
            color: Colors.white,
            size: isPlaying ? 28.r : 24.r,
          ),
          tooltip: 'التالي',
        ),
      ],
    ),
  );
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.isPlaying});
  final bool isPlaying;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: isPlaying
        ? () => context.read<QuranPlayerBloc>().pause()
        : () => context.read<QuranPlayerBloc>().play(),
    borderRadius: BorderRadius.circular(999),
    child: AnimatedContainer(
      duration: context.durations.normal,
      width: isPlaying ? 48.r : 40.r,
      height: isPlaying ? 48.r : 40.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFE082),
            Color(0xFFC59F48),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC59F48).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        size: isPlaying ? 30.r : 24.r,
        color: const Color(0xFF143B33),
      ),
    ),
  );
}
