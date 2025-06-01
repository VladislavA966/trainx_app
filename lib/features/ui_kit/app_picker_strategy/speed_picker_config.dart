import 'package:flutter/material.dart';

import 'package:trainx_app/features/ui_kit/export.dart';
import 'picker_config.dart';

final class SpeedPickerConfig extends PickerConfig {
  final int selectedSpeed;
  final ValueChanged<int> onSpeedChanged;
  final VoidCallback? onDone;

  SpeedPickerConfig({
    required this.selectedSpeed,
    required this.onSpeedChanged,
    this.onDone,
  });

  @override
  List<AppCupertinoPicker> buildPickers({
    required void Function(int index, int value) onItemChanged,
  }) {
    return [
      AppCupertinoPicker(
        selectedValue: selectedSpeed,
        count: 56,
        unit: 'км/ч',
        onSelectedItemChanged: (index) {
          onItemChanged(0, index + 5);
        },
      ),
    ];
  }

  @override
  List<int> getInitialValues() => [selectedSpeed];

  @override
  void onReady(List<int> selectedValues) {
    onSpeedChanged(selectedValues[0]);
    onDone?.call();
  }

  @override
  String get title => 'Выберите скорость';
}
