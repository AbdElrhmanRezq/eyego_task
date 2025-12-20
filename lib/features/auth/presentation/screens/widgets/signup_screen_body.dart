import 'package:eyego_task/core/utils/assets.dart';
import 'package:eyego_task/core/utils/functions/empty_validator.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's Start",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "Email Address",
                  icon: Icons.email,
                  controller: emailController,
                  validator: emptyValidator("email"),
                ),
                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Username",
                  icon: Icons.person,
                  controller: usernameController,

                  validator: emptyValidator("username"),
                ),

                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  validator: emptyValidator("password"),
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
