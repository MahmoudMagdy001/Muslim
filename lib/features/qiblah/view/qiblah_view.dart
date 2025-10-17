import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/qiblah_cubit.dart';
import '../viewmodel/qiblah_state.dart';
import 'widgets/compass_widget.dart';
import 'widgets/qiblah_map_widget.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('اتجاه القبلة')),
    body: BlocBuilder<QiblahCubit, QiblahState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.qiblahAngle != current.qiblahAngle ||
          previous.routePoints != current.routePoints,
      builder: (context, state) {
        if (state.status == QiblahStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('حدث خطأ: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<QiblahCubit>().init();
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        } else {
          return QiblahSuccessWidget(
            headingAngle: state.headingAngle,
            qiblahAngle: state.qiblahAngle,
            isAligned: state.isAligned,
            userLocation: state.userLocation != null
                ? LatLng(
                    state.userLocation!.latitude,
                    state.userLocation!.longitude,
                  )
                : null,
            isLoading: state.status == QiblahStatus.loading,
          );
        }
      },
    ),
  );
}

class QiblahSuccessWidget extends StatelessWidget {
  const QiblahSuccessWidget({
    required this.headingAngle,
    required this.qiblahAngle,
    required this.isAligned,
    required this.isLoading,
    this.userLocation,
    super.key,
  });

  final double headingAngle;
  final double qiblahAngle;
  final bool isAligned;
  final LatLng? userLocation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        _buildBackgroundGradient(theme),
        SafeArea(
          child: Column(
            children: [
              QiblahMapWidget(
                userLocation: userLocation != null
                    ? LatLng(userLocation!.latitude, userLocation!.longitude)
                    : null,
                isLoading: isLoading,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: CompassWidget(
                  headingAngle: headingAngle,
                  qiblahAngle: qiblahAngle,
                  isAligned: isAligned,
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundGradient(ThemeData theme) {
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
          colors: isDark
              ? AppColors.darkGradientColors
              : AppColors.lightGradientColors,
        ),
      ),
    );
  }
}
