import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/app_button.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:eyego_task/features/profile/presentation/screens/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDataError) {
          return Center(child: Text(state.message));
        } else if (state is UserDataLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ProfileImage(height: height, state: state),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,

                      child: Text(
                        state.user.username,
                        style: Styles.textStyle30.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        (context)
                                .read<AuthCubit>()
                                .auth
                                .supabase
                                .auth
                                .currentUser
                                ?.email ??
                            ' ',
                        style: Styles.textStyle16,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
