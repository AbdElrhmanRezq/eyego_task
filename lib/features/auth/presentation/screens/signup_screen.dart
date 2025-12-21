import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/signup_screen_body.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: SignupScreenBody(),
      resizeToAvoidBottomInset: true,
    );
  }
}
