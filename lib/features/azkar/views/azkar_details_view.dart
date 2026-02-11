import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/utils/custom_loading_indicator.dart';
import '../../../core/utils/extensions.dart';
import '../../prayer_times/viewmodel/prayer_times_state.dart';
import '../models/azkar_model.dart';
import '../viewmodels/azkar_cubit.dart';
import '../viewmodels/azkar_state.dart';
import 'widgets/azkar_item_card.dart';

class AzkarDetailsView extends StatelessWidget {
  const AzkarDetailsView({required this.azkar, super.key});
  final AzkarModel azkar;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<AzkarCubit>()..loadAzkarContent(azkar.textUrl),
    child: Scaffold(
      appBar: AppBar(title: Text(azkar.title), centerTitle: true),
      body: Builder(
        builder: (context) => InternetStateManager(
          noInternetScreen: const NoInternetScreen(),
          onRestoreInternetConnection: () =>
              context.read<AzkarCubit>().loadAzkarContent(azkar.textUrl),
          child: BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              if (state.contentStatus == RequestStatus.loading) {
                return Center(
                  child: CustomLoadingIndicator(
                    text: context.l10n.azkarLoadingText,
                  ),
                );
              }

              if (state.contentStatus == RequestStatus.failure) {
                return Center(
                  child: Text(
                    state.message ?? context.l10n.azkarError,
                    style: context.textTheme.bodyLarge,
                  ),
                );
              }

              if (state.currentContent.isEmpty) {
                return Center(child: Text(context.l10n.azkarError));
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                itemCount: state.currentContent.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final content = state.currentContent[index];
                  return AzkarItemCard(
                    content: content,
                    currentCount: state.currentCounts[index] ?? content.repeat,
                    onIncrement: () => context
                        .read<AzkarCubit>()
                        .decrementCount(azkar.textUrl, index),
                    onReset: () => context.read<AzkarCubit>().resetCount(
                      azkar.textUrl,
                      index,
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
