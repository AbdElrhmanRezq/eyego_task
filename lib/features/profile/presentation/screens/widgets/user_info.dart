import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatelessWidget {
  final UserDataLoaded state;
  const UserInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,

              child: Text(
                state.user.username,
                style: Styles.textStyle30.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            //SizedBox(height: 10),
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
    );
  }
}
