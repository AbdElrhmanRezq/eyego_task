import 'package:eyego_task/features/home/presentation/screens/widgets/home_app_bar.dart';
import 'package:eyego_task/features/home/presentation/screens/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomeAppBar(), body: HomeScreenBody());
  }
}
