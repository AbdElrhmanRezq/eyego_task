import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/profile/presentation/screens/widgets/profile_screen_settings_body.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Settings"),
      body: ProfileScreenSettingsBody(),
    );
  }
}
