import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_audio_cubit.dart';

class AzkarItemCard extends StatefulWidget {
  const AzkarItemCard({
    required this.content,
    required this.currentCount,
    required this.onIncrement,
    required this.onReset,
    super.key,
  });

  final AzkarContentEntity content;
  final int currentCount;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  @override
  State<AzkarItemCard> createState() => _AzkarItemCardState();
}

class _AzkarItemCardState extends State<AzkarItemCard> {
  late final AzkarAudioCubit _audioCubit;

  @override
  void initState() {
    super.initState();
    _audioCubit = getIt<AzkarAudioCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isFinished = widget.currentCount <= 0;
    final totalCount = widget.content.repeat;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return AnimatedContainer(
      duration: context.durations.normal,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: context.radius.lgBorder,
        border: Border.all(
          color: isFinished ? colors.secondary : colors.border,
          width: isFinished ? 1.5 : 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: colors.isDark ? 0.2 : 0.03,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.content.arabicText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(
                    fontSize: 20.sp,
                    height: 1.8,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                if (widget.content.translatedText.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Text(
                    widget.content.translatedText,
                    textAlign: TextAlign.justify,
                    style: context.typography.body.copyWith(
                      color: colors.textSecondary,
                      height: 1.6,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
            child: Row(
              children: [
                // Big Tasbih Counter Button
                Expanded(
                  child: SizedBox(
                    height: 46.h,
                    child: ElevatedButton(
                      onPressed: isFinished
                          ? null
                          : () async {
                              await HapticFeedback.mediumImpact();
                              widget.onIncrement();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFinished
                            ? colors.surfaceVariant
                            : colors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        disabledBackgroundColor: colors.surfaceVariant,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isFinished
                                ? Icons.check_circle_rounded
                                : Icons.touch_app_rounded,
                            size: 18.r,
                            color: isFinished ? colors.secondary : Colors.white,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            isFinished
                                ? (isArabic ? 'اكتمل' : 'Completed')
                                : context.l10n.tasbih,
                            style: context.typography.labelLarge.copyWith(
                              color: isFinished ? colors.secondary : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                // Audio Button
                BlocBuilder<AzkarAudioCubit, AzkarAudioState>(
                  bloc: _audioCubit,
                  builder: (context, audioState) {
                    final isThisPlaying = audioState.url == widget.content.audio;
                    final isLoading =
                        isThisPlaying &&
                        audioState.status == AzkarAudioStatus.loading;
                    final isPlaying =
                        isThisPlaying &&
                        audioState.status == AzkarAudioStatus.playing;

                    return IconButton(
                      onPressed: () async {
                        await HapticFeedback.lightImpact();
                        if (isPlaying) {
                          await _audioCubit.stopAudio();
                        } else {
                          await _audioCubit.playAudio(
                            widget.content.audio,
                            title: widget.content.arabicText,
                          );
                        }
                      },
                      icon: isLoading
                          ? SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.r,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colors.secondary,
                                ),
                              ),
                            )
                          : Icon(
                              isPlaying
                                  ? Icons.stop_circle_rounded
                                  : Icons.volume_up_rounded,
                              color: colors.secondary,
                            ),
                      iconSize: 26.r,
                      tooltip: isPlaying
                          ? (isArabic ? 'إيقاف' : 'Stop')
                          : (isArabic ? 'استماع' : 'Listen'),
                    );
                  },
                ),

                // Reset Button
                IconButton(
                  onPressed: () async {
                    await HapticFeedback.lightImpact();
                    widget.onReset();
                  },
                  icon: Icon(
                    Icons.replay_rounded,
                    color: colors.textSecondary,
                  ),
                  iconSize: 22.r,
                  tooltip: isArabic ? 'إعادة' : 'Reset',
                ),

                SizedBox(width: 4.w),

                // Counter numbers
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: colors.border,
                      width: 0.6,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isArabic
                            ? convertToArabicNumbers(widget.currentCount.toString())
                            : widget.currentCount.toString(),
                        style: context.typography.titleMedium.copyWith(
                          color: isFinished ? colors.secondary : colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' / ',
                        style: context.typography.caption.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      Text(
                        isArabic
                            ? convertToArabicNumbers(totalCount.toString())
                            : totalCount.toString(),
                        style: context.typography.caption.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
