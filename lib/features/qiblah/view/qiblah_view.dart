import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/service/location_service.dart';
import 'widgets/compass_widget.dart';
import '../service/qiblah_service.dart';
import '../viewmodel/qiblah_cubit.dart';
import '../viewmodel/qiblah_state.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => _buildQuiblahCubit(),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('اتجاه القبلة')),
        body: BlocListener<QiblahCubit, QiblahState>(
          listenWhen: (prev, curr) =>
              prev.status != curr.status && curr.status == QiblahStatus.error,
          listener: (context, state) {
            if (state.message != null) {}
          },
          child: BlocBuilder<QiblahCubit, QiblahState>(
            builder: (context, state) {
              if (state.status == QiblahStatus.loading) {
                return _buildLoadingState();
              }

              if (state.status == QiblahStatus.error) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      state.message ?? '❌ حدث خطأ غير متوقع',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  _buildBackgroundGradient(context),
                  SafeArea(
                    child: CompassWidget(
                      headingAngle: state.headingAngle,
                      qiblahAngle: state.qiblahAngle,
                      isAligned: state.isAligned,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );

  QiblahCubit _buildQuiblahCubit() =>
      QiblahCubit(service: QiblahService(), locationService: LocationService())
        ..init();

  Widget _buildLoadingState() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildBackgroundGradient(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
          colors: isDark ? _darkGradientColors : _lightGradientColors,
        ),
      ),
    );
  }
}

const _darkGradientColors = [
  Color(0x8033A1E0),
  Color(0x661A5A8A),
  Color(0x4D0D3A5A),
];

const _lightGradientColors = [
  Color(0xFF33A1E0),
  Color(0xFF66B8E8),
  Colors.white,
];
