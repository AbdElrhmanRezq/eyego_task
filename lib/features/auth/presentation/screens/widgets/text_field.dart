import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.validator,
    required this.controller,
  });

  final String hintText;
  final IconData icon;
  final String? Function(String? p1)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kMainColor),
        ),
      ),
      style: Styles.textStyle16,
      validator: validator,
      controller: controller,
      obscureText: hintText == 'Password',
    );
  }
}
