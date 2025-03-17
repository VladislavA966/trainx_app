import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
  final String title;
  final String type;
  final String level;
  final String duration;
  final String volume;
  final String id;
  final String? warmUp;
  final String? coolDown;
  final String? mainSet;

  const WorkoutEntity({
    required this.warmUp,
    required this.coolDown,
    required this.mainSet,
    required this.title,
    required this.type,
    required this.level,
    required this.duration,
    required this.volume,
    required this.id,
  });

  @override
  List<Object?> get props => [
        title,
        type,
        level,
        duration,
        volume,
        id,
        warmUp,
        coolDown,
        mainSet,
      ];
}
