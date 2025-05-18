import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';

class AppBaseCard extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? wight;
  const AppBaseCard({
    super.key,
    this.child,
    this.wight,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: wight ?? double.infinity,
      padding: const EdgeInsets.all(Dimensions.unit2),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor,
        borderRadius: BorderRadius.circular(Dimensions.unit2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Dimensions.unit,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}