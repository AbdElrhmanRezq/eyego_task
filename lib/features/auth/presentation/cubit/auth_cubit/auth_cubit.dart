import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/auth/data/repo/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.auth) : super(AuthInitial());

  final AuthRepoImpl auth;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final Either<Failure, UserCredential> response = await auth.login(
      email,
      password,
    );
    response.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  Future<void> signup(String email, String password) async {
    emit(AuthLoading());

    final Either<Failure, UserCredential> response = await auth.signup(
      email,
      password,
    );
    response.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  Future<void> signout() async {
    emit(AuthLoading());

    final Either<Failure, void> response = await auth.signout();
    response.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthSignout()),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());

    final Either<Failure, void> response = await auth.resetPassword(email);
    response.fold((l) => emit(AuthError(l.message)), (r) => emit(AuthReset()));
  }
}
