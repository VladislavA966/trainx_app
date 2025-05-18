import 'package:trainx_app/app.dart';
import 'package:trainx_app/core/recources/app_images.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';

class WorkoutTypeParams {
  final String title;
  final String image;

  const WorkoutTypeParams({required this.title, required this.image});
}

WorkoutTypeParams paramsFromWorkoutType(WorkoutType? type) {
  switch (type) {
    case WorkoutType.swimming:
      return WorkoutTypeParams(
        title: l10n.swimming,
        image: AppImages.swimming,
      );
    case WorkoutType.cycling:
      return WorkoutTypeParams(
        title: l10n.cycling,
        image: AppImages.cycling,
      );
    case WorkoutType.running:
      return WorkoutTypeParams(
        title: l10n.running,
        image: AppImages.running,
      );
    default:
      return WorkoutTypeParams(
        title: l10n.allWorkouts,
        image: AppImages.swimming,
      );
  }
}
