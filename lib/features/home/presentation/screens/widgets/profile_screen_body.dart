import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: Styles.textStyle30.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),

          Text(
            (context).read<AuthCubit>().auth.firebaseAuth.currentUser?.email ??
                ' ',
            style: Styles.textStyle16,
          ),
          SizedBox(height: 20),

          AppButton(
            text: "Logout",
            onPressed: () {
              (context).read<AuthCubit>().auth.signout();
              GoRouter.of(context).pop();
              GoRouter.of(context).push(AppRouter.kInitialRoute);
            },
          ),
        ],
      ),
    );
  }
}
