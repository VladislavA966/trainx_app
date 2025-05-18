// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:trainx_app/features/auth/presentation/screens/log_in_screen.dart'
    as _i8;
import 'package:trainx_app/features/auth/presentation/screens/sign_in_screen.dart'
    as _i12;
import 'package:trainx_app/features/exercises/all_exercises_screen.dart' as _i1;
import 'package:trainx_app/features/exercises/exercise_details_screen.dart'
    as _i5;
import 'package:trainx_app/features/exercises/exercises_page.dart' as _i6;
import 'package:trainx_app/features/home/home_page.dart' as _i7;
import 'package:trainx_app/features/profile/profile_screen.dart' as _i11;
import 'package:trainx_app/features/utils/distance_peace_calculator_screen.dart'
    as _i4;
import 'package:trainx_app/features/utils/metronome_screen.dart' as _i9;
import 'package:trainx_app/features/utils/peace_to_speed_calcilator_screen.dart'
    as _i10;
import 'package:trainx_app/features/utils/utils_screen.dart' as _i2;
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart'
    as _i19;
import 'package:trainx_app/features/workouts/presentation/screens/all_workouts_screen.dart'
    as _i3;
import 'package:trainx_app/features/workouts/presentation/screens/workout_details_screen.dart'
    as _i13;
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart'
    as _i14;
import 'package:trainx_app/features/workouts/presentation/screens/workouts_filter_screen.dart'
    as _i15;
import 'package:trainx_app/features/workouts/presentation/screens/workouts_page.dart'
    as _i16;

/// generated route for
/// [_i1.AllExercisesScreen]
class AllExercisesRoute extends _i17.PageRouteInfo<void> {
  const AllExercisesRoute({List<_i17.PageRouteInfo>? children})
    : super(AllExercisesRoute.name, initialChildren: children);

  static const String name = 'AllExercisesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.AllExercisesScreen();
    },
  );
}

/// generated route for
/// [_i2.AllUtilsScreen]
class AllUtilsRoute extends _i17.PageRouteInfo<void> {
  const AllUtilsRoute({List<_i17.PageRouteInfo>? children})
    : super(AllUtilsRoute.name, initialChildren: children);

  static const String name = 'AllUtilsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.AllUtilsScreen();
    },
  );
}

/// generated route for
/// [_i3.AllWorkoutsScreen]
class AllWorkoutsRoute extends _i17.PageRouteInfo<AllWorkoutsRouteArgs> {
  AllWorkoutsRoute({
    _i18.Key? key,
    _i19.WorkoutType? type,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         AllWorkoutsRoute.name,
         args: AllWorkoutsRouteArgs(key: key, type: type),
         initialChildren: children,
       );

  static const String name = 'AllWorkoutsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllWorkoutsRouteArgs>(
        orElse: () => const AllWorkoutsRouteArgs(),
      );
      return _i3.AllWorkoutsScreen(key: args.key, type: args.type);
    },
  );
}

class AllWorkoutsRouteArgs {
  const AllWorkoutsRouteArgs({this.key, this.type});

  final _i18.Key? key;

  final _i19.WorkoutType? type;

  @override
  String toString() {
    return 'AllWorkoutsRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i4.DistancePaceCalculatorScreen]
class DistancePaceCalculatorRoute
    extends _i17.PageRouteInfo<DistancePaceCalculatorRouteArgs> {
  DistancePaceCalculatorRoute({
    _i18.Key? key,
    required _i19.WorkoutType sportType,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         DistancePaceCalculatorRoute.name,
         args: DistancePaceCalculatorRouteArgs(key: key, sportType: sportType),
         initialChildren: children,
       );

  static const String name = 'DistancePaceCalculatorRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DistancePaceCalculatorRouteArgs>();
      return _i4.DistancePaceCalculatorScreen(
        key: args.key,
        sportType: args.sportType,
      );
    },
  );
}

class DistancePaceCalculatorRouteArgs {
  const DistancePaceCalculatorRouteArgs({this.key, required this.sportType});

  final _i18.Key? key;

  final _i19.WorkoutType sportType;

  @override
  String toString() {
    return 'DistancePaceCalculatorRouteArgs{key: $key, sportType: $sportType}';
  }
}

/// generated route for
/// [_i5.ExerciseDetailsScreen]
class ExerciseDetailsRoute extends _i17.PageRouteInfo<void> {
  const ExerciseDetailsRoute({List<_i17.PageRouteInfo>? children})
    : super(ExerciseDetailsRoute.name, initialChildren: children);

