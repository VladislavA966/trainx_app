import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/di/inject.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/presentation/cubit/workout_details/workout_details_cubit.dart';
import 'package:trainx_app/features/workouts/presentation/screens/all_workouts_screen.dart';
import 'package:trainx_app/generated/l10n.dart';

@RoutePage()
class WorkoutDetailsScreen extends StatefulWidget {
  final String workoutId;
  const WorkoutDetailsScreen({
    required this.workoutId,
    super.key,
  });

  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WorkoutDetailsCubit(inject())..fetchWorkoutDetails(widget.workoutId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).workoutDetails),
          actions: [
            Icon(Icons.share),
            const SizedBox(width: Dimensions.unit),
            Icon(Icons.favorite),
          ],
        ),
        body: BlocConsumer<WorkoutDetailsCubit, WorkoutDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is WorkoutDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WorkoutDetailsLoaded) {
              final workout = state.details;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.unit0_5,
                    vertical: Dimensions.unit1_5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailsTitle(title: workout.title),
                      const SizedBox(height: Dimensions.unit),
                      WorkoutInfoCardWidget(workout: workout),
                      const SizedBox(height: Dimensions.unit),
                      _DetailsTitle(title: 'Разминка'),
                      const SizedBox(height: Dimensions.unit),
                      AppBaseCard(
                        child: Text(
                          workout.warmUp ?? '',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).canvasColor,
                                  ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.unit),
                      _DetailsTitle(title: 'Основное задание'),
                      const SizedBox(height: Dimensions.unit),
                      AppBaseCard(
                        child: Text(
                          workout.mainSet ?? '',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).canvasColor,
                                  ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.unit),
                      _DetailsTitle(title: 'Заминка'),
                      const SizedBox(height: Dimensions.unit),
                      AppBaseCard(
                        child: Text(
                          workout.coolDown ?? '',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).canvasColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class WorkoutInfoCardWidget extends StatelessWidget {
  const WorkoutInfoCardWidget({
    super.key,
    required this.workout,
  });

  final WorkoutEntity workout;

  @override
  Widget build(BuildContext context) {
    return AppBaseCard(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.unit2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: Dimensions.unit,
                children: [
                  _IconAndTitleRow(
                    title: workout.duration,
                    icon: Icons.timer,
                  ),
                  _IconAndTitleRow(
                    title: workout.volume,
                    icon: Icons.route,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: Dimensions.unit,
                children: [
                  _IconAndTitleRow(
                    title: workout.level,
                    icon: Icons.sports,
                  ),
                  _IconAndTitleRow(
                    title: workout.type,
                    icon: Icons.sports_gymnastics,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class _DetailsTitle extends StatelessWidget {
  final String title;
  const _DetailsTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
      textAlign: TextAlign.start,
    );
  }
}

class _IconAndTitleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  const _IconAndTitleRow({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: Dimensions.unit),
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.canvasColor),
        ),
      ],
    );
  }
}
