import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/profile/presentation/screens/widgets/settings_screen_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenSettingsBody extends StatelessWidget {
  const ProfileScreenSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        children: [
          SettingsScreenTile(
            height: height,
            title: 'Edit Profile Image',
            icon: Icons.image,
            onTap: () {},
          ),
          SettingsScreenTile(
            height: height,
            title: 'Change Profile Name',
            icon: Icons.edit,
            onTap: () {},
          ),
          SettingsScreenTile(
            height: height,
            title: 'Logout',
            icon: Icons.logout,
            onTap: () {
              (context).read<AuthCubit>().auth.logout();
              GoRouter.of(context).pop();
              GoRouter.of(context).pop();

              GoRouter.of(context).push(AppRouter.kInitialRoute);
            },
          ),
        ],
      ),
    );
  }
}
