import 'package:flutter/material.dart';

class DashboardItemModel {
  const DashboardItemModel({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Widget route;
}
