import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/home_screen_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: HomeScreenBody(),
    );
  }
}
