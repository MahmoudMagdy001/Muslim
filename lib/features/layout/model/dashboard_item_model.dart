import 'package:flutter/material.dart';

class DashboardItemModel {
  const DashboardItemModel({
    required this.image,
    required this.label,
    required this.color,
    required this.route,
  });

  final String image;
  final String label;
  final Color color;
  final Widget route;
}
