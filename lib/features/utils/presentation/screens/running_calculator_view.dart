import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
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
  late final CalculateRunningPaceStrategy _strategy;

  final distances = [
    LabeledValue(value: 5.0, title: '5 км'),
    LabeledValue(value: 10.0, title: '10 км'),
    LabeledValue(value: 21.1, title: '21.1 км'),
    LabeledValue(value: 42.195, title: '42.195 км'),
  ];

  final _timeController = TextEditingController();
  final _paceController = TextEditingController();
  final _distanceController = TextEditingController();

  final selectedDistance = ValueNotifier<double?>(null);
  final entireTime = ValueNotifier<bool>(true);
  final calculatedValue = ValueNotifier<String>('');
  final paceMinutes = ValueNotifier<int>(0);
  final paceSeconds = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _strategy = CalculateRunningPaceStrategy();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _paceController.dispose();
    _distanceController.dispose();
    paceMinutes.dispose();
    paceSeconds.dispose();
    calculatedValue.dispose();
    entireTime.dispose();
    selectedDistance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          labelText: S.of(context).select_distance,
          controller: _distanceController,
          readOnly: true,
          onSuffixPressed: _onDistanceSuffixPressed,
          onTap: () {
            showListSelectModal<LabeledValue>(
              context,
              title: S.of(context).select_distance,
              values: distances,
              titleBuilder: (item) => item.title,
              onSelect: (value) {
                selectedDistance.value = value.value;
                _distanceController.text = value.title;
                calculatedValue.value = '';
              },
            );
          },
        ),
        const SizedBox(height: 16),
        Text(S.of(context).common_input_question),
        ValueListenableBuilder(
          valueListenable: entireTime,
          builder: (context, value, child) => Wrap(
            spacing: 8,
            children: [
              //TODO вытаскивать цвета из темы
              ChoiceChip(
                label: Text(S.of(context).common_time),
                selected: entireTime.value,
                selectedColor: AppColors.primary,
                disabledColor: AppColors.greyLight,
                onSelected: (_) => _onCheapChanged(true),
              ),
              ChoiceChip(
                label: Text(S.of(context).common_pace),
                selected: !entireTime.value,
                selectedColor: AppColors.primary,
                disabledColor: AppColors.greyLight,
                onSelected: (_) => _onCheapChanged(false),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: entireTime,
          builder: (context, value, child) => AppTextFormField(
            readOnly: true,
            onTap: () {
              showPacePicker(
                context,
                selectedMinutes: paceMinutes.value,
                selectedSeconds: paceSeconds.value,
                onSelectedMinutes: (min) => paceMinutes.value = min,
                onSelectedSeconds: (sec) => paceSeconds.value = sec,
                onReady: () {
                  final formatted =
                      '${paceMinutes.value.toString().padLeft(2, '0')}:${paceSeconds.value.toString().padLeft(2, '0')}';
                  _paceController.text = formatted;
                },
              );
            },
            onSuffixPressed: _onSecondFieldSuffixPressed,
            controller: entireTime.value ? _timeController : _paceController,
            keyboardType: TextInputType.number,
            labelText: entireTime.value
                ? S.of(context).input_time_hh_mm_ss
                : S.of(context).input_running_pace,
          ),
        ),
        const SizedBox(height: 24),
        AppButton(
          title: S.of(context).common_calculate,
          onPressed: () {
            if (entireTime.value) {
              _calculatePace();
            } else {
              _calculateTimeFromPace();
            }
          },
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder<String>(
          valueListenable: calculatedValue,
          builder: (context, value, _) {
            if (value.isEmpty) return const SizedBox.shrink();
            return AppResultBox.fromText(calculatedValue.value);
          },
        )
      ],
    );
  }

  void _onCheapChanged(bool value) {
    entireTime.value = value;
    _timeController.clear();
    _paceController.clear();
    calculatedValue.value = '';
  }

  void _onSecondFieldSuffixPressed() {
    _timeController.clear();
    _paceController.clear();
    paceMinutes.value = 0;
    paceSeconds.value = 0;
    calculatedValue.value = '';
  }

  void _onDistanceSuffixPressed() {
    _distanceController.clear();
    selectedDistance.value = null;
    calculatedValue.value = '';
  }

  void _calculatePace() {
    log(_distanceController.text);
  }

  void _calculateTimeFromPace() {
    if (selectedDistance.value == null) return;

    final result = _strategy.calculateTime(
      distance: selectedDistance.value!,
      minutes: paceMinutes.value,
      seconds: paceSeconds.value,
    );

    if (result != null) {
      calculatedValue.value = result;
    }
  }
}
