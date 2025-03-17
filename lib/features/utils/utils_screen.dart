import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UtilsScreen extends StatelessWidget {
  const UtilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('UtilsScreen'),
      ),
    );
  }
}
