// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_model.freezed.dart';
part 'workout_model.g.dart';

@freezed
abstract class WorkoutModel with _$WorkoutModel {
  factory WorkoutModel({
    String? title,
    String? type,
    String? level,
    String? duration,
    String? volume,
    String? id,
    @JsonKey(name: 'warmup') String? warmUp,
    @JsonKey(name: 'cooldown') String? coolDown,
    @JsonKey(name: 'mainset') String? mainSet,
  }) = _WorkoutModel;

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);
}
