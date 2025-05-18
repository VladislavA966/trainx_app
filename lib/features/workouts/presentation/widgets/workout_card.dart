import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/features/widgets/app_base_card.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String duration;
  final String volume;
  final String level;
  final String workoutType;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.duration,
    required this.volume,
    required this.level,
    required this.workoutType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AppBaseCard(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: theme.cardColor),
                ),
                const SizedBox(height: Dimensions.unit0_5),
                Text(
                  workoutType,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: Dimensions.unit),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: Dimensions.unit2,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: Dimensions.unit0_5),
                    Text(
                      duration,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.cardColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.unit1_5),
                    Icon(
                      Icons.route,
                      size: Dimensions.unit2,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: Dimensions.unit0_5),
                    Text(
                      volume,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.cardColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.unit, vertical: Dimensions.unit0_5),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.unit0_5),
              ),
              child: Text(
                level,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
