import 'package:flutter/material.dart';
import 'package:trainx_app/features/tools/presentation/other/bike_strategy.dart';
import 'package:trainx_app/features/tools/presentation/other/calculate_pace_strategy.dart';
import 'package:trainx_app/features/tools/presentation/other/running_strategy.dart';
import 'package:trainx_app/features/tools/presentation/other/swimming_strategy.dart';
import 'package:trainx_app/features/tools/presentation/screens/calculator_view/state/calculator_state.dart';
import 'package:trainx_app/features/tools/presentation/widgets/calculated_box_widget.dart';
import 'package:trainx_app/features/ui_kit/app_picker_strategy/sport_time_picker.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';
import 'package:trainx_app/generated/l10n.dart';
import 'package:trainx_app/core/recources/export.dart';
import 'package:trainx_app/features/ui_kit/export.dart';

class CalculatorView extends StatefulWidget {
  final WorkoutType type;
  const CalculatorView({super.key, required this.type});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  late final CalculatePaceStrategy _strategy;
  final _calculatorState = CalculatorState();

  @override
  void initState() {
    super.initState();
    _strategy = _getStrategyByType(widget.type);
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

  CalculatePaceStrategy _getStrategyByType(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return RunningPaceStrategy();
      case WorkoutType.cycling:
        return BikePaceStrategy();
      case WorkoutType.swimming:
        return SwimmingPaceStrategy();
    }
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
        if (!_strategy.isManualDistanceInput)
          AppTextFormField(
            labelText: S.of(context).select_distance,
            controller: _calculatorState.distanceController,
            readOnly: true,
            onSuffixPressed: _onDistanceSuffixPressed,
            onTap: _showDistanceModal,
          )
        else
          AppTextFormField(
            labelText: S.of(context).select_distance,
            controller: _calculatorState.distanceController,
            onSuffixPressed: _onDistanceSuffixPressed,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final parsed = double.tryParse(value.replaceAll(',', '.'));
              _calculatorState.selectedDistance.value = parsed;
              _calculatorState.calculatedValue.value = '';
            },
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
                label: Text(_strategy.peaceCheapLabelText),
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
                : _strategy.secondFieldLabel,
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
    _strategy.selectDistance(
      context: context,
      controller: _calculatorState.distanceController,
      onSelect: (value) {
        _calculatorState.selectedDistance.value = value;
        _calculatorState.distanceController.text = value.toString();
        _calculatorState.calculatedValue.value = '';
      },
    );
  }

  void _showSportTimePicker() {
    AppModal.showCustomPicker(
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
    _strategy.selectPace(
      context: context,
      controller: _calculatorState.paceController,
      calculatorState: _calculatorState,
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
