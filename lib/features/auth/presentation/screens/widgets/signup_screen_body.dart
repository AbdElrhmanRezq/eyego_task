import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/assets.dart';
import 'package:eyego_task/core/utils/functions/empty_validator.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class SignupScreenBody extends StatefulWidget {
  const SignupScreenBody({super.key});

  @override
  State<SignupScreenBody> createState() => _SignupScreenBodyState();
}

class _SignupScreenBodyState extends State<SignupScreenBody> {
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
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Let's Start",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                      hintText: "Password",
                      icon: Icons.lock,
                      controller: passwordController,
                      validator: emptyValidator("password"),
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: CircularProgressIndicator(color: kMainColor),
                          );
                        } else {
                          return AppButton(
                            text: "Login",
                            onPressed: () {
                              if (_key.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().signup(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                          );
                        }
                      },
                      listener: (BuildContext context, AuthState state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is AuthSuccess) {
                          GoRouter.of(
                            context,
                          ).pushReplacement(AppRouter.kHomeRoute);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
