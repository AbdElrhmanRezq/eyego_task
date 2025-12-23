import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(AssetsData.logo),
      ),
      leadingWidth: 120,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kProfileRoute);
          },
          icon: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kMainColor, width: 2),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.person, color: kMainColor),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchRoute);
          },
          icon: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kMainColor, width: 2),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.search, color: kMainColor),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
