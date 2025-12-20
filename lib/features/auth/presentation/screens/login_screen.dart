import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/login_screen_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SimpleAppBar(), body: LoginScreenBody());
  }
}
