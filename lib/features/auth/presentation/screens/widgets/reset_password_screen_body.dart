import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/assets.dart';
import 'package:eyego_task/core/utils/functions/empty_validator.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreenBody extends StatefulWidget {
  const ResetPasswordScreenBody({super.key});

  @override
  State<ResetPasswordScreenBody> createState() =>
      _ResetPasswordScreenBodyState();
}

class _ResetPasswordScreenBodyState extends State<ResetPasswordScreenBody> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
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
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),

                    CustomTextFormField(
                      hintText: "Email Address",
                      icon: Icons.email,
                      controller: emailController,
                      validator: emptyValidator("Email Address"),
                    ),

                    SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: CircularProgressIndicator(color: kMainColor),
                          );
                        } else if (state is AuthReset) {
                          return Text(
                            "We sent a link to reset. Check your email",
                          );
                        } else {
                          return AppButton(
                            text: "Reset Password",
                            onPressed: () {
                              if (_key.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().resetPassword(
                                  emailController.text,
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
