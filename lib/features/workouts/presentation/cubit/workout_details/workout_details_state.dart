part of 'workout_details_cubit.dart';

sealed class WorkoutDetailsState extends Equatable {
  const WorkoutDetailsState();
}

final class WorkoutDetailsInitial extends WorkoutDetailsState {
  @override
  List<Object> get props => [];
}

final class WorkoutDetailsLoading extends WorkoutDetailsState {
  @override
  List<Object> get props => [];
}

final class WorkoutDetailsLoaded extends WorkoutDetailsState {
  final WorkoutEntity details;

  const WorkoutDetailsLoaded({required this.details});
  @override
  List<Object> get props => [details];
}

final class WorkoutDetailsError extends WorkoutDetailsState {
  final String message;

  const WorkoutDetailsError({required this.message});
  @override
  List<Object> get props => [message];
}
