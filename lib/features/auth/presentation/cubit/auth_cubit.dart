import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:trainx_app/features/auth/domain/repository/auth_repository.dart';

part 'auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> signIn(AuthParams params) async {
    if (state.isLoading) return;

    emit(const AuthLoading());
    final result = await _authRepository.signInWithEmailAndPassword(params);
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const AuthLoaded()),
    );
  }

  Future<void> signUp(AuthParams params) async {
    if (state.isLoading) return;

    emit(const AuthLoading());
    final result = await _authRepository.signUpWithEmailAndPassword(params);
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const AuthLoaded()),
    );
  }

  Future<void> logOut() async {
    if (state.isLoading) return;
    emit(const AuthLoading());
    final result = await _authRepository.logOut();
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(AuthUnauthorized()),
    );
    checkUserAuth();
  }

  Future<void> checkUserAuth() async {
    emit(const AuthLoading());
    final result = await _authRepository.checkUserAuth();
    if (result) {
      emit(const AuthLoaded());
      log('user is authenticated');
    } else {
      emit(const AuthUnauthorized());
      log('user is not authenticated');
    }
  }
}
