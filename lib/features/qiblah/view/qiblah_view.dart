import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/format_helper.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/qiblah_cubit.dart';
import '../viewmodel/qiblah_state.dart';
import 'widgets/compass_widget.dart';
import 'widgets/full_map_view.dart';
import 'widgets/qiblah_error_widget.dart';
import 'widgets/qiblah_loading_widget.dart';

class QiblahView extends StatefulWidget {
  const QiblahView({super.key});

  @override
  State<QiblahView> createState() => _QiblahViewState();
}

class _QiblahViewState extends State<QiblahView> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('اتجاه القبلة')),
    body: BlocBuilder<QiblahCubit, QiblahState>(
      buildWhen: (p, c) =>
          p.qiblahAngle != c.qiblahAngle || p.routePoints != c.routePoints,
      builder: (context, state) {
        switch (state.status) {
          case QiblahStatus.loading:
            return const QiblahLoadingWidget();
          case QiblahStatus.error:
            return QiblahErrorWidget(message: state.message);
          case QiblahStatus.success:
          default:
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
    this.userLocation,
    super.key,
  });

  final double headingAngle;
  final double qiblahAngle;
  final bool isAligned;
  final LatLng? userLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        _buildBackgroundGradient(theme),
        SafeArea(
          child: Column(
            children: [
              BlocSelector<QiblahCubit, QiblahState, LatLng?>(
                selector: (state) => state.userLocation != null
                    ? LatLng(
                        state.userLocation!.latitude,
                        state.userLocation!.longitude,
                      )
                    : null,
                builder: (context, userLocation) =>
                    QiblahMapWidget(userLocation: userLocation),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: CompassWidget(
                  headingAngle: headingAngle,
                  qiblahAngle: qiblahAngle,
                  isAligned: isAligned,
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

class QiblahMapWidget extends StatelessWidget {
  const QiblahMapWidget({this.userLocation, super.key});

  final LatLng? userLocation;

  static const LatLng _kaabaLocation = LatLng(21.4225, 39.8262);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Skeletonizer(
      enabled: userLocation == null,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            FullMapView(userLocation: userLocation!),
                      ),
                    );
                  },
                  initialCenter: userLocation ?? _kaabaLocation,
                  initialZoom: 5,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.muslim',
                  ),
                  if (userLocation != null)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [userLocation!, _kaabaLocation],
                          strokeWidth: 3,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  if (userLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: userLocation!,
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.my_location,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const Marker(
                          point: _kaabaLocation,
                          width: 40,
                          height: 40,
                          child: Image(
                            image: AssetImage('assets/images/kaaba.png'),
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            if (userLocation != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DistanceText(userLocation: userLocation!),
              ),
          ],
        ),
      ),
    );
  }
}

class DistanceText extends StatelessWidget {
  const DistanceText({required this.userLocation, super.key});

  final LatLng userLocation;
  static const LatLng _kaabaLocation = LatLng(21.4225, 39.8262);

  @override
  Widget build(BuildContext context) {
    const distanceCalc = Distance();
    final km = distanceCalc.as(
      LengthUnit.Kilometer,
      userLocation,
      _kaabaLocation,
    );

    return Text(
      'المسافة إلى الكعبة: ${convertToArabicNumbers(km.toStringAsFixed(2))} كم',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
