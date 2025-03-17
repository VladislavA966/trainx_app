import 'package:dartz/dartz.dart';
import 'package:trainx_app/core/utils/errors_handler.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';

abstract interface class WorkoutsRepository {
  Future<Either<Failure, List<WorkoutEntity>>> getWorkouts({
    String? type,
    String? level,
  });
  Future<Either<Failure, WorkoutEntity>> fetchWorkoutDetails(String workoutId);
}
