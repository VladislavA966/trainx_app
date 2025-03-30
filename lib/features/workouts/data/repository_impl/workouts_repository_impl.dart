import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trainx_app/core/utils/errors_handler.dart';
import 'package:trainx_app/features/workouts/data/data_source/workouts_data_source.dart';
import 'package:trainx_app/features/workouts/data/mapper/workout_mapper.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/domain/repository/workouts_repository.dart';

@Singleton(as: WorkoutsRepository)
class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsDataSource _workoutsDataSource;

  WorkoutsRepositoryImpl({required WorkoutsDataSource workoutsDataSource})
      : _workoutsDataSource = workoutsDataSource;

  @override
  Future<Either<Failure, List<WorkoutEntity>>> getWorkouts(
      {String? level, String? type}) async {
    final result = await Connectivity().checkConnectivity();
    if (result == [ConnectivityResult.none]) {
      return Left(NetworkFailure());
    }
    try {
      final workouts =
          await _workoutsDataSource.fetchWorkouts(level: level, type: type);
      return Right(workouts.map((workout) => workout.toEntity()).toList());
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutEntity>> fetchWorkoutDetails(
      String workoutId) async {
    final result = await Connectivity().checkConnectivity();
    if (result == [ConnectivityResult.none]) {
      return Left(NetworkFailure());
    }
    try {
      final workout = await _workoutsDataSource.fetchWorkoutDetails(workoutId);

      if (workout != null) {
        return Right(workout.toEntity());
      } else {
        return Left(FirestoreFailure("Workout with id $workoutId not found"));
      }
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }
}
