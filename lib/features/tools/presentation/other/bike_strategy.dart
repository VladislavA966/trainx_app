import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/tools/domain/entity/labled_value.dart';
import 'package:trainx_app/features/tools/presentation/other/calculate_pace_strategy.dart';
import 'package:trainx_app/features/tools/presentation/screens/calculator_view/state/calculator_state.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/speed_picker_config.dart';

class BikePaceStrategy implements CalculatePaceStrategy {
  static const distances = [
    LabeledValue(value: 20.0, title: '20 км'),
    LabeledValue(value: 25.0, title: '25 км'),
    LabeledValue(value: 40.0, title: '40 км'),
    LabeledValue(value: 90.0, title: '90 км'),
    LabeledValue(value: 180.0, title: '180 км'),
  ];

  @override
  String calculatePace({
    required double distance,
    required int hours,
    required int minutes,
    required int seconds,
  }) {
    try {
      final totalHours = hours + (minutes / 60) + (seconds / 3600);
      if (totalHours == 0) return 'Некорректное время';

      final speed = distance / totalHours;

      return 'Средняя скорость: ${speed.toStringAsFixed(1)} км/ч';
    } catch (e) {
      debugPrint('Ошибка расчета скорости: $e');
      return 'Ошибка';
    }
  }

  @override
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  }) {
    try {
      final totalSpeed = minutes + (seconds / 60); // скорость в км/ч
      if (totalSpeed == 0) return null;

      final totalHours = distance / totalSpeed;
      final totalSeconds = (totalHours * 3600).round();
      final duration = Duration(seconds: totalSeconds);

      final h = duration.inHours;
      final m = duration.inMinutes.remainder(60);
      final s = duration.inSeconds.remainder(60);

      String two(int n) => n.toString().padLeft(2, '0');
      return 'Итоговое время: ${two(h)}:${two(m)}:${two(s)}';
    } catch (e) {
      debugPrint('Ошибка расчета времени: $e');
      return null;
    }
  }

  @override
  Future<void> selectDistance({
    required BuildContext context,
    required TextEditingController controller,
    required ValueChanged<double?> onSelect,
  }) async {
    AppModal.showListSelectModal<LabeledValue>(
      context,
      title: 'Выберите дистанцию',
      values: distances,
      titleBuilder: (item) => item.title,
      onSelect: (item) {
        onSelect(item.value);
        controller.text = item.title;
      },
    );
  }

  @override
  Future<void> selectPace({
    required BuildContext context,
    required TextEditingController controller,
    required CalculatorState calculatorState,
  }) async {
    AppModal.showCustomPicker(
      context,
      config: SpeedPickerConfig(
        selectedSpeed: calculatorState.paceMinutes.value,
        onSpeedChanged: (speed) => calculatorState.paceMinutes.value = speed,
        onDone: () {
          final speed = calculatorState.paceMinutes.value;
          controller.text = '$speed км/ч';
        },
      ),
    );
  }

  @override
  String get peaceCheapLabelText => 'Скорость (км/ч)';

  @override
  String get secondFieldLabel => 'Введите скорость (км/ч)';

  @override
  bool get isManualDistanceInput => false;
}
