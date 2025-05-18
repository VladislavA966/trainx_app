// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workouts_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutsStateModel {
  List<WorkoutEntity> get workouts;
  WorkoutEntity? get workoutDetails;

  /// Create a copy of WorkoutsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutsStateModelCopyWith<WorkoutsStateModel> get copyWith =>
      _$WorkoutsStateModelCopyWithImpl<WorkoutsStateModel>(
          this as WorkoutsStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutsStateModel &&
            const DeepCollectionEquality().equals(other.workouts, workouts) &&
            (identical(other.workoutDetails, workoutDetails) ||
                other.workoutDetails == workoutDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(workouts), workoutDetails);

  @override
  String toString() {
    return 'WorkoutsStateModel(workouts: $workouts, workoutDetails: $workoutDetails)';
  }
}

/// @nodoc
abstract mixin class $WorkoutsStateModelCopyWith<$Res> {
  factory $WorkoutsStateModelCopyWith(
          WorkoutsStateModel value, $Res Function(WorkoutsStateModel) _then) =
      _$WorkoutsStateModelCopyWithImpl;
  @useResult
  $Res call({List<WorkoutEntity> workouts, WorkoutEntity? workoutDetails});
}

/// @nodoc
class _$WorkoutsStateModelCopyWithImpl<$Res>
    implements $WorkoutsStateModelCopyWith<$Res> {
  _$WorkoutsStateModelCopyWithImpl(this._self, this._then);

  final WorkoutsStateModel _self;
  final $Res Function(WorkoutsStateModel) _then;

  /// Create a copy of WorkoutsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workouts = null,
    Object? workoutDetails = freezed,
  }) {
    return _then(_self.copyWith(
      workouts: null == workouts
          ? _self.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutEntity>,
      workoutDetails: freezed == workoutDetails
          ? _self.workoutDetails
          : workoutDetails // ignore: cast_nullable_to_non_nullable
              as WorkoutEntity?,
    ));
  }
}

/// @nodoc

class _WorkoutsStateModel implements WorkoutsStateModel {
  const _WorkoutsStateModel(
      {final List<WorkoutEntity> workouts = const [], this.workoutDetails})
      : _workouts = workouts;

  final List<WorkoutEntity> _workouts;
  @override
  @JsonKey()
  List<WorkoutEntity> get workouts {
    if (_workouts is EqualUnmodifiableListView) return _workouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workouts);
  }

  @override
  final WorkoutEntity? workoutDetails;

  /// Create a copy of WorkoutsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutsStateModelCopyWith<_WorkoutsStateModel> get copyWith =>
      __$WorkoutsStateModelCopyWithImpl<_WorkoutsStateModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutsStateModel &&
            const DeepCollectionEquality().equals(other._workouts, _workouts) &&
            (identical(other.workoutDetails, workoutDetails) ||
                other.workoutDetails == workoutDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_workouts), workoutDetails);

  @override
  String toString() {
    return 'WorkoutsStateModel(workouts: $workouts, workoutDetails: $workoutDetails)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutsStateModelCopyWith<$Res>
    implements $WorkoutsStateModelCopyWith<$Res> {
  factory _$WorkoutsStateModelCopyWith(
          _WorkoutsStateModel value, $Res Function(_WorkoutsStateModel) _then) =
      __$WorkoutsStateModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<WorkoutEntity> workouts, WorkoutEntity? workoutDetails});
}

/// @nodoc
class __$WorkoutsStateModelCopyWithImpl<$Res>
    implements _$WorkoutsStateModelCopyWith<$Res> {
  __$WorkoutsStateModelCopyWithImpl(this._self, this._then);

  final _WorkoutsStateModel _self;
  final $Res Function(_WorkoutsStateModel) _then;

  /// Create a copy of WorkoutsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workouts = null,
    Object? workoutDetails = freezed,
  }) {
    return _then(_WorkoutsStateModel(
      workouts: null == workouts
          ? _self._workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutEntity>,
      workoutDetails: freezed == workoutDetails
          ? _self.workoutDetails
          : workoutDetails // ignore: cast_nullable_to_non_nullable
              as WorkoutEntity?,
    ));
  }
}

// dart format on
