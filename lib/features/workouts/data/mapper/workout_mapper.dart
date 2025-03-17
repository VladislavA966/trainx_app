import 'package:trainx_app/features/workouts/data/models/workout_model/workout_model.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';

extension WorkoutMapper on WorkoutModel {
  WorkoutEntity toEntity() {
    return WorkoutEntity(
      title: title ?? '',
      type: type ?? '',
      level: level ?? '',
      duration: duration ?? '',
      volume: volume ?? '',
      id: id ?? '',
      warmUp: warmUp,
      mainSet: mainSet,
      coolDown: coolDown,
    );
  }
}
