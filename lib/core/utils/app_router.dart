import 'package:eyego_task/features/auth/presentation/screens/init_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/login_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/signup_screen.dart';
import 'package:eyego_task/features/home/data/models/article_model.dart';
import 'package:eyego_task/features/home/presentation/screens/article_screen.dart';
import 'package:eyego_task/features/home/presentation/screens/home_screen.dart';
import 'package:eyego_task/features/home/presentation/screens/profile_screen.dart';
import 'package:eyego_task/features/home/presentation/screens/search_screen.dart';
import 'package:eyego_task/features/splash/presentation/screens/splash_screen_body.dart';
import 'package:eyego_task/features/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kSplashRoute = '/';
  static const kInitialRoute = '/init';

  static const kLoginRoute = '/login';
  static const kSignupRoute = '/signup';
  static const kResetPasswordRoute = '/reset';
  static const kHomeRoute = '/home';
  static const kSearchRoute = '/home/search';
  static const kProfileRoute = '/home/profile';
  static const kArticleRoute = '/home/article';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kSplashRoute, builder: (context, state) => SplashScreen()),

      GoRoute(path: kInitialRoute, builder: (context, state) => InitScreen()),
      GoRoute(path: kLoginRoute, builder: (context, state) => LoginScreen()),
      GoRoute(path: kSignupRoute, builder: (context, state) => SignupScreen()),
      GoRoute(
        path: kResetPasswordRoute,
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(path: kHomeRoute, builder: (context, state) => HomeScreen()),
      GoRoute(path: kSearchRoute, builder: (context, state) => SearchScreen()),
      GoRoute(
        path: kProfileRoute,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: kArticleRoute,
        builder: (context, state) =>
            ArticleScreen(article: state.extra as ArticleModel),
      ),
    ],
  );
}
