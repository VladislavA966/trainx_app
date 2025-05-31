import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'app_router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  final AuthCubit authCubit;
  AppRouter(this.authCubit);

  late final authGuard = AuthGuard(authCubit);
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
                  path: '',
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
              children: [
                AutoRoute(
                  page: AllExercisesRoute.page,
                  path: '',
                ),
              ],
            ),
            AutoRoute(
              page: ToolsRoute.page,
              path: 'tools',
              children: [
                AutoRoute(
                  page: AllToolsRoute.page,
                  path: '',
                ),
                AutoRoute(
                  page: DistancePaceCalculatorRoute.page,
                  path: 'distance-pace-calculator',
                ),
              ],
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
              children: [
                AutoRoute(
                  page: UserRoute.page,
                  path: '',
                ),
              ],
            ),
          ],
        ),
        AutoRoute(
          page: LogInRoute.page,
          path: '/log-in',
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: '/sign-in',
        ),
        AutoRoute(
          page: ExerciseDetailsRoute.page,
          path: '/exercise-details',
        ),
        AutoRoute(
          page: ChatRoute.page,
          path: '/ai_chat',
        ),
      ];
}

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;

  AuthGuard(this.authCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    try {
      final isAuthenticated = authCubit.state is AuthLoaded;
      if (isAuthenticated) {
        resolver.next();
      } else {
        resolver.redirectUntil(const LogInRoute());
      }
    } catch (e, st) {
      debugPrint('[AuthGuard] error: $e\n$st');
    }
  }
}
