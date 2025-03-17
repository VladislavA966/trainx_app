import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type_params.dart';
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
                          title: params.title(context),
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
  final VoidCallback onPressed;
  const AppButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}

class WorkOutTypeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const WorkOutTypeCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.unit2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.2),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.unit2),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
            ),
            const Positioned(
              right: 16,
              bottom: 16,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
