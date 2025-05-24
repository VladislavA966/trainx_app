import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/utils/domain/entity/labled_value.dart';
import 'package:trainx_app/features/utils/presentation/other/calculate_pace_strategy.dart';
import 'package:trainx_app/features/utils/presentation/widgets/calculated_box_widget.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/running_pace_picker.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/sport_time_picker.dart';
import 'package:trainx_app/features/widgets/app_text_form_field.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';
import 'package:trainx_app/generated/l10n.dart';

import 'package:trainx_app/core/recources/export.dart';

part 'state/calculator_state.dart';

class RunCalculatorView extends StatefulWidget {
  const RunCalculatorView({super.key});

  @override
  State<RunCalculatorView> createState() => _RunCalculatorViewState();
}

class _RunCalculatorViewState extends State<RunCalculatorView> with AppModal {
  late final CalculatePaceStrategy _strategy;

  static const distances = [
    LabeledValue(value: 5.0, title: '5 км'),
    LabeledValue(value: 10.0, title: '10 км'),
    LabeledValue(value: 21.1, title: '21.1 км'),
    LabeledValue(value: 42.195, title: '42.195 км'),
  ];

  final _calculatorState = _CalculatorState();

  @override
  void initState() {
    super.initState();
    _strategy = RunningPaceStrategy();
    _calculatorState.timeController.addListener(_onTimeChanged);
    _calculatorState.paceController.addListener(_onPaceChanged);
  }

  @override
  void dispose() {
    _calculatorState.timeController.removeListener(_onTimeChanged);
    _calculatorState.paceController.removeListener(_onPaceChanged);
    _calculatorState.dispose();
    super.dispose();
  }

  void _onTimeChanged() {
    if (_calculatorState.timeController.text.isEmpty) {
      _calculatorState.calculatedValue.value = '';
    }
  }

