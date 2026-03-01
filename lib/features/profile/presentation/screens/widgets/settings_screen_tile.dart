import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SettingsScreenTile extends StatelessWidget {
  const SettingsScreenTile({
    super.key,
    required this.height,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final double height;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: height * 0.1,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 31, 31),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 41, 41, 41),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: kMainColor),
            ),
            title: Text(
              title,
              style: Styles.textStyle20.copyWith(color: kMainColor),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
