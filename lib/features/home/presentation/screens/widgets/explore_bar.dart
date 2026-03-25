import 'package:eyego_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

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
      ],
    );
  }
}
