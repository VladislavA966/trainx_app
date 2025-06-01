import 'package:flutter/material.dart';

import 'package:trainx_app/core/recources/export.dart';
import 'package:trainx_app/features/ui_kit/export.dart';

class AppResultBox extends StatelessWidget {
  final String title;
  final String value;

  const AppResultBox({
    super.key,
    required this.title,
    required this.value,
  });

  factory AppResultBox.fromText(String fullText) {
    final parts = fullText.split(':');
    final title = parts.first.trim();
    final value = parts.length > 1 ? parts.sublist(1).join(':').trim() : '';
    return AppResultBox(title: title, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseCard(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.unit),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
          ),
        ],
      ),
    );
  }
}
