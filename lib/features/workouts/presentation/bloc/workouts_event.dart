part of 'workouts_bloc.dart';

sealed class WorkoutsEvent {
  const WorkoutsEvent();

  const factory WorkoutsEvent.fetchWorkouts({String? type, String? level}) =
      _FetchWorkouts;
  const factory WorkoutsEvent.fetchWorkoutDetails({required String id}) =
      _FetchWorkoutDetails;
}

final class _FetchWorkouts extends WorkoutsEvent {
  final String? type;
  final String? level;

  const _FetchWorkouts({this.type, this.level});
}

final class _FetchWorkoutDetails extends WorkoutsEvent {
  final String id;

  const _FetchWorkoutDetails({required this.id});
}

sealed class WorkoutsEventState {
  WorkoutsEventState();
}

final class DefaultWorkoutsEventState extends WorkoutsEventState {}

final class ProcessingWorkoutsEventState extends WorkoutsEventState {}

final class ErrorWorkoutsEventState extends WorkoutsEventState {
  final String message;

  ErrorWorkoutsEventState({required this.message});
}
