// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_soruce/auth_data_source.dart' as _i38;
import '../../features/auth/data/repository_impl/auth_repository_impl.dart'
    as _i954;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/profile/data/data_source/profile_data_source.dart'
    as _i519;
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
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore);
    gh.singleton<_i519.ProfileDataSource>(
        () => _i519.FirebaseProfileDataSource(gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i233.WorkoutsDataSource>(() =>
        _i233.FireBaseWorkoutsDataSource(
            firestore: gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i38.AuthDataSource>(
        () => _i38.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.singleton<_i961.AuthRepository>(() => _i954.AuthRepositoryImpl(
          gh<_i38.AuthDataSource>(),
          gh<_i519.ProfileDataSource>(),
        ));
    gh.singleton<_i822.WorkoutsRepository>(() => _i858.WorkoutsRepositoryImpl(
        workoutsDataSource: gh<_i233.WorkoutsDataSource>()));
    gh.singleton<_i117.AuthCubit>(
        () => _i117.AuthCubit(gh<_i961.AuthRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i825.FirebaseModule {}
