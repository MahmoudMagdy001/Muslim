import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/widgets/location_disclosure_dialog.dart';
import 'package:muslim/features/qiblah/presentation/bloc/qiblah_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await LocationDisclosureDialog.showIfNeeded(context);
        if (mounted) {
          unawaited(AppTourHelper.showQiblahTour(context));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final bloc = getIt<QiblahBloc>();
      unawaited(bloc.init());
      return bloc;
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
        child: BlocBuilder<QiblahBloc, QiblahState>(
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
