import 'package:flutter/material.dart';

class Prayer {
  const Prayer({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.icon,
    required this.color,
  });
  final String id;
  final String name;
  final String arabicName;
  final IconData icon;
  final Color color;
}

const List<Prayer> prayers = [
  Prayer(
    id: 'Fajr',
    name: 'Fajr',
    arabicName: 'الفجر',
    icon: Icons.wb_sunny,
    color: Colors.yellow,
  ),
  Prayer(
    id: 'Dhuhr',
    name: 'Dhuhr',
    arabicName: 'الظهر',
    icon: Icons.brightness_high,
    color: Colors.orange,
  ),
  Prayer(
    id: 'Asr',
    name: 'Asr',
    arabicName: 'العصر',
    icon: Icons.cloud,
    color: Colors.blueGrey,
  ),
  Prayer(
    id: 'Maghrib',
    name: 'Maghrib',
    arabicName: 'المغرب',
    icon: Icons.nightlight_round,
    color: Colors.deepOrange,
  ),
  Prayer(
    id: 'Isha',
    name: 'Isha',
    arabicName: 'العشاء',
    icon: Icons.bedtime,
    color: Colors.indigo,
  ),
];

// Helper getters for backward compatibility
List<String> get prayerOrder => prayers.map((p) => p.id).toList();

Map<String, String> get prayerNamesAr =>
    Map.fromEntries(prayers.map((p) => MapEntry(p.id, p.arabicName)));

Map<String, IconData> get prayerIcons =>
    Map.fromEntries(prayers.map((p) => MapEntry(p.id, p.icon)));

Map<String, Color> get prayerColors =>
    Map.fromEntries(prayers.map((p) => MapEntry(p.id, p.color)));

// Extension for easy access
extension PrayerListExtensions on List<Prayer> {
  Prayer get fajr => firstWhere((p) => p.id == 'Fajr');
  Prayer get dhuhr => firstWhere((p) => p.id == 'Dhuhr');
  Prayer get asr => firstWhere((p) => p.id == 'Asr');
  Prayer get maghrib => firstWhere((p) => p.id == 'Maghrib');
  Prayer get isha => firstWhere((p) => p.id == 'Isha');

  Prayer byId(String id) => firstWhere((p) => p.id == id);
}
