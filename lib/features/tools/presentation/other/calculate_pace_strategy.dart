import 'package:flutter/material.dart';
import 'package:trainx_app/features/tools/presentation/screens/calculator_view/state/calculator_state.dart';

abstract class CalculatePaceStrategy {
  String? calculatePace({
    required double distance,
    required int hours,
    required int minutes,
    required int seconds,
  });

  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  });

  void selectDistance({
    required BuildContext context,
    required TextEditingController controller,
    required ValueChanged<double?> onSelect,
  });

  Future<void> selectPace({
    required BuildContext context,
    required TextEditingController controller,
    required CalculatorState calculatorState,
  });

  String get peaceCheapLabelText;

  String get secondFieldLabel;
  bool get isManualDistanceInput;
}
