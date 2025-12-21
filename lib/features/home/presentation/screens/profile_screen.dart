import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/profile_screen_body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SimpleAppBar(), body: ProfileScreenBody());
  }
}
