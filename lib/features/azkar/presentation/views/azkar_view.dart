import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/azkar/presentation/bloc/azkar_bloc.dart';
import 'package:muslim/features/azkar/presentation/views/widgets/azkar_category_card.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_state.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({this.showAppBar = true, super.key});

  final bool showAppBar;

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showAzkarTour(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final bloc = getIt<AzkarBloc>();
      unawaited(bloc.loadAzkar());
      return bloc;
    },
    child: Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              key: AppTourKeys.azkarTitleKey,
              title: Text(context.l10n.azkar),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => unawaited(
                    AppTourHelper.showAzkarTour(context, force: true),
                  ),
                  icon: const Icon(Icons.explore_outlined),
                  tooltip: context.l10n.tourAzkarTitle,
                ),
              ],
            )
          : null,
      body: BlocSelector<AzkarBloc, AzkarState, AzkarState>(
        selector: (state) => state,
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message ?? context.l10n.azkarError,
                      style: context.typography.body.copyWith(
                        color: context.colors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<AzkarBloc>().loadAzkar(),
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

          if (state.groupedAzkar.isEmpty) {
            return Center(
              child: Text(
                context.l10n.azkarError,
                style: context.typography.body.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            );
          }

          final categories = state.groupedAzkar.keys.toList();

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final azkar = state.groupedAzkar[category] ?? const [];
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
  );
}
