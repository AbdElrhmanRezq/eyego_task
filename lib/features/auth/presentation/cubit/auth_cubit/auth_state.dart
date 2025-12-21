part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserCredential user;
  AuthSuccess(this.user);
}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class AuthSignout extends AuthState {}

final class AuthReset extends AuthState {}
