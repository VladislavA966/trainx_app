// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/workouts/data/data_source/workouts_data_source.dart'
    as _i233;
import '../../features/workouts/data/repository_impl/workouts_repository_impl.dart'
    as _i858;
import '../../features/workouts/domain/repository/workouts_repository.dart'
    as _i822;
import '../firebase/fire_base_config.dart' as _i825;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => firebaseModule.initFirebaseApp,
      preResolve: true,
    );
    gh.singleton<_i233.WorkoutsDataSource>(
        () => _i233.FireBaseWorkoutsDataSource());
    gh.singleton<_i822.WorkoutsRepository>(() => _i858.WorkoutsRepositoryImpl(
        workoutsDataSource: gh<_i233.WorkoutsDataSource>()));
    gh.lazySingleton<_i59.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i982.FirebaseApp>()));
    return this;
  }
}

class _$FirebaseModule extends _i825.FirebaseModule {}
