import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/domain/repository/workouts_repository.dart';

part 'workouts_state.dart';

class WorkoutsCubit extends Cubit<WorkoutsState> {
  final WorkoutsRepository _repository;
  WorkoutsCubit(this._repository) : super(WorkoutsInitial());

  Future<void> fetchWorkouts({String? type, String? level}) async {
    emit(WorkoutsLoading());
    final result = await _repository.getWorkouts(level: level, type: type);
    result.fold(
      (failure) => emit(WorkoutsError(message: failure.message)),
      (workouts) => emit(WorkoutsLoaded(workouts: workouts)),
    );
  }
}
