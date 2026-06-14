import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_state.dart';
import 'package:muslim/features/azkar/presentation/views/widgets/azkar_item_card.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_state.dart';

class AzkarDetailsView extends StatelessWidget {
  const AzkarDetailsView({required this.azkar, super.key});
  final AzkarEntity azkar;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = getIt<AzkarCubit>();
      unawaited(cubit.loadAzkarContent(azkar.textUrl));
      return cubit;
    },
    child: Scaffold(
      appBar: AppBar(title: Text(azkar.title), centerTitle: true),
      body: Builder(
        builder: (context) => InternetStateManager(
          noInternetScreen: const NoInternetScreen(),
          onRestoreInternetConnection: () =>
              context.read<AzkarCubit>().loadAzkarContent(azkar.textUrl),
          child:
              BlocSelector<
                AzkarCubit,
                AzkarState,
                (RequestStatus, List<AzkarContentEntity>)
              >(
                selector: (state) =>
                    (state.contentStatus, state.currentContent),
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
                      child: Text(
                        // We can't easily get the message here with just the tuple selector
                        // unless we include it. But usually failure message is stable.
                        // Let's access cubit state directly for message if needed or expand selector
                        context.read<AzkarCubit>().state.message ??
                            context.l10n.azkarError,
                        style: context.textTheme.bodyLarge,
                      ),
                    );
                  }

                  if (contentList.isEmpty) {
                    return Center(child: Text(context.l10n.azkarError));
                  }

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 12.h,
                    ),
                    itemCount: contentList.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final content = contentList[index];
                      return BlocSelector<AzkarCubit, AzkarState, int>(
                        selector: (state) =>
                            state.currentCounts[index] ?? content.repeat,
                        builder: (context, count) => AzkarItemCard(
                          content: content,
                          currentCount: count,
                          onIncrement: () => context
                              .read<AzkarCubit>()
                              .decrementCount(azkar.textUrl, index),
                          onReset: () => context.read<AzkarCubit>().resetCount(
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
      ),
    ),
  );
}
