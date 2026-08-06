import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/qiblah/presentation/cubit/qiblah_cubit.dart';
import 'package:muslim/features/qiblah/presentation/cubit/qiblah_state.dart';
import 'package:muslim/features/qiblah/presentation/views/widgets/qiblah_error_widget.dart';
import 'package:muslim/features/qiblah/presentation/views/widgets/qiblah_success_widget.dart';

class QiblahView extends StatefulWidget {
  const QiblahView({super.key});

  @override
  State<QiblahView> createState() => _QiblahViewState();
}

class _QiblahViewState extends State<QiblahView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showQiblahTour(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = getIt<QiblahCubit>();
      unawaited(cubit.init());
      return cubit;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.qiblahDirection),
        actions: [
          IconButton(
            onPressed: () => unawaited(
              AppTourHelper.showQiblahTour(context, force: true),
            ),
            icon: const Icon(Icons.explore_outlined),
            tooltip: context.l10n.tourQiblahTitle,
          ),
        ],
      ),
      body: KeyedSubtree(
        key: AppTourKeys.qiblahCompassKey,
        child: BlocSelector<QiblahCubit, QiblahState, QiblahState>(
          selector: (state) => state,
          builder: (context, state) {
            if (state.status == QiblahStatus.error) {
              return QiblahErrorWidget(message: state.message ?? '');
            }

            return QiblahSuccessWidget(
              headingAngle: state.headingAngle,
              qiblahAngle: state.qiblahAngle,
              isAligned: state.isAligned,
              isLoading: state.status == QiblahStatus.loading,
            );
          },
        ),
      ),
    ),
  );
}
