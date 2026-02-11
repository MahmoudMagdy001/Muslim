import 'package:flutter/material.dart';

import '../models/prayer_type.dart';

/// Visual metadata (icon, color) for each [PrayerType].
class PrayerVisualData {
  const PrayerVisualData({
    required this.type,
    required this.icon,
    required this.color,
    required this.assetPath,
  });

  final PrayerType type;
  final IconData icon;
  final Color color;
  final String assetPath;
}

/// Map of [PrayerType] to its visual data (icon, color, asset).
const Map<PrayerType, PrayerVisualData> prayerVisuals = {
  PrayerType.fajr: PrayerVisualData(
    type: PrayerType.fajr,
    icon: Icons.wb_sunny,
    color: Colors.yellow,
    assetPath: 'assets/home/fagr.png',
  ),
  PrayerType.dhuhr: PrayerVisualData(
    type: PrayerType.dhuhr,
    icon: Icons.brightness_high,
    color: Colors.orange,
    assetPath: 'assets/home/dohr.png',
  ),
  PrayerType.asr: PrayerVisualData(
    type: PrayerType.asr,
    icon: Icons.cloud,
    color: Colors.blueGrey,
    assetPath: 'assets/home/asr.png',
  ),
  PrayerType.maghrib: PrayerVisualData(
    type: PrayerType.maghrib,
    icon: Icons.nightlight_round,
    color: Colors.deepOrange,
    assetPath: 'assets/home/maghreb.png',
  ),
  PrayerType.isha: PrayerVisualData(
    type: PrayerType.isha,
    icon: Icons.bedtime,
    color: Colors.indigo,
    assetPath: 'assets/home/asiha.png',
  ),
};

// ── Backward-compatible getters ────────────────────────────────────────

/// Ordered list of prayer type IDs.
List<String> get prayerOrder => PrayerType.values.map((p) => p.id).toList();

/// Map of prayer ID → Arabic name.
Map<String, String> get prayerNamesAr =>
    Map.fromEntries(PrayerType.values.map((p) => MapEntry(p.id, p.arabicName)));

/// Map of prayer ID → icon.
Map<String, IconData> get prayerIcons => Map.fromEntries(
  prayerVisuals.entries.map((e) => MapEntry(e.key.id, e.value.icon)),
);

/// Map of prayer ID → color.
Map<String, Color> get prayerColors => Map.fromEntries(
  prayerVisuals.entries.map((e) => MapEntry(e.key.id, e.value.color)),
);
