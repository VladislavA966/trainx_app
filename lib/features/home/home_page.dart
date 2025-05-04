import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
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
        AllUtilsRoute(),
        ProfileRouteContainerRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
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
      ),
    );
  }
}
