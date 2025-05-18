import 'package:flutter/material.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/utils/domain/entity/labled_value.dart';
import 'package:trainx_app/features/utils/presentation/other/calculate_pace_strategy.dart';
import 'package:trainx_app/features/utils/presentation/widgets/calculated_box_widget.dart';
import 'package:trainx_app/features/widgets/app_text_form_field.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';
import 'package:trainx_app/generated/l10n.dart';

class RunCalculatorView extends StatefulWidget {
  const RunCalculatorView({super.key});

  @override
  State<RunCalculatorView> createState() => _RunCalculatorViewState();
}

class _RunCalculatorViewState extends State<RunCalculatorView> with AppModal {
  late final RunningPaceStrategy _strategy;

  static const distances = [
    LabeledValue(value: 5.0, title: '5 км'),
    LabeledValue(value: 10.0, title: '10 км'),
    LabeledValue(value: 21.1, title: '21.1 км'),
    LabeledValue(value: 42.195, title: '42.195 км'),
  ];

  final _timeController = TextEditingController();
  final _paceController = TextEditingController();
  final _distanceController = TextEditingController();

  final _calculatorState = _CalculatorState();

  @override
  void initState() {
    super.initState();
    _strategy = RunningPaceStrategy();

    _timeController.addListener(_onTimeChanged);
    _paceController.addListener(_onPaceChanged);
  }

  @override
  void dispose() {
    _timeController.removeListener(_onTimeChanged);
    _paceController.removeListener(_onPaceChanged);
    _distanceController.dispose();
    _calculatorState.dispose();
    _timeController.dispose();
    _paceController.dispose();
    super.dispose();
  }

  void _onTimeChanged() {
    if (_timeController.text.isEmpty) {
      _calculatorState.calculatedValue.value = '';
    }
  }

  void _onPaceChanged() {
    if (_paceController.text.isEmpty) {
      _calculatorState.calculatedValue.value = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDistanceField(),
        const SizedBox(height: 16),
        Text(S.of(context).common_input_question),
        _buildInputTypeSelector(),
        const SizedBox(height: 16),
        _buildInputField(),
        const SizedBox(height: 24),
        _buildCalculateButton(),
        const SizedBox(height: 24),
        _buildResultBox(),
      ],
    );
  }

  Widget _buildDistanceField() {
    return AppTextFormField(
      labelText: S.of(context).select_distance,
      controller: _distanceController,
      readOnly: true,
      onSuffixPressed: _onDistanceSuffixPressed,
      onTap: _showDistanceModal,
    );
  }

  Widget _buildInputTypeSelector() {
    return ValueListenableBuilder(
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
    );
  }

  Widget _buildInputField() {
    return ValueListenableBuilder(
      valueListenable: _calculatorState.entireTime,
      builder: (context, isTimeInput, _) => AppTextFormField(
        readOnly: true,
        onTap: _showPacePicker,
        onSuffixPressed: _onSecondFieldSuffixPressed,
        controller: isTimeInput ? _timeController : _paceController,
        keyboardType: TextInputType.number,
        labelText: isTimeInput
            ? S.of(context).input_time_hh_mm_ss
            : S.of(context).input_running_pace,
      ),
    );
  }

  Widget _buildCalculateButton() {
    return AppButton(
      title: S.of(context).common_calculate,
      onPressed: _onCalculatePressed,
    );
  }

  Widget _buildResultBox() {
    return ValueListenableBuilder<String>(
      valueListenable: _calculatorState.calculatedValue,
      builder: (context, value, _) {
        if (value.isEmpty) return const SizedBox.shrink();
        return AppResultBox.fromText(value);
      },
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
        _distanceController.text = value.title;
        _calculatorState.calculatedValue.value = '';
      },
    );
  }

  void _showPacePicker() {
    showPacePicker(
      context,
      selectedMinutes: _calculatorState.paceMinutes.value,
      selectedSeconds: _calculatorState.paceSeconds.value,
      onSelectedMinutes: (min) => _calculatorState.paceMinutes.value = min,
      onSelectedSeconds: (sec) => _calculatorState.paceSeconds.value = sec,
      onReady: () {
        final formatted =
            '${_calculatorState.paceMinutes.value.toString().padLeft(2, '0')}:${_calculatorState.paceSeconds.value.toString().padLeft(2, '0')}';
        _paceController.text = formatted;
      },
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
    _distanceController.clear();
    _calculatorState.selectedDistance.value = null;
    _calculatorState.calculatedValue.value = '';
  }

  void _resetInputs() {
    _timeController.clear();
    _paceController.clear();
    _calculatorState.paceMinutes.value = 0;
    _calculatorState.paceSeconds.value = 0;
    _calculatorState.calculatedValue.value = '';
  }

  void _calculatePaceFromTime() {
    if (_calculatorState.selectedDistance.value == null) return;
    // TODO: Implement pace calculation from time
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

class _CalculatorState {
  final selectedDistance = ValueNotifier<double?>(null);
  final entireTime = ValueNotifier<bool>(true);
  final calculatedValue = ValueNotifier<String>('');
  final paceMinutes = ValueNotifier<int>(0);
  final paceSeconds = ValueNotifier<int>(0);

  void dispose() {
    selectedDistance.dispose();
    entireTime.dispose();
    calculatedValue.dispose();
    paceMinutes.dispose();
    paceSeconds.dispose();
  }
}
