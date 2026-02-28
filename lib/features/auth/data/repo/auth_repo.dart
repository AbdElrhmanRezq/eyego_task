import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';

// abstract class AuthRepo {
//   Future<Either<Failure, UserCredential>> login(String email, String password);
//   Future<Either<Failure, UserCredential>> signup(String email, String password);
//   Future<Either<Failure, void>> signout();
//   Future<Either<Failure, void>> resetPassword(String email);
// }

abstract class AuthRepo {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> signup(
    String email,
    String username,
    String password,
  );
}

