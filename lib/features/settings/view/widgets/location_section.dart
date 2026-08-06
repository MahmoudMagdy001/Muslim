import 'dart:async';
import 'package:flutter/material.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/settings/service/settings_service.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({
    required this.theme,
    super.key,
  });

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
    unawaited(_loadSettings());
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
    await _settingsService.setAutoLocationEnabled(enabled: value);
    autoLocationNotifier.value = value;
    logInfo('📍 التحديث التلقائي للموقع: ${value ? "مفعّل" : "معطّل"}');

    if (mounted) {
      final l10n = context.l10n;
      _showSnackBar(value ? l10n.autoLocationEnabled : l10n.autoLocationDisabled);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ValueListenableBuilder<bool>(
      valueListenable: autoLocationNotifier,
      builder: (context, autoLocation, child) => ListTile(
        leading: const Icon(Icons.location_on_rounded),
        title: Text(
          l10n.autoLocationUpdates,
          style: widget.theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          l10n.autoLocationSubtitle,
          style: widget.theme.textTheme.bodySmall,
        ),
        trailing: Switch(value: autoLocation, onChanged: _toggleAutoLocation),
      ),
    );
  }
}
