import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/features/widgets/app_base_card.dart';

import '../workouts/domain/entity/workout_type.dart';

@RoutePage()
class AllExercisesScreen extends StatefulWidget {
  const AllExercisesScreen({super.key});

  @override
  State<AllExercisesScreen> createState() => _AllExercisesScreenState();
}

class _AllExercisesScreenState extends State<AllExercisesScreen>
    with TickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);
  final types = WorkoutType.values;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Упражнения'),
        bottom: TabBar(
          controller: _tabController,
          tabs: types
              .map(
                (type) => Tab(
                  text: type.title(context),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ExercisesList(exercises: ['Плавание', 'Велосипед', 'Бег']),
          ExercisesList(exercises: ['Плавание', 'Велосипед', 'Бег']),
          ExercisesList(exercises: ['Плавание', 'Велосипед', 'Бег']),
        ],
      ),
    );
  }
}

class ExercisesList extends StatelessWidget {
  final List<String> exercises;
  const ExercisesList({
    super.key,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(Dimensions.unit0_5),
            child: ExerciseCardWidget(),
          ),
        ),
      ],
    );
  }
}

class ExerciseCardWidget extends StatelessWidget {
  const ExerciseCardWidget({
    super.key,
  });

  static const _previewImageId = '7pb-rn8F6oM';
  static const _image =
      'https://i3.ytimg.com/vi/$_previewImageId/maxresdefault.jpg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(ExerciseDetailsRoute());
      },
      child: AppBaseCard(
        height: 120,
        child: Row(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.unit1_5),
                    child: CachedNetworkImage(
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.unit1_5),
                        ),
                      ),
                      imageUrl: _image,
                    ),
                  ),
                  Icon(
                    Icons.play_circle,
                    size: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.unit1_5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Test title'),
                Text('Test description'),
                Text('Test duration'),
                Text('Test type'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
