import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failures.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthRepoImpl implements AuthRepo {
//   final FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
//   @override
//   Future<Either<Failure, UserCredential>> login(
//     String email,
//     String password,
//   ) async {
//     try {
//       return right(
//         await firebaseAuth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       return left(FirebaseFailure.fromFirebaseAuthException(e));
//     }
//   }

//   @override
//   Future<Either<Failure, UserCredential>> signup(
//     String email,
//     String password,
//   ) async {
//     try {
//       return right(
//         await firebaseAuth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       return left(FirebaseFailure.fromFirebaseAuthException(e));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> resetPassword(String email) async {
//     try {
//       return right(await firebaseAuth.sendPasswordResetEmail(email: email));
//     } on FirebaseAuthException catch (e) {
//       return left(FirebaseFailure.fromFirebaseAuthException(e));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> signout() async {
//     try {
//       return right(await firebaseAuth.signOut());
//     } on FirebaseAuthException catch (e) {
//       return left(FirebaseFailure.fromFirebaseAuthException(e));
//     }
//   }
// }

class AuthRepoImpl implements AuthRepo {
  final supabase = getIt<SupabaseClient>();
  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      final user = supabase.auth.currentUser;

      if (user != null) {
        final userCheck = await supabase
            .from('users')
            .select()
            .eq('u_id', user.id)
            .single()
            .maybeSingle();
        if (userCheck == null) {
          await supabase.from('users').insert({
            'u_id': user.id,
            'email': user.email,
            'username': user.userMetadata?['username'] ?? 'Unknown',
          });
        }
      }
      return right(null);
    } catch (e) {
      return left(AuthFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signup(
    String email,
    String username,
    String password,
  ) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"username": username},
      );

      return right(null);
    } catch (e) {
      return left(AuthFailure.fromException(e));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await supabase.auth.signOut();
      return right(null);
    } catch (e) {
      return left(AuthFailure.fromException(e));
    }
  }
}

