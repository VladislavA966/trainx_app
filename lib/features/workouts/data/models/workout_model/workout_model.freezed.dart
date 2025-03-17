// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutModel {
  String? get title;
  String? get type;
  String? get level;
  String? get duration;
  String? get volume;
  String? get id;
  @JsonKey(name: 'warmup')
  String? get warmUp;
  @JsonKey(name: 'cooldown')
  String? get coolDown;
  @JsonKey(name: 'mainset')
  String? get mainSet;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutModelCopyWith<WorkoutModel> get copyWith =>
      _$WorkoutModelCopyWithImpl<WorkoutModel>(
          this as WorkoutModel, _$identity);

  /// Serializes this WorkoutModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warmUp, warmUp) || other.warmUp == warmUp) &&
            (identical(other.coolDown, coolDown) ||
                other.coolDown == coolDown) &&
            (identical(other.mainSet, mainSet) || other.mainSet == mainSet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, type, level, duration,
      volume, id, warmUp, coolDown, mainSet);

  @override
  String toString() {
    return 'WorkoutModel(title: $title, type: $type, level: $level, duration: $duration, volume: $volume, id: $id, warmUp: $warmUp, coolDown: $coolDown, mainSet: $mainSet)';
  }
}

/// @nodoc
abstract mixin class $WorkoutModelCopyWith<$Res> {
  factory $WorkoutModelCopyWith(
          WorkoutModel value, $Res Function(WorkoutModel) _then) =
      _$WorkoutModelCopyWithImpl;
  @useResult
  $Res call(
      {String? title,
      String? type,
      String? level,
      String? duration,
      String? volume,
      String? id,
      @JsonKey(name: 'warmup') String? warmUp,
      @JsonKey(name: 'cooldown') String? coolDown,
      @JsonKey(name: 'mainset') String? mainSet});
}

/// @nodoc
class _$WorkoutModelCopyWithImpl<$Res> implements $WorkoutModelCopyWith<$Res> {
  _$WorkoutModelCopyWithImpl(this._self, this._then);

  final WorkoutModel _self;
  final $Res Function(WorkoutModel) _then;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? type = freezed,
    Object? level = freezed,
    Object? duration = freezed,
    Object? volume = freezed,
    Object? id = freezed,
    Object? warmUp = freezed,
    Object? coolDown = freezed,
    Object? mainSet = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      warmUp: freezed == warmUp
          ? _self.warmUp
          : warmUp // ignore: cast_nullable_to_non_nullable
              as String?,
      coolDown: freezed == coolDown
          ? _self.coolDown
          : coolDown // ignore: cast_nullable_to_non_nullable
              as String?,
      mainSet: freezed == mainSet
          ? _self.mainSet
          : mainSet // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutModel implements WorkoutModel {
  _WorkoutModel(
      {this.title,
      this.type,
      this.level,
      this.duration,
      this.volume,
      this.id,
      @JsonKey(name: 'warmup') this.warmUp,
      @JsonKey(name: 'cooldown') this.coolDown,
      @JsonKey(name: 'mainset') this.mainSet});
  factory _WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);

  @override
  final String? title;
  @override
  final String? type;
  @override
  final String? level;
  @override
  final String? duration;
  @override
  final String? volume;
  @override
  final String? id;
  @override
  @JsonKey(name: 'warmup')
  final String? warmUp;
  @override
  @JsonKey(name: 'cooldown')
  final String? coolDown;
  @override
  @JsonKey(name: 'mainset')
  final String? mainSet;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutModelCopyWith<_WorkoutModel> get copyWith =>
      __$WorkoutModelCopyWithImpl<_WorkoutModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warmUp, warmUp) || other.warmUp == warmUp) &&
            (identical(other.coolDown, coolDown) ||
                other.coolDown == coolDown) &&
            (identical(other.mainSet, mainSet) || other.mainSet == mainSet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, type, level, duration,
      volume, id, warmUp, coolDown, mainSet);

  @override
  String toString() {
    return 'WorkoutModel(title: $title, type: $type, level: $level, duration: $duration, volume: $volume, id: $id, warmUp: $warmUp, coolDown: $coolDown, mainSet: $mainSet)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutModelCopyWith<$Res>
    implements $WorkoutModelCopyWith<$Res> {
  factory _$WorkoutModelCopyWith(
          _WorkoutModel value, $Res Function(_WorkoutModel) _then) =
      __$WorkoutModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? title,
      String? type,
      String? level,
      String? duration,
      String? volume,
      String? id,
      @JsonKey(name: 'warmup') String? warmUp,
      @JsonKey(name: 'cooldown') String? coolDown,
      @JsonKey(name: 'mainset') String? mainSet});
}

/// @nodoc
class __$WorkoutModelCopyWithImpl<$Res>
    implements _$WorkoutModelCopyWith<$Res> {
  __$WorkoutModelCopyWithImpl(this._self, this._then);

  final _WorkoutModel _self;
  final $Res Function(_WorkoutModel) _then;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? type = freezed,
    Object? level = freezed,
    Object? duration = freezed,
    Object? volume = freezed,
    Object? id = freezed,
    Object? warmUp = freezed,
    Object? coolDown = freezed,
    Object? mainSet = freezed,
  }) {
    return _then(_WorkoutModel(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      warmUp: freezed == warmUp
          ? _self.warmUp
          : warmUp // ignore: cast_nullable_to_non_nullable
              as String?,
      coolDown: freezed == coolDown
          ? _self.coolDown
          : coolDown // ignore: cast_nullable_to_non_nullable
              as String?,
      mainSet: freezed == mainSet
          ? _self.mainSet
          : mainSet // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
