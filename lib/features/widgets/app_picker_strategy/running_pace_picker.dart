import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/picker_config.dart';

final class PacePickerConfig extends PickerConfig {
  final int selectedMinutes;
  final int selectedSeconds;
  final ValueChanged<int> onMinutesChanged;
  final ValueChanged<int> onSecondsChanged;
  final VoidCallback? onDone;

  PacePickerConfig({
    required this.selectedMinutes,
    required this.selectedSeconds,
    required this.onMinutesChanged,
    required this.onSecondsChanged,
    this.onDone,
  });

  @override
  List<AppCupertinoPicker> buildPickers({
    required void Function(int index, int value) onItemChanged,
  }) {
    return [
      AppCupertinoPicker(
        selectedValue: selectedMinutes,
        count: 12,
        unit: 'мин',
        onSelectedItemChanged: (v) => onItemChanged(0, v),
      ),
      AppCupertinoPicker(
        selectedValue: selectedSeconds,
        count: 60,
        unit: 'сек',
        onSelectedItemChanged: (v) => onItemChanged(1, v),
      ),
    ];
  }

  @override
  void onReady(List<int> values) {
    onMinutesChanged(values[0]);
    onSecondsChanged(values[1]);
    onDone?.call();
  }

  @override
  String get title => 'Введите темп';

  @override
  List<int> getInitialValues() => [selectedMinutes, selectedSeconds];
}
