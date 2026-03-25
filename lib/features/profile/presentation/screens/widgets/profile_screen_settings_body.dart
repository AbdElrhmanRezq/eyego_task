import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_images_cubit/user_images_cubit.dart';
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
          BlocConsumer<UserImagesCubit, UserImagesState>(
            builder: (context, state) {
              if (state is UserImagesUploading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    height: height * 0.1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 31, 31, 31),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                );
              } else {
                return SettingsScreenTile(
                  height: height,
                  title: 'Edit Profile Image',
                  icon: Icons.image,
                  onTap: () {
                    context.read<UserImagesCubit>().uploadUserImage(
                      "profile_image",
                    );
                  },
                );
              }
            },
            listener: (context, state) {
              if (state is UserImagesError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is UserImagesUploaded) {
                String newUrl = state.imageUrl as String;
                context.read<UserDataCubit>().changeImageUrl(newUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile image updated successfully'),
                  ),
                );
              }
            },
          ),
          SettingsScreenTile(
            height: height,
            title: 'Statistics',
            icon: Icons.rate_review,
            onTap: () {
              GoRouter.of(context).push(AppRouter.kStats);
            },
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
