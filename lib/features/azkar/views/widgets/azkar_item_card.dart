import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/extensions.dart';
import '../../models/azkar_model.dart';
import '../../services/azkar_audio_service.dart';

class AzkarItemCard extends StatelessWidget {
  const AzkarItemCard({
    required this.content,
    required this.currentCount,
    required this.onIncrement,
    required this.onReset,
    super.key,
  });

  final AzkarContentModel content;
  final int currentCount;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isFinished = currentCount <= 0;
    final totalCount = content.repeat;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isFinished ? theme.colorScheme.secondary : Colors.transparent,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  content.arabicText,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    height: 1.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                if (content.translatedText.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  Text(
                    content.translatedText,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      height: 1.6,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Row(
              children: [
                // زر التسبيح - ياخد أكبر مساحة
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: isFinished
                          ? null
                          : () {
                              HapticFeedback.mediumImpact();
                              onIncrement();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: theme.colorScheme.onSecondary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        disabledBackgroundColor: Colors.grey.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      child: Text(
                        context.l10n.tasbih,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isFinished ? Colors.white38 : null,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                // زر الصوت
                StreamBuilder<AzkarAudioState>(
                  stream: getIt<AzkarAudioService>().stateStream,
                  builder: (context, snapshot) {
                    final audioState = snapshot.data;
                    final isThisPlaying = audioState?.url == content.audio;
                    final isLoading =
                        isThisPlaying &&
                        audioState?.status == AzkarAudioStatus.loading;
                    final isPlaying =
                        isThisPlaying &&
                        audioState?.status == AzkarAudioStatus.playing;

                    return IconButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        getIt<AzkarAudioService>().play(
                          content.audio,
                          title: content.arabicText,
                        );
                      },
                      icon: isLoading
                          ? SizedBox(
                              width: 24.r,
                              height: 24.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.r,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              isPlaying ? Icons.stop_circle : Icons.play_circle,
                              color: Colors.white,
                            ),
                      iconSize: 32.r,
                      tooltip: isPlaying ? 'إيقاف' : 'تشغيل',
                    );
                  },
                ),

                //     return IconButton(
                //       onPressed: () {
                //         HapticFeedback.lightImpact();
                //         getIt<AzkarAudioService>().play(
                //           content.audio,
                //           title: content.arabicText,
                //         );
                //       },
                //       icon: isLoading
                //           ? SizedBox(
                //               width: 24.r,
                //               height: 24.r,
                //               child: CircularProgressIndicator(
                //                 strokeWidth: 2.r,
                //                 color: Colors.white,
                //               ),
                //             )
                //           : Icon(
                //               isPlaying ? Icons.stop_circle : Icons.play_circle,
                //               color: Colors.white,
                //             ),
                //       iconSize: 32.r,
                //       tooltip: isPlaying ? 'إيقاف' : 'تشغيل',
                //     );
                //   },
                // ),
                SizedBox(width: 4.w),

                // زر الإعادة - في النص
                IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onReset();
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  iconSize: 28.r,
                  tooltip: 'إعادة العداد',
                ),

                SizedBox(width: 8.w),

                // الأرقام - في الآخر
                Row(
                  children: [
                    Text(
                      currentCount.toString(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' / ',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      totalCount.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
