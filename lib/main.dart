import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/home/presentation/cubit/news_cubit/news_cubit.dart';
import 'package:eyego_task/features/home/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(Eyego());
}

class Eyego extends StatelessWidget {
  const Eyego({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepoImpl>())),
        BlocProvider(create: (context) => NewsCubit()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: "Briefly",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.karlaTextTheme(),
          scaffoldBackgroundColor: kBackground,
          primaryColor: kMainColor,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: kMainColor,
            selectionHandleColor: kMainColor,
          ),
        ),
      ),
    );
  }
}