  void _onPaceChanged() {
    if (_calculatorState.paceController.text.isEmpty) {
      _calculatorState.calculatedValue.value = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          labelText: S.of(context).select_distance,
          controller: _calculatorState.distanceController,
          readOnly: true,
          onSuffixPressed: _onDistanceSuffixPressed,
          onTap: _showDistanceModal,
        ),
        const SizedBox(height: Dimensions.unit2),
        Text(S.of(context).common_input_question),
        ValueListenableBuilder(
          valueListenable: _calculatorState.entireTime,
          builder: (context, value, _) => Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: Text(S.of(context).common_time),
                selected: value,
                selectedColor: Theme.of(context).primaryColor,
                onSelected: (_) => _onInputTypeChanged(true),
              ),
              ChoiceChip(
                label: Text(S.of(context).common_pace),
                selected: !value,
                selectedColor: Theme.of(context).primaryColor,
                onSelected: (_) => _onInputTypeChanged(false),
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.unit2),
        ValueListenableBuilder(
          valueListenable: _calculatorState.entireTime,
          builder: (context, isTimeInput, _) => AppTextFormField(
            readOnly: true,
            onTap: isTimeInput ? _showSportTimePicker : _showPacePicker,
            onSuffixPressed: _onSecondFieldSuffixPressed,
            controller: isTimeInput
                ? _calculatorState.timeController
                : _calculatorState.paceController,
            labelText: isTimeInput
                ? S.of(context).input_time_hh_mm_ss
                : S.of(context).input_running_pace,
          ),
        ),
        const SizedBox(height: Dimensions.unit2_5),
        AppButton(
          title: S.of(context).common_calculate,
          onPressed: _onCalculatePressed,
        ),
        const SizedBox(height: Dimensions.unit2_5),
        ValueListenableBuilder<String>(
          valueListenable: _calculatorState.calculatedValue,
          builder: (context, value, _) {
            if (value.isEmpty) return const SizedBox.shrink();
            return AppResultBox.fromText(value);
          },
        ),
      ],
    );
  }

  void _onCalculatePressed() {
    if (_calculatorState.entireTime.value) {
      _calculatePaceFromTime();
    } else {
      _calculateTimeFromPace();
    }
  }

  void _showDistanceModal() {
    showListSelectModal<LabeledValue>(
      context,
      title: S.of(context).select_distance,
      values: distances,
      titleBuilder: (item) => item.title,
      onSelect: (value) {
        _calculatorState.selectedDistance.value = value.value;
        _calculatorState.distanceController.text = value.title;
        _calculatorState.calculatedValue.value = '';
      },
    );
  }

  void _showSportTimePicker() {
    showCustomPicker(
      context,
      config: SportTimePickerConfig(
        selectedHours: _calculatorState.timeHours.value,
        selectedMinutes: _calculatorState.timeMinutes.value,
        selectedSeconds: _calculatorState.timeSeconds.value,
        onHoursChanged: (hour) => _calculatorState.timeHours.value = hour,
        onMinutesChanged: (min) => _calculatorState.timeMinutes.value = min,
        onSecondsChanged: (sec) => _calculatorState.timeSeconds.value = sec,
        onDone: () {
          final h = _calculatorState.timeHours.value.toString().padLeft(2, '0');
          final m =
              _calculatorState.timeMinutes.value.toString().padLeft(2, '0');
          final s =
              _calculatorState.timeSeconds.value.toString().padLeft(2, '0');
          _calculatorState.timeController.text = '$h:$m:$s';
        },
      ),
    );
  }

  void _showPacePicker() {
    showCustomPicker(
      context,
      config: PacePickerConfig(
          selectedMinutes: _calculatorState.paceMinutes.value,
          selectedSeconds: _calculatorState.paceSeconds.value,
          onMinutesChanged: (m) => _calculatorState.paceMinutes.value = m,
          onSecondsChanged: (s) => _calculatorState.paceSeconds.value = s,
          onDone: () {
            final m =
                _calculatorState.paceMinutes.value.toString().padLeft(2, '0');
            final s =
                _calculatorState.paceSeconds.value.toString().padLeft(2, '0');
            _calculatorState.paceController.text = '$m:$s';
          }),
    );
  }

  void _onInputTypeChanged(bool isTimeInput) {
    _calculatorState.entireTime.value = isTimeInput;
    _resetInputs();
  }

  void _onSecondFieldSuffixPressed() {
    _resetInputs();
  }

  void _onDistanceSuffixPressed() {
    _calculatorState.distanceController.clear();
    _calculatorState.selectedDistance.value = null;
    _calculatorState.calculatedValue.value = '';
  }

  void _resetInputs() {
    _calculatorState.timeController.clear();
    _calculatorState.paceController.clear();
    _calculatorState.paceMinutes.value = 0;
    _calculatorState.paceSeconds.value = 0;
    _calculatorState.calculatedValue.value = '';
    _calculatorState.paceMinutes.value = 0;
    _calculatorState.paceSeconds.value = 0;
    _calculatorState.timeHours.value = 0;
    _calculatorState.timeMinutes.value = 0;
    _calculatorState.timeSeconds.value = 0;
  }

  void _calculatePaceFromTime() {
    if (_calculatorState.selectedDistance.value == null) return;

    final result = _strategy.calculatePace(
        distance: _calculatorState.selectedDistance.value!,
        hours: _calculatorState.timeHours.value,
        minutes: _calculatorState.timeMinutes.value,
        seconds: _calculatorState.timeSeconds.value);

    if (result != null) {
      _calculatorState.calculatedValue.value = result;
    }
  }

  void _calculateTimeFromPace() {
    if (_calculatorState.selectedDistance.value == null) return;

    final result = _strategy.calculateTime(
      distance: _calculatorState.selectedDistance.value!,
      minutes: _calculatorState.paceMinutes.value,
      seconds: _calculatorState.paceSeconds.value,
    );

    if (result != null) {
      _calculatorState.calculatedValue.value = result;
    }
  }
}