  static const String name = 'ExerciseDetailsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.ExerciseDetailsScreen();
    },
  );
}

/// generated route for
/// [_i6.ExercisesPage]
class ExercisesRoute extends _i17.PageRouteInfo<void> {
  const ExercisesRoute({List<_i17.PageRouteInfo>? children})
    : super(ExercisesRoute.name, initialChildren: children);

  static const String name = 'ExercisesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.ExercisesPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.LogInScreen]
class LogInRoute extends _i17.PageRouteInfo<void> {
  const LogInRoute({List<_i17.PageRouteInfo>? children})
    : super(LogInRoute.name, initialChildren: children);

  static const String name = 'LogInRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.LogInScreen();
    },
  );
}

/// generated route for
/// [_i9.MetronomeScreen]
class MetronomeRoute extends _i17.PageRouteInfo<void> {
  const MetronomeRoute({List<_i17.PageRouteInfo>? children})
    : super(MetronomeRoute.name, initialChildren: children);

  static const String name = 'MetronomeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.MetronomeScreen();
    },
  );
}

/// generated route for
/// [_i10.PaceSpeedScreen]
class PaceSpeedRoute extends _i17.PageRouteInfo<void> {
  const PaceSpeedRoute({List<_i17.PageRouteInfo>? children})
    : super(PaceSpeedRoute.name, initialChildren: children);

  static const String name = 'PaceSpeedRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.PaceSpeedScreen();
    },
  );
}

/// generated route for
/// [_i11.ProfileScreen]
class ProfileRoute extends _i17.PageRouteInfo<void> {
  const ProfileRoute({List<_i17.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i12.SignInScreen]
class SignInRoute extends _i17.PageRouteInfo<void> {
  const SignInRoute({List<_i17.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignInScreen();
    },
  );
}

/// generated route for
/// [_i2.UtilsScreen]
class UtilsRoute extends _i17.PageRouteInfo<void> {
  const UtilsRoute({List<_i17.PageRouteInfo>? children})
    : super(UtilsRoute.name, initialChildren: children);

  static const String name = 'UtilsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.UtilsScreen();
    },
  );
}

/// generated route for
/// [_i13.WorkoutDetailsScreen]
class WorkoutDetailsRoute extends _i17.PageRouteInfo<WorkoutDetailsRouteArgs> {
  WorkoutDetailsRoute({
    required String workoutId,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         WorkoutDetailsRoute.name,
         args: WorkoutDetailsRouteArgs(workoutId: workoutId, key: key),
         initialChildren: children,
       );

  static const String name = 'WorkoutDetailsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutDetailsRouteArgs>();
      return _i13.WorkoutDetailsScreen(
        workoutId: args.workoutId,
        key: args.key,
      );
    },
  );
}

class WorkoutDetailsRouteArgs {
  const WorkoutDetailsRouteArgs({required this.workoutId, this.key});

  final String workoutId;

  final _i18.Key? key;

  @override
  String toString() {
    return 'WorkoutDetailsRouteArgs{workoutId: $workoutId, key: $key}';
  }
}

/// generated route for
/// [_i14.WorkoutTypesScreen]
class WorkoutTypesRoute extends _i17.PageRouteInfo<void> {
  const WorkoutTypesRoute({List<_i17.PageRouteInfo>? children})
    : super(WorkoutTypesRoute.name, initialChildren: children);

  static const String name = 'WorkoutTypesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i14.WorkoutTypesScreen();
    },
  );
}

/// generated route for
/// [_i15.WorkoutsFilterScreen]
class WorkoutsFilterRoute extends _i17.PageRouteInfo<void> {
  const WorkoutsFilterRoute({List<_i17.PageRouteInfo>? children})
    : super(WorkoutsFilterRoute.name, initialChildren: children);

  static const String name = 'WorkoutsFilterRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.WorkoutsFilterScreen();
    },
  );
}

/// generated route for
/// [_i16.WorkoutsPage]
class WorkoutsRoute extends _i17.PageRouteInfo<void> {
  const WorkoutsRoute({List<_i17.PageRouteInfo>? children})
    : super(WorkoutsRoute.name, initialChildren: children);

  static const String name = 'WorkoutsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.WorkoutsPage();
    },
  );
}
