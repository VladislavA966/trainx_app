part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;
  const AuthState({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  const AuthLoading() : super(isLoading: true);
}

class AuthLoaded extends AuthState {
  const AuthLoaded() : super(isLoading: false);
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message}) : super(isLoading: false);

  @override
  List<Object> get props => [message, isLoading];
}
