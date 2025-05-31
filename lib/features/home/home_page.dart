import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trainx_app/generated/l10n.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        WorkoutTypesRoute(),
        AllExercisesRoute(),
        AllToolsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) =>
          BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (prevState, currentState) => prevState != currentState,
        listener: (context, state) {
          if (state is AuthUnauthorized) {
            tabsRouter.setActiveIndex(0);
          }
        },
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => _onTap(index, state, tabsRouter),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: S.of(context).workouts,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pool),
                label: S.of(context).exercises,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.widgets),
                label: S.of(context).widgets,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: S.of(context).profile,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onTap(int index, AuthState state, TabsRouter tabsRouter) {
    if (index == 3 && state is AuthUnauthorized) {
      context.router.push(const LogInRoute()).then((result) {
        if (result != null) {
          tabsRouter.setActiveIndex(3);
        }
      });
    } else {
      if (index == tabsRouter.activeIndex) {
        tabsRouter
            .innerRouterOf<StackRouter>(tabsRouter.current.name)
            ?.popUntilRoot();
      } else {
        tabsRouter.setActiveIndex(index);
      }
    }
  }
}
