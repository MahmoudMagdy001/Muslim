import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';

class FullMapView extends StatefulWidget {
  const FullMapView({
    required this.userLocation,
    required this.localizations,
    required this.isArabic,
    super.key,
  });

  final LatLng userLocation;
  final AppLocalizations localizations;
  final bool isArabic;
  static const LatLng _kaabaLocation = LatLng(21.4225, 39.8262);

  @override
  State<FullMapView> createState() => _FullMapViewState();
}

class _FullMapViewState extends State<FullMapView>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  late LatLng _currentLocation;
  double _currentZoom = 6;

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
    _currentLocation = widget.userLocation;
  }

  double getDistanceInKm() {
    const distance = latlng.Distance();
    final km = distance.as(
      LengthUnit.Kilometer,
      _currentLocation,
      FullMapView._kaabaLocation,
    );
    return km;
  }

  /// عرض المسار بالكامل بأنيميشن سلس
  void _fitBounds() {
    final bounds = LatLngBounds(_currentLocation, FullMapView._kaabaLocation);
    _animatedMapController.animatedFitCamera(
      cameraFit: CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(60),
      ),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  /// الانتقال إلى موقعي بأنيميشن سلس
  Future<void> _locateMe() async {
    await _animatedMapController.animateTo(
      dest: _currentLocation,
      zoom: 14.5,
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 2),
    );
    _currentZoom = 12;
  }

  /// تكبير الخريطة
  /// تكبير الخريطة
  void _zoomIn() {
    // نضمن ألا يتعدى الزوم أقصى قيمة
    _currentZoom = (_currentZoom + 1).clamp(0, 18);
    _animatedMapController.animateTo(
      zoom: _currentZoom,
      dest: _animatedMapController.mapController.camera.center,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  /// تصغير الخريطة
  void _zoomOut() {
    // نضمن ألا يقل الزوم عن 0
    _currentZoom = (_currentZoom - 1).clamp(0, 18);
    _animatedMapController.animateTo(
      zoom: _currentZoom,
      dest: _animatedMapController.mapController.camera.center,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final distanceKm = getDistanceInKm();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(widget.localizations.fullMapQiblah)),
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: _currentZoom,
                onMapEvent: (event) {
                  _currentZoom =
                      _animatedMapController.mapController.camera.zoom;
                },
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
                      points: [_currentLocation, FullMapView._kaabaLocation],
                      strokeWidth: 3,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation,
                      width: 45,
                      height: 45,
                      child: Icon(
                        Icons.my_location,
                        color: theme.colorScheme.primary,
                        size: 30,
                      ),
                    ),
                    Marker(
                      point: FullMapView._kaabaLocation,
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'assets/images/kaaba.png',
                        cacheHeight: 131,
                        cacheWidth: 131,
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // بطاقة المسافة أسفل الشاشة
            Positioned(
              bottom: 15,
              left: 10,
              right: 10,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${widget.localizations.distanceToKabaa} '
                          '${widget.isArabic ? convertToArabicNumbers(distanceKm.toStringAsFixed(2)) : distanceKm.toStringAsFixed(2)} '
                          '${widget.isArabic ? 'كم' : 'Km'}',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
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

            // أزرار التحكم بالزوم + موقعي
            Positioned(
              bottom: 100,
              right: 20,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: 'zoom_in',
                    onPressed: _zoomIn,
                    backgroundColor: theme.colorScheme.primary,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton.small(
                    heroTag: 'zoom_out',
                    onPressed: _zoomOut,
                    backgroundColor: theme.colorScheme.primary,
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: 'locate_me',
                    onPressed: _locateMe,
                    backgroundColor: theme.colorScheme.primary,
                    child: const Icon(Icons.my_location, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
