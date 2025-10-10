import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../viewmodel/qiblah_cubit.dart';
import '../viewmodel/qiblah_state.dart';
import 'widgets/compass_widget.dart';
import 'widgets/qiblah_error_widget.dart';
import 'widgets/qiblah_loading_widget.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('اتجاه القبلة')),
    body: BlocBuilder<QiblahCubit, QiblahState>(
      builder: (context, state) => switch (state.status) {
        QiblahStatus.loading => const QiblahLoadingWidget(),
        QiblahStatus.error => QiblahErrorWidget(message: state.message),
        _ => QiblahSuccessWidget(
          headingAngle: state.headingAngle,
          qiblahAngle: state.qiblahAngle,
          isAligned: state.isAligned,
        ),
      },
    ),
  );
}

class QiblahSuccessWidget extends StatelessWidget {
  const QiblahSuccessWidget({
    required this.headingAngle,
    required this.qiblahAngle,
    required this.isAligned,
    super.key,
  });

  final double headingAngle;
  final double qiblahAngle;
  final bool isAligned;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      _buildBackgroundGradient(context),
      SafeArea(
        child: CompassWidget(
          headingAngle: headingAngle,
          qiblahAngle: qiblahAngle,
          isAligned: isAligned,
        ),
      ),
    ],
  );

  Widget _buildBackgroundGradient(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
          colors: isDark ? AppColors.darkGradientColors : AppColors.lightGradientColors,
        ),
      ),
    );
  }
}
