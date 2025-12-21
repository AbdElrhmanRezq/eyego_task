import 'package:eyego_task/features/auth/presentation/screens/init_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/login_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kInitialRoute = '/';
  static const kLoginRoute = '/login';
  static const kSignupRoute = '/signup';
  static const kResetPasswordRoute = '/reset';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kInitialRoute, builder: (context, state) => InitScreen()),
      GoRoute(path: kLoginRoute, builder: (context, state) => LoginScreen()),
      GoRoute(path: kSignupRoute, builder: (context, state) => SignupScreen()),
      GoRoute(
        path: kResetPasswordRoute,
        builder: (context, state) => ResetPasswordScreen(),
      ),
    ],
  );
}
