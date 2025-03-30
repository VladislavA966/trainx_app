import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trainx_app/core/utils/errors_handler.dart';
import 'package:trainx_app/features/profile/domain/entity/profile_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ProfileEntity?>> signInWithEmailAndPassword(
      AuthParams params);
  Future<Either<Failure, ProfileEntity?>> signUpWithEmailAndPassword(
      AuthParams params);
  Future<Either<Failure, void>> logOut();
  Future<bool> checkUserAuth();
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({required this.email, required this.password});

  AuthParams copyWith({
    String? email,
    String? password,
  }) {
    return AuthParams(
        email: email ?? this.email, password: password ?? this.password);
  }

  @override
  List<Object?> get props => [email, password];
}
