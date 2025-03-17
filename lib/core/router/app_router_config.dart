import 'package:auto_route/auto_route.dart';

import 'app_router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: WorkoutsRoute.page,
              path: 'workouts',
              children: [
                AutoRoute(
                  page: WorkoutTypesRoute.page,
                  path: 'workout-types',
                ),
                AutoRoute(
                  page: AllWorkoutsRoute.page,
                  path: 'all-workouts',
                ),
                AutoRoute(
                  page: WorkoutsFilterRoute.page,
                  path: 'workouts-filter',
                ),
                AutoRoute(
                  page: WorkoutDetailsRoute.page,
                  path: 'workout-details',
                ),
              ],
            ),
            AutoRoute(
              page: ExercisesRoute.page,
              path: 'exercises',
            ),
            AutoRoute(
              page: UtilsRoute.page,
              path: 'utils',
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
            ),
          ],
        ),
      ];
}
