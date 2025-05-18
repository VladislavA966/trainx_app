import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:trainx_app/app.dart';
import 'core/di/di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await initDi();
  FlutterNativeSplash.remove();
  runApp(const TrainXApp());
}
