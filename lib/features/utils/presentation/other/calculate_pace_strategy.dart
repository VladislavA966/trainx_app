import 'package:flutter/material.dart';

abstract class CalculatePaceStrategy {
  String calculatePace({
    required double distance,
    required int hours,
    required int minutes,
    required int seconds,
  });
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  });
}

class RunningPaceStrategy implements CalculatePaceStrategy {
  @override
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  }) {
    try {
      final pace = minutes + seconds / 60;
      final totalMinutes = pace * distance;
      final totalSeconds = (totalMinutes * 60).round();
      final duration = Duration(seconds: totalSeconds);

      final h = duration.inHours;
      final m = duration.inMinutes.remainder(60);
      final s = duration.inSeconds.remainder(60);

      String two(int n) => n.toString().padLeft(2, '0');
      final formatted = '${two(h)}:${two(m)}:${two(s)}';

      return 'Итоговое время: $formatted';
    } catch (e) {
      debugPrint('Ошибка расчета времени: $e');
      return null;
    }
  }

  @override
  String calculatePace(
      {required double distance,
      required int hours,
      required int minutes,
      required int seconds}) {
    // TODO: implement calculatePace
    throw UnimplementedError();
  }
}

class BikePaceStrategy implements CalculatePaceStrategy {
  @override
  String calculatePace(
      {required double distance,
      required int hours,
      required int minutes,
      required int seconds}) {
    // TODO: implement calculatePace
    throw UnimplementedError();
  }

  @override
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  }) {
    // TODO: implement calculateTime
    throw UnimplementedError();
  }
}

class SwimmingPaceStrategy implements CalculatePaceStrategy {
  @override
  String calculatePace({
    required double distance,
    required int hours,
    required int minutes,
    required int seconds,
  }) {
    // TODO: implement calculatePace
    throw UnimplementedError();
  }

  @override
  String? calculateTime({
    required double distance,
    required int minutes,
    required int seconds,
  }) {
    // TODO: implement calculateTime
    throw UnimplementedError();
  }
}
