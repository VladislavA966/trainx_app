import 'package:flutter/material.dart';
import 'package:trainx_app/app.dart';
import 'core/di/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(const TrainXApp());
}
