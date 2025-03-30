import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/di/inject.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type_params.dart';
import 'package:trainx_app/features/workouts/presentation/cubit/workouts/workouts_cubit.dart';

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
      create: (context) =>
          WorkoutsCubit(inject())..fetchWorkouts(type: widget.type?.name),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(expandedHeight, context, params, theme),
            BlocConsumer<WorkoutsCubit, WorkoutsState>(
              listener: (context, state) => _listener(state, context),
              builder: (context, state) {
                if (state is WorkoutsLoading) {
                  return _buildLoadingState();
                } else if (state is WorkoutsLoaded) {
                  if (state.workouts.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Нет доступных тренировок',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }
                  return _buildLoadedWorkoutsList(state);
                }
                return const SliverToBoxAdapter();
              },
            ),
          ],
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
                ? Text(
                    params.title(context),
                    style: theme.appBarTheme.titleTextStyle,
                  )
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

  void _listener(WorkoutsState state, BuildContext context) {
    if (state is WorkoutsError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  SliverPadding _buildLoadedWorkoutsList(WorkoutsLoaded state) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.unit2),
      sliver: SliverList.separated(
        itemCount: state.workouts.length,
        separatorBuilder: (context, index) => SizedBox(height: Dimensions.unit),
        itemBuilder: (context, index) {
          final workout = state.workouts[index];
          log(workout.toString());
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
        },
      ),
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

class WorkoutCard extends StatelessWidget {
  final String title;
  final String duration;
  final String volume;
  final String level;
  final String workoutType;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.duration,
    required this.volume,
    required this.level,
    required this.workoutType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AppBaseCard(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: theme.cardColor),
                ),
                const SizedBox(height: Dimensions.unit0_5),
                Text(
                  workoutType,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: Dimensions.unit),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: Dimensions.unit2,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: Dimensions.unit0_5),
                    Text(
                      duration,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.cardColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.unit1_5),
                    Icon(
                      Icons.route,
                      size: Dimensions.unit2,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: Dimensions.unit0_5),
                    Text(
                      volume,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.cardColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.unit, vertical: Dimensions.unit0_5),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.unit0_5),
              ),
              child: Text(
                level,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBaseCard extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? wight;
  const AppBaseCard({
    super.key,
    this.child,
    this.wight,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: wight ?? double.infinity,
      padding: const EdgeInsets.all(Dimensions.unit),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor,
        borderRadius: BorderRadius.circular(Dimensions.unit2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Dimensions.unit,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
