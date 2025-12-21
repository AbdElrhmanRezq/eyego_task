import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/init_screen_body.dart';
import 'package:eyego_task/features/home/presentation/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = getIt.get<FirebaseAuth>();
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (asyncSnapshot.hasData) {
          return HomeScreen();
        } else {
          return Scaffold(body: InitScreenBody());
        }
      },
    );
  }
}
