import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions.dart';
import '../cubit/qiblah_cubit.dart';
import '../cubit/qiblah_state.dart';
import 'widgets/qiblah_error_widget.dart';
import 'widgets/qiblah_success_widget.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.qiblahDirection)),
    body: BlocBuilder<QiblahCubit, QiblahState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.qiblahAngle != current.qiblahAngle,
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
  );
}
