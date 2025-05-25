import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/picker_config.dart';

final class SportTimePickerConfig implements PickerConfig {
  final int selectedHours;
  final int selectedMinutes;
  final int selectedSeconds;
  final ValueChanged<int> onHoursChanged;
  final ValueChanged<int> onMinutesChanged;
  final ValueChanged<int> onSecondsChanged;
  final VoidCallback? onDone;

  SportTimePickerConfig({
    required this.selectedHours,
    required this.selectedMinutes,
    required this.selectedSeconds,
    required this.onHoursChanged,
    required this.onMinutesChanged,
    required this.onSecondsChanged,
    this.onDone,
  });

  @override
  String get title => 'Введите время';

  @override
  List<AppCupertinoPicker> buildPickers({
    required void Function(int index, int value) onItemChanged,
  }) {
    return [
      AppCupertinoPicker(
        selectedValue: selectedHours,
        count: 12,
        unit: 'чч',
        onSelectedItemChanged: (v) => onItemChanged(0, v),
      ),
      AppCupertinoPicker(
        selectedValue: selectedMinutes,
        count: 60,
        unit: 'мм',
        onSelectedItemChanged: (v) => onItemChanged(1, v),
      ),
      AppCupertinoPicker(
        selectedValue: selectedSeconds,
        count: 60,
        unit: 'сс',
        onSelectedItemChanged: (v) => onItemChanged(2, v),
      ),
    ];
  }

  @override
  void onReady(List<int> values) {
    onHoursChanged(values[0]);
    onMinutesChanged(values[1]);
    onSecondsChanged(values[2]);
    onDone?.call();
  }

  @override
  List<int> getInitialValues() {
    return [selectedHours, selectedMinutes, selectedHours];
  }
}
