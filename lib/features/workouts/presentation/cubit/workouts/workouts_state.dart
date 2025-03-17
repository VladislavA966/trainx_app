part of 'workouts_cubit.dart';

sealed class WorkoutsState extends Equatable {
  const WorkoutsState();
}

final class WorkoutsInitial extends WorkoutsState {
  @override
  List<Object> get props => [];
}

final class WorkoutsLoading extends WorkoutsState {
  @override
  List<Object?> get props => [];
}

final class WorkoutsLoaded extends WorkoutsState {
  final List<WorkoutEntity> workouts;

  const WorkoutsLoaded({required this.workouts});
  @override
  List<Object?> get props => [workouts];
}

final class WorkoutsError extends WorkoutsState {
  final String message;

  const WorkoutsError({required this.message});
  @override
  List<Object?> get props => [message];
}
