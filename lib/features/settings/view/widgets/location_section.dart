import 'package:flutter/material.dart';
import '../../service/settings_service.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({
    required this.isArabic,
    required this.theme,
    super.key,
  });

  final bool isArabic;
  final ThemeData theme;

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  final SettingsService _settingsService = SettingsService();
  final ValueNotifier<bool> autoLocationNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    autoLocationNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final enabled = await _settingsService.getAutoLocationEnabled();
    autoLocationNotifier.value = enabled;
  }

  Future<void> _toggleAutoLocation(bool value) async {
    await _settingsService.setAutoLocationEnabled(value);
    autoLocationNotifier.value = value;

    _showSnackBar(
      value
          ? (widget.isArabic
                ? 'تم تفعيل التحديث التلقائي للموقع'
                : 'Auto location updates enabled')
          : (widget.isArabic
                ? 'تم تعطيل التحديث التلقائي للموقع'
                : 'Auto location updates disabled'),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
    valueListenable: autoLocationNotifier,
    builder: (context, autoLocation, child) => ListTile(
      leading: const Icon(Icons.location_on_rounded),
      title: Text(
        widget.isArabic ? 'تحديث الموقع تلقائياً' : 'Auto Location Updates',
        style: widget.theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        widget.isArabic
            ? 'تحديث مواقيت الصلاة بناءً على موقعك الحالي'
            : 'Update prayer times based on your current location',
        style: widget.theme.textTheme.bodySmall,
      ),
      trailing: Switch(value: autoLocation, onChanged: _toggleAutoLocation),
    ),
  );
}
