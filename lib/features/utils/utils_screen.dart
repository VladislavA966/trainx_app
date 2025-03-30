import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/utils/app_modal.dart';
import 'package:trainx_app/features/utils/domain/entity/util_card_data.dart';
import 'package:trainx_app/features/utils/widgets/utils_card_widget.dart';
import 'package:trainx_app/features/workouts/domain/entity/workout_type.dart';
import 'package:trainx_app/generated/l10n.dart';

@RoutePage()
class UtilsScreen extends StatefulWidget {
  const UtilsScreen({super.key});

  @override
  State<UtilsScreen> createState() => _UtilsScreenState();
}

class _UtilsScreenState extends State<UtilsScreen> with AppModal {
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
    showEnumSelectModal<WorkoutType>(
      context,
      values: WorkoutType.values,
      title: S.of(context).selectSportType,
      onSelect: (value) {},
    );
  }

  late final cardsData = [
    UtilsCardData(
      title: S.of(context).hrZones,
      icon: Icons.favorite,
      onTap: _onPulseZonesTap,
    ),
    UtilsCardData(
      title: S.of(context).metronome,
      icon: Icons.access_alarm,
      onTap: (_) {},
    ),
    UtilsCardData(
      title: S.of(context).calcDistPeace,
      icon: Icons.calculate,
      onTap: (_) {},
    ),
    UtilsCardData(
      title: S.of(context).calcPeaceSpeed,
      icon: Icons.speed,
      onTap: (_) {},
    ),
    UtilsCardData(
      title: 'AI ${S.of(context).coach}',
      icon: Icons.smart_toy,
      onTap: (_) {},
    ),
  ];
}
