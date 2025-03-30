import 'package:flutter/material.dart';

class UtilsCardData {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  const UtilsCardData({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}