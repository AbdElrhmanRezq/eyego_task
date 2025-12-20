import 'package:eyego_task/core/utils/assets.dart';
import 'package:eyego_task/core/utils/functions/empty_validator.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AssetsData.person1, width: 250, height: 250),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                  hintText: "Email Address",
                  icon: Icons.email,
                  controller: emailController,
                  validator: emptyValidator("Email Address"),
                ),
                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock,
                  controller: passwordController,

                  validator: emptyValidator("Password"),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
