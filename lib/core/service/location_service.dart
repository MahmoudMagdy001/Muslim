import 'package:geolocator/geolocator.dart';

class LocationService {
  Stream<ServiceStatus> get serviceStatusStream =>
      Geolocator.getServiceStatusStream();

  Future<bool> isLocationEnabled() async =>
      Geolocator.isLocationServiceEnabled();

  Future<Position?> getLastKnownPosition() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) return null;
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return await Geolocator.getLastKnownPosition();
    } on Object catch (_) {
      return null;
    }
  }

  Future<LocationStatus> checkLocationStatus() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return LocationStatus(enabled: enabled, permission: permission);
  }

  /// Get current position if location service and permissions are active.
  /// Prioritizes [getLastKnownPosition] for instant response (0ms) and
  /// falls back to [Geolocator.getCurrentPosition] with medium accuracy.
  Future<Position?> getCurrentLocate() async {
    final status = await checkLocationStatus();

    if (!status.enabled || !status.isGranted) {
      return null;
    }

    try {
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        return lastKnown;
      }
    } on Object catch (_) {}

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 6),
        ),
      );
    } on Object catch (_) {
      return null;
    }
  }
}

class LocationStatus {
  const LocationStatus({required this.enabled, required this.permission});
  final bool enabled;
  final LocationPermission permission;

  bool get isGranted =>
      enabled &&
      (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse);
}
