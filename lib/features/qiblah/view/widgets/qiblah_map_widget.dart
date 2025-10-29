import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import 'full_map_view.dart';

class QiblahMapWidget extends StatelessWidget {
  const QiblahMapWidget({
    required this.isLoading,
    required this.localizations,
    required this.isArabic,
    this.userLocation,
    super.key,
  });

  final LatLng? userLocation;
  final bool isLoading;
  final AppLocalizations localizations;
  final bool isArabic;

  static const LatLng _kaabaLocation = LatLng(21.4225, 39.8262);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Skeletonizer(
      enabled: isLoading,
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
                    navigateWithTransition(
                      type: TransitionType.fade,
                      context,
                      FullMapView(
                        userLocation: userLocation!,
                        localizations: localizations,
                        isArabic: isArabic,
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
                          strokeWidth: 1.7,
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
                            size: 25,
                          ),
                        ),
                        Marker(
                          point: _kaabaLocation,
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/images/kaaba.png',
                            cacheHeight: 105,
                            cacheWidth: 105,
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
                child: DistanceText(
                  userLocation: userLocation!,
                  localizations: localizations,
                  isArabic: isArabic,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DistanceText extends StatelessWidget {
  const DistanceText({
    required this.userLocation,
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final AppLocalizations localizations;
  final LatLng userLocation;
  final bool isArabic;
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
      '${localizations.distanceToKabaa} ${isArabic ? convertToArabicNumbers(km.toStringAsFixed(2)) : km.toStringAsFixed(2)} ${isArabic ? 'كم' : 'Km'}',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
