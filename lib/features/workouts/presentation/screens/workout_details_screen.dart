import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/di/inject.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:trainx_app/features/workouts/presentation/widgets/workout_info_widget.dart';
import 'package:trainx_app/generated/l10n.dart';

import 'package:trainx_app/features/ui_kit/export.dart';

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
      create: (context) => WorkoutsBloc(inject())
        ..add(WorkoutsEvent.fetchWorkoutDetails(id: widget.workoutId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).workoutDetails),
          actions: [
            Icon(Icons.share),
            const SizedBox(width: Dimensions.unit),
            Icon(Icons.favorite),
          ],
        ),
        body: BlocConsumer<WorkoutsBloc, WorkoutsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.dataState.workoutDetails != null) {
              final workout = state.dataState.workoutDetails;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.unit0_5,
                    vertical: Dimensions.unit1_5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailsTitle(title: workout?.title ?? ''),
                      const SizedBox(height: Dimensions.unit),
                      WorkoutInfoCardWidget(
                        workout: workout ?? WorkoutEntity.empty(),
                      ),
                      const SizedBox(height: Dimensions.unit),
                      _DetailsTitle(title: 'Разминка'),
                      const SizedBox(height: Dimensions.unit),
                      AppBaseCard(
                        child: Text(
                          workout?.warmUp ?? '',
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
                          workout?.mainSet ?? '',
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
                          workout?.coolDown ?? '',
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
