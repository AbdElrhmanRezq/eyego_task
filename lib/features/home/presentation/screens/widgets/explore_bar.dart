import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/app_router.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreBar extends StatelessWidget {
  const ExploreBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Explore",
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
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
          ],
        ),
      ],
    );
  }
}
