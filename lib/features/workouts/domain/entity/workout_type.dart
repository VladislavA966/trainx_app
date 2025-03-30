import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/params_filter_type.dart';
import 'package:trainx_app/generated/l10n.dart';

enum WorkoutType with ParamsWorkoutType {
  swimming,
  cycling,
  running;

  @override
  String title(BuildContext context) {
    return switch (this) {
      WorkoutType.swimming => S.of(context).swimming,
      WorkoutType.cycling => S.of(context).cycling,
      WorkoutType.running => S.of(context).running,
    };
  }

  static WorkoutType? fromString(BuildContext context, String data) {
    if (data.isEmpty) return null;
    return values.firstWhere(
      (element) => data == element.title(context),
    );
  }

  @override
  IconData icon() {
    return switch (this) {
      WorkoutType.swimming => Icons.pool,
      WorkoutType.cycling => Icons.directions_bike,
      WorkoutType.running => Icons.directions_run,
    };
  }
}
