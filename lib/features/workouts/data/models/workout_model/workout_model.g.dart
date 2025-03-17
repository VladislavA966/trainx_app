// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutModel _$WorkoutModelFromJson(Map<String, dynamic> json) =>
    _WorkoutModel(
      title: json['title'] as String?,
      type: json['type'] as String?,
      level: json['level'] as String?,
      duration: json['duration'] as String?,
      volume: json['volume'] as String?,
      id: json['id'] as String?,
      warmUp: json['warmup'] as String?,
      coolDown: json['cooldown'] as String?,
      mainSet: json['mainset'] as String?,
    );

Map<String, dynamic> _$WorkoutModelToJson(_WorkoutModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'level': instance.level,
      'duration': instance.duration,
      'volume': instance.volume,
      'id': instance.id,
      'warmup': instance.warmUp,
      'cooldown': instance.coolDown,
      'mainset': instance.mainSet,
    };
