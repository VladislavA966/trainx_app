import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/domain/repository/workouts_repository.dart';

part 'workouts_bloc.freezed.dart';
part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final WorkoutsRepository workoutsRepository;

  WorkoutsBloc(this.workoutsRepository) : super(WorkoutsState.init()) {
    on<WorkoutsEvent>(
      (event, emit) => switch (event) {
        final _FetchWorkouts e => fetchWorkouts(e, emit),
        final _FetchWorkoutDetails e => fetchWorkoutDetails(e, emit),
      },
    );
  }

  Future<void> fetchWorkouts(event, Emitter<WorkoutsState> emit) async {
    emit(state.setEventState(ProcessingWorkoutsEventState()));
    try {
      final result = await workoutsRepository.getWorkouts(
        level: event.level,
        type: event.type,
      );
      result.fold(
        (failure) => emit(
          state
              .setEventState(ErrorWorkoutsEventState(message: failure.message)),
        ),
        (workouts) => emit(
          WorkoutsState(
            dataState: state.dataState.copyWith(workouts: workouts),
            eventState: DefaultWorkoutsEventState(),
          ),
        ),
      );
    } catch (e) {
      emit(state.setEventState(ErrorWorkoutsEventState(message: e.toString())));
    }
  }

  Future<void> fetchWorkoutDetails(event, Emitter<WorkoutsState> emit) async {
    emit(state.setEventState(ProcessingWorkoutsEventState()));
    try {
      final result = await workoutsRepository.fetchWorkoutDetails(event.id);
      result.fold(
        (failure) => emit(
          state
              .setEventState(ErrorWorkoutsEventState(message: failure.message)),
        ),
        (workout) => emit(
          WorkoutsState(
            dataState: state.dataState.copyWith(workoutDetails: workout),
            eventState: DefaultWorkoutsEventState(),
          ),
        ),
      );
    } catch (e) {
      emit(state.setEventState(ErrorWorkoutsEventState(message: e.toString())));
    }
  }
}
