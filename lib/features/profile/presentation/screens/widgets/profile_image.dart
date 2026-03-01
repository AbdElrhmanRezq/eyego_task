
import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.height,
    required this.state
  });
  final UserDataLoaded state;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.45,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            state.user.profileImage,
            fit: BoxFit.cover,
          ),
    
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, kBackground],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Stack(
              children: [
                Opacity(opacity: 0.02,child: Container(height: 48,width:48,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(50)))),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new, color: kMainColor),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Stack(
              children: [
                Opacity(opacity: 0.02,child: Container(height: 48,width:48,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(50)))),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kSettingsRoute);
                  },
                  icon: Icon(Icons.settings, color: kMainColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
