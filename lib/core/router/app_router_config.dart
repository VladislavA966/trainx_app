import 'package:auto_route/auto_route.dart';

import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'app_router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  final AuthCubit authCubit;
  late final AuthGuard authGuard;
  AppRouter(this.authCubit) {
    authGuard = AuthGuard(authCubit);
  }

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
              children: [
                AutoRoute(
                  page: AllExercisesRoute.page,
                  path: 'all-exercises',
                ),
              ],
            ),
            AutoRoute(
              page: UtilsRoute.page,
              path: 'utils',
              children: [
                AutoRoute(
                  page: AllUtilsRoute.page,
                  path: 'all-utils',
                ),
                AutoRoute(
                  page: MetronomeRoute.page,
                  path: 'metronome',
                ),
                AutoRoute(
                  page: PaceSpeedRoute.page,
                  path: 'pace-speed_calculator',
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
              guards: [authGuard],
              children: [
                AutoRoute(
                  page: ProfileRoute.page,
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
      ];

  // RouteMatch? onNavigate(
  //     RouteMatch match, StackRouter router, BuildContext context) {
  //   final isAuthenticated = authCubit.state is AuthLoaded;
  //   final isOnLoginPage = router.current.name == LogInRoute.name;
  //   final isOnProfilePage = router.current.name == ProfileRoute.name;
  //
  //   if (isAuthenticated && !isOnProfilePage) {
  //     return const ProfileRoute().match(context);
  //   } else if (!isAuthenticated && !isOnLoginPage) {
  //     return const LogInRoute().match(context);
  //   }
  //   return null;
  // }
}

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;

  AuthGuard(this.authCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = authCubit.state is AuthLoaded;
    final isOnLoginPage = router.current.name == LogInRoute.name;
    final isOnProfilePage = router.current.name == ProfileRoute.name;

    if (isAuthenticated && !isOnProfilePage) {
      resolver.redirectUntil(const ProfileRoute());
    } else if (!isAuthenticated && !isOnLoginPage) {
      resolver.redirectUntil(const LogInRoute());
    } else {
      resolver.next();
    }
  }
}
