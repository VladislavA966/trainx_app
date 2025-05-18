import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/widgets/app_text_form_field.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';

@RoutePage()
class DistancePaceCalculatorScreen extends StatelessWidget {
  final WorkoutType sportType;

  const DistancePaceCalculatorScreen({super.key, required this.sportType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleByType(sportType))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildViewByType(sportType),
      ),
    );
  }

  String _titleByType(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return 'Калькулятор Бега';
      case WorkoutType.cycling:
        return 'Калькулятор Велосипеда';
      case WorkoutType.swimming:
        return 'Калькулятор Плавания';
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
          labelText: 'Выберите дистанцию',
          controller: _distanceController,
          readOnly: true,
          onTap: () {
            showListSelectModal<LabeledValue>(
              context,
              title: 'Выберите дистанцию',
              values: distances,
              titleBuilder: (item) => item.title,
              onSelect: (value) {
                selectedDistance.value = value.value;
                _distanceController.text = '${value.value}';
              },
            );
          },
        ),
        const SizedBox(height: 16),
        const Text('Что вы хотите ввести:'),
        ValueListenableBuilder(
          valueListenable: entireTime,
          builder: (context, value, child) => Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                  label: const Text('Время'),
                  selected: entireTime.value,
                  selectedColor: AppColors.primary,
                  disabledColor: AppColors.greyLight,
                  onSelected: (_) => entireTime.value = true),
              ChoiceChip(
                  label: const Text('Темп'),
                  selected: !entireTime.value,
                  selectedColor: AppColors.primary,
                  disabledColor: AppColors.greyLight,
                  onSelected: (_) => entireTime.value = false),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: entireTime,
          builder: (context, value, child) => AppTextFormField(
            controller: entireTime.value ? _timeController : _paceController,
            keyboardType: TextInputType.number,
            labelText: entireTime.value
                ? 'Введите время (чч:мм:сс)'
                : 'Введите темп (мин/км)',
          ),
        ),
        const SizedBox(height: 24),
        AppButton(
          title: 'Расчитать',
          onPressed: () {},
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _calculate() {
    // TODO: реализовать логику расчёта
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
