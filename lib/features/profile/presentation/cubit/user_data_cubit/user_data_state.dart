part of 'user_data_cubit.dart';

sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}
final class UserDataLoading extends UserDataState {}
final class UserDataLoaded extends UserDataState {
  final UserModel user;
  UserDataLoaded(this.user);
}
final class UserDataError extends UserDataState {
  final String message;
  UserDataError(this.message);
}
