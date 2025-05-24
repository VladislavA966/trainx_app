import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/features/utils/presentation/screens/bike_calculator_view.dart';
import 'package:trainx_app/features/utils/presentation/screens/running_calculator_view/running_calculator_view.dart';
import 'package:trainx_app/features/utils/presentation/screens/swimming_calculator_view.dart';
import 'package:trainx_app/features/widgets/keyboard_dismiss_wrapper.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';

@RoutePage()
class DistancePaceCalculatorScreen extends StatelessWidget {
  final WorkoutType sportType;

  const DistancePaceCalculatorScreen({super.key, required this.sportType});

  @override
  Widget build(BuildContext context) {
    return AppKeyboardDismissWrapper(
      child: Scaffold(
        appBar: AppBar(title: Text(_titleByType(sportType))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildViewByType(sportType),
        ),
      ),
    );
  }

  String _titleByType(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return 'Калькулятор бега';
      case WorkoutType.cycling:
        return 'Калькулятор велосипеда';
      case WorkoutType.swimming:
        return 'Калькулятор плавания';
    }
  }

  Widget _buildViewByType(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return const RunCalculatorView();
      case WorkoutType.cycling:
        return const BikeCalculatorView();
      case WorkoutType.swimming:
        return const SwimCalculatorView();
    }
  }
}
