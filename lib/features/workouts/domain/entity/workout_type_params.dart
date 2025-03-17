import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_images.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/generated/l10n.dart';

class WorkoutTypeParams {
  final String Function(BuildContext context) title;
  final String image;

  const WorkoutTypeParams({required this.title, required this.image});
}

WorkoutTypeParams paramsFromWorkoutType(WorkoutType? type) {
  switch (type) {
    case WorkoutType.swimming:
      return WorkoutTypeParams(
        title: (context) => S.of(context).swimming,
        image: AppImages.swimming,
      );
    case WorkoutType.cycling:
      return WorkoutTypeParams(
        title: (context) => S.of(context).cycling,
        image: AppImages.cycling,
      );
    case WorkoutType.running:
      return WorkoutTypeParams(
        title: (context) => S.of(context).running,
        image: AppImages.running,
      );
    default:
      return WorkoutTypeParams(
        title: (context) => S.of(context).allWorkouts,
        image: AppImages.swimming,
      );
  }
}
