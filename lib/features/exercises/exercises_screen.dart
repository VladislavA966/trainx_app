import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('ExercisesScreen'),
      ),
    );
  }
}
