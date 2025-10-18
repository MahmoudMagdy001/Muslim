import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../../core/utils/format_helper.dart';

class FullMapView extends StatefulWidget {
  const FullMapView({required this.userLocation, super.key});

  final LatLng userLocation;
  static const LatLng _kaabaLocation = LatLng(21.4225, 39.8262);

  @override
  State<FullMapView> createState() => _FullMapViewState();
}

class _FullMapViewState extends State<FullMapView> {
  final MapController _mapController = MapController();

  double getDistanceInKm() {
    const distance = latlng.Distance();
    final km = distance.as(
      LengthUnit.Kilometer,
      widget.userLocation,
      FullMapView._kaabaLocation,
    );
    return km;
  }

  void _fitBounds() {
    final bounds = LatLngBounds(
      widget.userLocation,
      FullMapView._kaabaLocation,
    );
    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(60)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final distanceKm = getDistanceInKm();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('خريطة القبلة')),
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.userLocation,
                initialZoom: 6,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.muslim',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [widget.userLocation, FullMapView._kaabaLocation],
                      strokeWidth: 4,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: widget.userLocation,
                      width: 45,
                      height: 45,
                      child: Icon(
                        Icons.my_location,
                        color: theme.colorScheme.primary,
                        size: 40,
                      ),
                    ),
                    const Marker(
                      point: FullMapView._kaabaLocation,
                      width: 50,
                      height: 50,
                      child: Image(
                        image: AssetImage('assets/images/kaaba.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // بطاقة المسافة أسفل الشاشة
            Positioned(
              bottom: 15,
              left: 20,
              right: 20,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.place, color: Colors.green),
                      Text(
                        'المسافة إلى الكعبة: ${convertToArabicNumbers(distanceKm.toStringAsFixed(2))} كم',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        tooltip: 'عرض المسار بالكامل',
                        icon: const Icon(Icons.center_focus_strong),
                        onPressed: _fitBounds,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
