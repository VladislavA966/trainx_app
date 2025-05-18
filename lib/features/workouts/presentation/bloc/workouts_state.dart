part of 'workouts_bloc.dart';

final class WorkoutsState {
  final WorkoutsEventState eventState;
  final WorkoutsStateModel dataState;

  WorkoutsState({required this.eventState, required this.dataState});

  factory WorkoutsState.init() => WorkoutsState(
        dataState: WorkoutsStateModel.empty(),
        eventState: DefaultWorkoutsEventState(),
      );

  WorkoutsState setData(WorkoutsStateModel stateData) {
    return WorkoutsState(
      dataState: stateData,
      eventState: eventState,
    );
  }

  bool get isLoading => eventState is ProcessingWorkoutsEventState;

  WorkoutsState setEventState(WorkoutsEventState eventState) {
    return WorkoutsState(
      dataState: dataState,
      eventState: eventState,
    );
  }
}

@freezed
abstract class WorkoutsStateModel with _$WorkoutsStateModel {
  const factory WorkoutsStateModel({
    @Default([]) List<WorkoutEntity> workouts,
    WorkoutEntity? workoutDetails,
  }) = _WorkoutsStateModel;

  factory WorkoutsStateModel.empty() => const WorkoutsStateModel();
}
