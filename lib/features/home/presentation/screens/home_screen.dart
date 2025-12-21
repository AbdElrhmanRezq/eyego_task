import 'package:eyego_task/core/utils/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        getIt.get<FirebaseAuth>().signOut();
      },
      child: Text("Logout"),
    );
  }
}
