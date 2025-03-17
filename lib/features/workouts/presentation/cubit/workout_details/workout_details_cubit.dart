import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/domain/repository/workouts_repository.dart';

part 'workout_details_state.dart';

class WorkoutDetailsCubit extends Cubit<WorkoutDetailsState> {
  final WorkoutsRepository _repository;
  WorkoutDetailsCubit(this._repository) : super(WorkoutDetailsInitial());

  Future<void> fetchWorkoutDetails(String workoutId) async {
    emit(WorkoutDetailsLoading());
    final result = await _repository.fetchWorkoutDetails(workoutId);
    result.fold(
      (failure) => emit(WorkoutDetailsError(message: failure.message)),
      (details) => emit(WorkoutDetailsLoaded(details: details)),
    );
  }
}
