import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/presentation/bloc/azkar_bloc.dart';
import 'package:muslim/features/azkar/presentation/views/widgets/azkar_item_card.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_state.dart';

class AzkarDetailsView extends StatelessWidget {
  const AzkarDetailsView({required this.azkar, super.key});
  final AzkarEntity azkar;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final bloc = getIt<AzkarBloc>();
      unawaited(bloc.loadAzkarContent(azkar.textUrl));
      return bloc;
    },
    child: Scaffold(
      appBar: AppBar(title: Text(azkar.title), centerTitle: true),
      body: BlocSelector<
        AzkarBloc,
        AzkarState,
        (RequestStatus, List<AzkarContentEntity>)
      >(
        selector: (state) => (state.contentStatus, state.currentContent),
        builder: (context, stateRecord) {
          final status = stateRecord.$1;
          final contentList = stateRecord.$2;

          if (status == RequestStatus.loading) {
            return Center(
              child: CustomLoadingIndicator(
                text: context.l10n.azkarLoadingText,
              ),
            );
          }

          if (status == RequestStatus.failure) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.read<AzkarBloc>().state.message ??
                          context.l10n.azkarError,
                      style: context.typography.body.copyWith(
                        color: context.colors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context
                          .read<AzkarBloc>()
                          .loadAzkarContent(azkar.textUrl),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: context.radius.mdBorder,
                        ),
                      ),
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          if (contentList.isEmpty) {
            return Center(
              child: Text(
                context.l10n.azkarError,
                style: context.typography.body.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 12.h,
            ),
            itemCount: contentList.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final content = contentList[index];
              return BlocSelector<AzkarBloc, AzkarState, int>(
                selector: (state) =>
                    state.currentCounts[index] ?? content.repeat,
                builder: (context, count) => AzkarItemCard(
                  content: content,
                  currentCount: count,
                  onIncrement: () => context
                      .read<AzkarBloc>()
                      .decrementCount(azkar.textUrl, index),
                  onReset: () => context.read<AzkarBloc>().resetCount(
                    azkar.textUrl,
                    index,
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
  );
}
