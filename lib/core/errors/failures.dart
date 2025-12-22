import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ServerFailure("Request to server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout in connection with server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout in connection with server");
      case DioExceptionType.badResponse:
        {
          final statusCode = dioError.response?.statusCode;
          if (statusCode != null) {
            switch (statusCode) {
              case 400:
                return ServerFailure("Bad request");
              case 401:
                return ServerFailure("Unauthorized request");
              case 403:
                return ServerFailure("Forbidden request");
              case 429:
                return ServerFailure("You have ran out of requests quota");
              case 404:
                return ServerFailure("Not found");
              case 500:
                return ServerFailure("Internal server error");
              default:
                return ServerFailure(
                  "Received invalid status code: $statusCode",
                );
            }
          } else {
            return ServerFailure("Received invalid response from server");
          }
        }
      default:
        return ServerFailure("Unexpected error occurred");
    }
  }
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);

  factory FirebaseFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return const FirebaseFailure('The email address is not valid.');

      case 'user-disabled':
        return const FirebaseFailure('This user account has been disabled.');

      case 'user-not-found':
        return const FirebaseFailure('No user found for this email.');

      case 'wrong-password':
        return const FirebaseFailure('Incorrect password.');

      case 'email-already-in-use':
        return const FirebaseFailure(
          'An account already exists with this email.',
        );

      case 'operation-not-allowed':
        return const FirebaseFailure('Operation not allowed.');

      case 'weak-password':
        return const FirebaseFailure('The password is too weak.');

      case 'too-many-requests':
        return const FirebaseFailure(
          'Too many attempts. Please try again later.',
        );

      case 'network-request-failed':
        return const FirebaseFailure(
          'Network error. Please check your internet connection.',
        );

      default:
        return FirebaseFailure(
          e.message ?? 'An unexpected Firebase error occurred.',
        );
    }
  }
}
