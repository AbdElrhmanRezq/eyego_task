import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
  @override
  Future<Either<Failure, UserCredential>> login(
    String email,
    String password,
  ) async {
    try {
      return right(
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signup(
    String email,
    String password,
  ) async {
    try {
      return right(
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      return right(await firebaseAuth.sendPasswordResetEmail(email: email));
    } on FirebaseAuthException catch (e) {
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signout() async {
    try {
      return right(await firebaseAuth.signOut());
    } on FirebaseAuthException catch (e) {
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }
}
