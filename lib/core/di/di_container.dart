import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:trainx_app/core/di/di_container.config.dart';

final getIt = GetIt.instance;

/// dart run build_runner build --delete-conflicting-outputs
@InjectableInit(preferRelativeImports: true)
Future<GetIt> initDi() async => getIt.init();
