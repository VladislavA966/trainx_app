import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/tools/domain/entity/labled_value.dart';
import 'package:trainx_app/features/tools/presentation/other/calculate_pace_strategy.dart';
import 'package:trainx_app/features/tools/presentation/screens/calculator_view/state/calculator_state.dart';

import 'package:trainx_app/features/widgets/app_picker_strategy/running_pace_picker.dart';
import 'package:trainx_app/generated/l10n.dart';

class RunningPaceStrategy implements CalculatePaceStrategy {
  @override
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  }) {
    try {
      final pace = minutes + seconds / 60;
      final totalMinutes = pace * distance;
      final totalSeconds = (totalMinutes * 60).round();
      final duration = Duration(seconds: totalSeconds);

      final h = duration.inHours;
      final m = duration.inMinutes.remainder(60);
      final s = duration.inSeconds.remainder(60);

      String two(int n) => n.toString().padLeft(2, '0');
      final formatted = '${two(h)}:${two(m)}:${two(s)}';

      return 'Итоговое время: $formatted';
    } catch (e) {
      return null;
    }
  }

  @override
  String? calculatePace({
    required double distance,
    required int hours,
    required int minutes,
    required int seconds,
  }) {
    try {
      final totalSeconds = hours * 3600 + minutes * 60 + seconds;
      final paceInSeconds = (totalSeconds / distance).round();

      final paceMinutes = paceInSeconds ~/ 60;
      final paceSeconds = paceInSeconds % 60;

      String two(int n) => n.toString().padLeft(2, '0');
      final formatted = '${two(paceMinutes)}:${two(paceSeconds)}';

      return 'Темп: $formatted мин/км';
    } catch (e) {
      debugPrint('Ошибка расчета темпа: $e');
      return 'Ошибка';
    }
  }

  @override
  void selectDistance({
    required BuildContext context,
    required TextEditingController controller,
    required ValueChanged<double?> onSelect,
  }) {
    const distances = [
      LabeledValue(value: 5.0, title: '5 км'),
      LabeledValue(value: 10.0, title: '10 км'),
      LabeledValue(value: 21.1, title: '21.1 км'),
      LabeledValue(value: 42.195, title: '42.195 км'),
    ];
    AppModal.showListSelectModal<LabeledValue>(
      context,
      title: S.of(context).select_distance,
      values: distances,
      titleBuilder: (item) => item.title,
      onSelect: (value) {
        onSelect(value.value);
        controller.text = value.title;
      },
    );
  }

  @override
  String get peaceCheapLabelText => 'Темп';

  @override
  String get secondFieldLabel => 'Введите темп (мин/км)';

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
          controller.text = '$m:$s';
        },
      ),
    );
  }

  @override
  bool get isManualDistanceInput => false;
}
