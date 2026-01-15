import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/location_disclosure_dialog.dart';

class LocationService {
  Stream<ServiceStatus> get serviceStatusStream =>
      Geolocator.getServiceStatusStream();

  Future<bool> isLocationEnabled() async =>
      await Geolocator.isLocationServiceEnabled();

  Future<LocationStatus> checkLocationStatus([BuildContext? context]) async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied && context != null) {
      final shouldShow = await LocationDisclosureDialog.shouldShow();
      if (shouldShow) {
        if (!context.mounted) {
          return LocationStatus(enabled: enabled, permission: permission);
        }
        final accepted = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => LocationDisclosureDialog(
            isArabic: Localizations.localeOf(context).languageCode == 'ar',
          ),
        );

        if (accepted == true) {
          await LocationDisclosureDialog.markAsShown();
          permission = await Geolocator.requestPermission();
        }
      } else {
        permission = await Geolocator.requestPermission();
      }
    } else if (permission == LocationPermission.denied) {
      // If no context provided and denied, we can't show disclosure but we can still request if already shown before
      // or just return denied. To be safe for Play Store, we don't request here if disclosure is needed.
      // permission = await Geolocator.requestPermission();
    }

    return LocationStatus(enabled: enabled, permission: permission);
  }

  /// ✅ احصل على الموقع الحالي مع التحقق من الصلاحيات
  Future<Position?> getCurrentLocate([BuildContext? context]) async {
    final status = await checkLocationStatus(context);

    if (!status.enabled) {
      return null;
    }

    if (!status.isGranted) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
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
