import 'package:flutter/material.dart';

class CalculatorState {
  final selectedDistance = ValueNotifier<double?>(null);
  final entireTime = ValueNotifier<bool>(true);
  final calculatedValue = ValueNotifier<String>('');
  final paceMinutes = ValueNotifier<int>(0);
  final paceSeconds = ValueNotifier<int>(0);
  final timeHours = ValueNotifier<int>(0);
  final timeMinutes = ValueNotifier<int>(0);
  final timeSeconds = ValueNotifier<int>(0);
  final timeController = TextEditingController();
  final paceController = TextEditingController();
  final distanceController = TextEditingController();

  void dispose() {
    selectedDistance.dispose();
    entireTime.dispose();
    calculatedValue.dispose();
    paceMinutes.dispose();
    paceSeconds.dispose();
    timeHours.dispose();
    timeMinutes.dispose();
    timeSeconds.dispose();
    timeController.dispose();
    paceController.dispose();
    distanceController.dispose();
  }
}
