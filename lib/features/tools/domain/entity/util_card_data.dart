import 'package:flutter/material.dart';

class ToolsCardData {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  const ToolsCardData({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}