import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/di/inject.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_entity.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type_params.dart';
import 'package:trainx_app/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:trainx_app/features/workouts/presentation/widgets/workout_card.dart';

@RoutePage()
class AllWorkoutsScreen extends StatefulWidget {
  final WorkoutType? type;
  const AllWorkoutsScreen({super.key, this.type});

  @override
  State<AllWorkoutsScreen> createState() => _AllWorkoutsScreenState();
}

class _AllWorkoutsScreenState extends State<AllWorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    const expandedHeight = 240.0;
    final theme = Theme.of(context);
    final params = paramsFromWorkoutType(widget.type);
    return BlocProvider(
      create: (context) => WorkoutsBloc(inject())
        ..add(WorkoutsEvent.fetchWorkouts(type: widget.type?.name)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(expandedHeight, context, params, theme),
            BlocConsumer<WorkoutsBloc, WorkoutsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.isLoading) {
                  return _buildLoadingState();
                }
                if (state.dataState.workouts.isEmpty) {
                  return _buildEmptyWorkoutsState(theme);
                }
                return _buildLoadedWorkoutsList(state.dataState);
              },
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildEmptyWorkoutsState(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          'Нет доступных тренировок',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(
    double expandedHeight,
    BuildContext context,
    WorkoutTypeParams params,
    ThemeData theme,
  ) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      expandedHeight: expandedHeight,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {
            context.router.push(WorkoutsFilterRoute());
          },
          icon: Icon(
            Icons.filter_alt_rounded,
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final collapsed = constraints.biggest.height <=
              kToolbarHeight + MediaQuery.of(context).padding.top + 10;
          return FlexibleSpaceBar(
            title: collapsed
                ? Text(params.title, style: theme.appBarTheme.titleTextStyle)
                : null,
            background: Image.asset(
              params.image,
              fit: BoxFit.cover,
            ),
            collapseMode: CollapseMode.parallax,
          );
        },
      ),
    );
  }

  SliverPadding _buildLoadedWorkoutsList(WorkoutsStateModel state) {
    return SliverPadding(
      padding: EdgeInsets.all(Dimensions.unit1_5),
      sliver: SliverList.separated(
        itemCount: state.workouts.length,
        separatorBuilder: (context, index) => SizedBox(height: Dimensions.unit),
        itemBuilder: (context, index) =>
            _buildWorkoutCard(state.workouts[index]),
      ),
    );
  }

  WorkoutCard _buildWorkoutCard(WorkoutEntity workout) {
    return WorkoutCard(
      title: workout.title,
      duration: workout.duration,
      volume: workout.volume,
      level: workout.level,
      workoutType: workout.type,
      onTap: () {
        context.pushRoute(WorkoutDetailsRoute(workoutId: workout.id));
      },
    );
  }

  SliverToBoxAdapter _buildLoadingState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: Dimensions.unit4),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
