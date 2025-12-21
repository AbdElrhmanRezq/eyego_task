import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/reset_password_screen_body.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SimpleAppBar(),
      body: ResetPasswordScreenBody(),
    );
  }
}
