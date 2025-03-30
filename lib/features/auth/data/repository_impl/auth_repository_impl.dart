import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trainx_app/core/utils/errors_handler.dart';
import 'package:trainx_app/core/utils/firebase_error_handler.dart';
import 'package:trainx_app/features/auth/data/data_soruce/auth_data_source.dart';
import 'package:trainx_app/features/auth/domain/repository/auth_repository.dart';
import 'package:trainx_app/features/profile/data/data_source/profile_data_source.dart';
import 'package:trainx_app/features/profile/data/mapper/profile_mapper.dart';
import 'package:trainx_app/features/profile/domain/entity/profile_entity.dart';

@Singleton(as: AuthRepository)
final class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _firebaseAuthDataSource;
  final ProfileDataSource _profileDataSource;

  AuthRepositoryImpl(
    this._firebaseAuthDataSource,
    this._profileDataSource,
  );

  @override
  Future<Either<Failure, void>> logOut() async {
    final result = await Connectivity().checkConnectivity();
    if (result == [ConnectivityResult.none]) {
      return Left(NetworkFailure());
    }
    try {
      await _firebaseAuthDataSource.logOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity?>> signInWithEmailAndPassword(
      AuthParams params) async {
    final result = await Connectivity().checkConnectivity();
    if (result == [ConnectivityResult.none]) {
      return Left(NetworkFailure());
    }
    try {
      final user = await _firebaseAuthDataSource.signInWithEmailAndPassword(
        params.email,
        params.password,
      );
      return Right(user?.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity?>> signUpWithEmailAndPassword(
      AuthParams params) async {
    final result = await Connectivity().checkConnectivity();
    if (result == [ConnectivityResult.none]) {
      return Left(NetworkFailure());
    }
    try {
      final user = await _firebaseAuthDataSource.signUpWithEmailAndPassword(
        params.email,
        params.password,
      );

      if (user != null) {
        final profileEntity = user.toEntity();

        await _profileDataSource
            .saveUserData(profileEntity.toFirestoreMap())
            .catchError((e) async {
          await user.delete();
          throw AuthExceptionHandler.handleException(e);
        });

        return Right(profileEntity);
      }

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<bool> checkUserAuth() async {
    return await _firebaseAuthDataSource.checkUserAuth();
  }
}
