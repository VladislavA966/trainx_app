import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/tools/domain/entity/util_card_data.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/generated/l10n.dart';

import '../widgets/utils_card_widget.dart';

@RoutePage()
class ToolsScreen extends AutoRouter {
  const ToolsScreen({super.key});
}

@RoutePage()
class AllToolsScreen extends StatefulWidget {
  const AllToolsScreen({super.key});

  @override
  State<AllToolsScreen> createState() => _AllToolsScreenState();
}

class _AllToolsScreenState extends State<AllToolsScreen> {
  late final cardsData = [
    ToolsCardData(
      title: 'Зоны интенсивности',
      icon: Icons.favorite,
      onTap: _onPulseZonesTap,
    ),
    // UtilsCardData(
    //   title: S.of(context).metronome,
    //   icon: Icons.access_alarm,
    //   onTap: (_) => context.pushRoute(const MetronomeRoute()),
    // ),
    ToolsCardData(
      title: S.of(context).calcDistPeace,
      icon: Icons.calculate,
      onTap: (_) {
        AppModal.showEnumSelectModal(
          context,
          title: S.of(context).selectSportType,
          values: WorkoutType.values,
          onSelect: (type) =>
              context.router.push(DistancePaceCalculatorRoute(sportType: type)),
        );
      },
    ),
    // UtilsCardData(
    //   title: S.of(context).calcPeaceSpeed,
    //   icon: Icons.speed,
    //   onTap: (_) => context.pushRoute(const PaceSpeedRoute()),
    // ),
    ToolsCardData(
      title: 'AI ${S.of(context).coach}',
      icon: Icons.smart_toy,
      onTap: (_) => context.pushRoute(const ChatRoute()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.unit0_5,
            vertical: Dimensions.unit,
          ),
          child: ListView.builder(
            itemCount: cardsData.length,
            itemBuilder: (context, index) {
              final data = cardsData[index];
              return UtilsCardWidget(
                title: data.title,
                icon: data.icon,
                onTap: () => data.onTap(context),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onPulseZonesTap(BuildContext context) {
    AppModal.showEnumSelectModal<WorkoutType>(
      context,
      values: WorkoutType.values,
      title: S.of(context).selectSportType,
      onSelect: (value) {},
    );
  }
}
