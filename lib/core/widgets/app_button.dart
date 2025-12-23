import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function()? onPressed;
  const AppButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kMainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),

        child: Text(
          text,
          style: Styles.textStyle14.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
