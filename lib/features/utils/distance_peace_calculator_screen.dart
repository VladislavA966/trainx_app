import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/widgets/app_base_card.dart';
import 'package:trainx_app/features/widgets/app_text_form_field.dart';
import 'package:trainx_app/features/widgets/keyboard_dismiss_wrapper.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';
import 'package:trainx_app/generated/l10n.dart';

import 'peace_to_speed_calcilator_screen.dart';

@RoutePage()
class DistancePaceCalculatorScreen extends StatelessWidget {
  final WorkoutType sportType;

  const DistancePaceCalculatorScreen({super.key, required this.sportType});

  @override
  Widget build(BuildContext context) {
    return AppKeyboardDismissWrapper(
      child: Scaffold(
        appBar: AppBar(title: Text(_titleByType(sportType))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildViewByType(sportType),
        ),
      ),
    );
  }

  String _titleByType(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return 'Калькулятор бега';
      case WorkoutType.cycling:
        return 'Калькулятор велосипеда';
      case WorkoutType.swimming:
        return 'Калькулятор плавания';
    }
  }

  Widget _buildViewByType(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return const RunCalculatorView();
      case WorkoutType.cycling:
        return const BikeCalculatorView();
      case WorkoutType.swimming:
        return const SwimCalculatorView();
    }
  }
}

class RunCalculatorView extends StatefulWidget {
  const RunCalculatorView({super.key});

  @override
  State<RunCalculatorView> createState() => _RunCalculatorViewState();
}

class LabeledValue<T> {
  final T value;
  final String title;

  const LabeledValue({
    required this.value,
    required this.title,
  });
}

class _RunCalculatorViewState extends State<RunCalculatorView> with AppModal {
  final distances = [
    LabeledValue(value: 5.0, title: '5 км'),
    LabeledValue(value: 10.0, title: '10 км'),
    LabeledValue(value: 21.1, title: '21.1 км'),
    LabeledValue(value: 42.195, title: '42.195 км'),
  ];
  final selectedDistance = ValueNotifier<double?>(null);
  final entireTime = ValueNotifier<bool>(true);
  final calculatedValue = ValueNotifier<String>('');
  final _timeController = TextEditingController();
  final _paceController = TextEditingController();
  final _distanceController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    _paceController.dispose();
    _distanceController.dispose();
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
                selectedMinutes: 0,
                selectedSeconds: 0,
              );
            },
            onSuffixPressed: _onSecondFieldSuffixPressed,
            controller: entireTime.value ? _timeController : _paceController,
            keyboardType: TextInputType.number,
            inputFormatter: entireTime.value
                ? [TimeTextInputFormatter()]
                : [MinutesSecondsFormatter()],
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
            return AppBaseCard(
              child: AppResultBox.fromText(calculatedValue.value),
            );
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
    calculatedValue.value = '';
  }

  void _onDistanceSuffixPressed() {
    _distanceController.clear();
    selectedDistance.value = null;
    calculatedValue.value = '';
  }

  void _calculatePace() {
    if (selectedDistance.value == null) return;
    try {
      final duration = parseDuration(_timeController.text);
      final distance = selectedDistance.value;
      final totalMinutes = duration.inSeconds / 60;

      final pace = totalMinutes / distance!;
      final paceMinutes = pace.floor();
      final paceSeconds = ((pace - paceMinutes) * 60).round();

      final formatted =
          '${paceMinutes.toString().padLeft(2, '0')}:${paceSeconds.toString().padLeft(2, '0')}';

      calculatedValue.value = 'Целевой темп:\n $formatted мин/км';
    } catch (e) {
      debugPrint('Ошибка расчета темпа: $e');
    }
    return;
  }

  Duration parseDuration(String input) {
    final parts = input.split(':').map(int.parse).toList();
    if (parts.length == 3) {
      return Duration(hours: parts[0], minutes: parts[1], seconds: parts[2]);
    } else {
      throw FormatException('Неверный формат времени');
    }
  }

  void _calculateTimeFromPace() {
    if (selectedDistance.value == null) return;

    try {
      final parts = _paceController.text.split(':').map(int.parse).toList();
      if (parts.length != 2) throw FormatException('Неверный формат темпа');

      final paceMinutes = parts[0];
      final paceSeconds = parts[1];
      final pace = paceMinutes + paceSeconds / 60;

      final distance = selectedDistance.value;
      final totalMinutes = pace * distance!;
      final totalSeconds = (totalMinutes * 60).round();

      final duration = Duration(seconds: totalSeconds);
      final formatted = _formatDuration(duration);

      calculatedValue.value = 'Итоговое время: $formatted';
    } catch (e) {
      debugPrint('Ошибка расчёта времени: $e');
    }
  }

  String _formatDuration(Duration duration) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60);
    final s = duration.inSeconds.remainder(60);
    return '${two(h)}:${two(m)}:${two(s)}';
  }
}

class AppResultBox extends StatelessWidget {
  final String title;
  final String value;

  const AppResultBox({
    super.key,
    required this.title,
    required this.value,
  });

  factory AppResultBox.fromText(String fullText) {
    final parts = fullText.split(':');
    final title = parts.first.trim();
    final value = parts.length > 1 ? parts.sublist(1).join(':').trim() : '';
    return AppResultBox(title: title, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
          ),
        ],
      ),
    );
  }
}

class TimeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 6; i++) {
      if (i == 2 || i == 4) buffer.write(':');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class BikeCalculatorView extends StatelessWidget {
  const BikeCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Bike calculator UI'));
  }
}

class SwimCalculatorView extends StatelessWidget {
  const SwimCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Swim calculator UI'));
  }
}
