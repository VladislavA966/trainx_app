import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/features/ui_kit/export.dart';

class UtilsCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const UtilsCardWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.unit2),
        child: AppBaseCard(
          child: ListTile(
            leading: Icon(
              icon,
              color: theme.iconTheme.color,
            ),
            title: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: theme.iconTheme.color,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
