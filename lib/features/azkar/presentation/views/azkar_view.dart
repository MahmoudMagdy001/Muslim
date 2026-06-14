import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_state.dart';
import 'package:muslim/features/azkar/presentation/views/widgets/azkar_category_card.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_state.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = getIt<AzkarCubit>();
      unawaited(cubit.loadAzkar());
      return cubit;
    },
    child: Scaffold(
      appBar: AppBar(title: Text(context.l10n.azkar), centerTitle: true),
      body: Builder(
        builder: (context) => InternetStateManager(
          noInternetScreen: const NoInternetScreen(),
          onRestoreInternetConnection: () =>
              context.read<AzkarCubit>().loadAzkar(),
          child: BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              if (state.status == RequestStatus.loading) {
                return Center(
                  child: CustomLoadingIndicator(
                    text: context.l10n.azkarLoadingText,
                  ),
                );
              }

              if (state.status == RequestStatus.failure) {
                return Center(
                  child: Text(
                    state.message ?? context.l10n.azkarError,
                    style: context.textTheme.bodyLarge,
                  ),
                );
              }

              if (state.groupedAzkar.isEmpty) {
                return Center(child: Text(context.l10n.azkarError));
              }

              final categories = state.groupedAzkar.keys.toList();

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final azkar = state.groupedAzkar[category]!;
                  return AzkarCategoryCard(
                    category: category,
                    count: azkar.length,
                    index: index + 1,
                    onTap: () {},
                    items: azkar,
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
