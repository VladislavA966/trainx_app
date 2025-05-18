import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/features/widgets/app_base_card.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';

class WorkoutInfoCardWidget extends StatelessWidget {
  const WorkoutInfoCardWidget({
    super.key,
    required this.workout,
  });

  final WorkoutEntity workout;

  @override
  Widget build(BuildContext context) {
    return AppBaseCard(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.unit2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: Dimensions.unit,
                children: [
                  _IconAndTitleRow(
                    title: workout.duration,
                    icon: Icons.timer,
                  ),
                  _IconAndTitleRow(
                    title: workout.volume,
                    icon: Icons.route,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: Dimensions.unit,
                children: [
                  _IconAndTitleRow(
                    title: workout.level,
                    icon: Icons.sports,
                  ),
                  _IconAndTitleRow(
                    title: workout.type,
                    icon: Icons.sports_gymnastics,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class _IconAndTitleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  const _IconAndTitleRow({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: Dimensions.unit),
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.canvasColor),
        ),
      ],
    );
  }
}
