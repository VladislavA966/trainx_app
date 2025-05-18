import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type_params.dart';
import 'package:trainx_app/features/workouts/presentation/widgets/workout_type_card.dart';
import 'package:trainx_app/generated/l10n.dart';
import '../../domain/entity/workout_type.dart';

@RoutePage()
class WorkoutTypesScreen extends StatelessWidget {
  const WorkoutTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final types = WorkoutType.values;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).workouts),
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.unit,
                vertical: Dimensions.unit1_5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...types.map(
                    (type) {
                      final params = paramsFromWorkoutType(type);
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: Dimensions.unit2),
                        child: WorkOutTypeCard(
                          title: params.title,
                          imagePath: params.image,
                          onTap: () =>
                              _goToAllWorkoutsScreen(context, type: type),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 72),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.unit2),
              child: AppButton(
                title: S.of(context).allWorkouts,
                onPressed: () => _goToAllWorkoutsScreen(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToAllWorkoutsScreen(BuildContext context, {WorkoutType? type}) {
    context.pushRoute(AllWorkoutsRoute(type: type));
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool? isLoading;
  const AppButton({
    required this.title,
    required this.onPressed,
    this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: isLoading != null && isLoading!
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: onPressed,
              child: Text(title),
            ),
    );
  }
}


