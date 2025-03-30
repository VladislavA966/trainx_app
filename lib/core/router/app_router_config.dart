import 'package:auto_route/auto_route.dart';

import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'app_router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  final AuthCubit authCubit;
  AppRouter(this.authCubit);
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
              page: ProfileRouteContainerRoute.page,
              path: 'profile',
              children: [
                AutoRoute(
                  page: LogInRoute.page,
                  path: 'log-in',
                  initial: authCubit.state is! AuthLoaded,
                ),
                AutoRoute(
                  page: ProfileRoute.page,
                  path: 'user-profile',
                  initial: authCubit.state is AuthLoaded,
                ),
                AutoRoute(
                  page: SignInRoute.page,
                  path: 'sign-in',
                ),
              ],
            ),
          ],
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
