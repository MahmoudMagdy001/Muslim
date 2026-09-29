import 'package:geolocator/geolocator.dart';

class LocationService {
  Stream<ServiceStatus> get serviceStatusStream =>
      Geolocator.getServiceStatusStream();

  Future<bool> isLocationEnabled() async =>
      Geolocator.isLocationServiceEnabled();

  Future<LocationStatus> checkLocationStatus() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return LocationStatus(enabled: enabled, permission: permission);
  }

  /// Get current position if location service and permissions are active
  Future<Position?> getCurrentLocate() async {
    final status = await checkLocationStatus();

    if (!status.enabled || !status.isGranted) {
      return null;
    }

    return Geolocator.getCurrentPosition();
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
