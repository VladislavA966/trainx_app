import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/tools/presentation/other/calculate_pace_strategy.dart';
import 'package:trainx_app/features/tools/presentation/screens/calculator_view/state/calculator_state.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/running_pace_picker.dart';

class SwimmingPaceStrategy implements CalculatePaceStrategy {
  @override
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  }) {
    try {
      final pacePer100m = minutes + (seconds / 60);
      final totalMinutes = (distance / 100) * pacePer100m;
      final totalSeconds = (totalMinutes * 60).round();
      final duration = Duration(seconds: totalSeconds);

      final h = duration.inHours;
      final m = duration.inMinutes.remainder(60);
      final s = duration.inSeconds.remainder(60);

      String two(int n) => n.toString().padLeft(2, '0');
      return 'Итоговое время: ${two(h)}:${two(m)}:${two(s)}';
    } catch (e) {
      debugPrint('Ошибка расчета времени в плавании: $e');
      return null;
    }
  }

  @override
  String calculatePace({
    required double distance,
    required int hours,
    required int minutes,
    required int seconds,
  }) {
    try {
      final totalSeconds =
          Duration(hours: hours, minutes: minutes, seconds: seconds).inSeconds;
      if (distance <= 0) return 'Некорректная дистанция';

      final pacePer100mSeconds = totalSeconds / (distance / 100);
      final paceMinutes = (pacePer100mSeconds ~/ 60);
      final paceSeconds = (pacePer100mSeconds % 60).round();

      String two(int n) => n.toString().padLeft(2, '0');
      return 'Темп: ${two(paceMinutes)}:${two(paceSeconds)} /100м';
    } catch (e) {
      debugPrint('Ошибка расчета темпа в плавании: $e');
      return 'Ошибка';
    }
  }

  @override
  Future<void> selectDistance({
    required BuildContext context,
    required TextEditingController controller,
    required ValueChanged<double?> onSelect,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> selectPace({
    required BuildContext context,
    required TextEditingController controller,
    required CalculatorState calculatorState,
  }) async {
    AppModal.showCustomPicker(
      context,
      config: PacePickerConfig(
        selectedMinutes: calculatorState.paceMinutes.value,
        selectedSeconds: calculatorState.paceSeconds.value,
        onMinutesChanged: (m) => calculatorState.paceMinutes.value = m,
        onSecondsChanged: (s) => calculatorState.paceSeconds.value = s,
        onDone: () {
          final m =
              calculatorState.paceMinutes.value.toString().padLeft(2, '0');
          final s =
              calculatorState.paceSeconds.value.toString().padLeft(2, '0');
          controller.text = '$m:$s /100м';
        },
      ),
    );
  }

  @override
  String get peaceCheapLabelText => 'Темп (мин/100м)';

  @override
  String get secondFieldLabel => 'Введите темп (мин/100м)';

  @override
  bool get isManualDistanceInput => true;
}
