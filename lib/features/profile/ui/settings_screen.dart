import 'package:flutter/material.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/profile/ui/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomAppBar(title: 'Settings'),
        ListView(
          shrinkWrap: true,
          children: const [
            SettingsItem(
              title: 'Reset Password',
              icon: Icon(Icons.lock_reset),
            ),
            SettingsItem(
              title: 'Preferences',
              icon: Icon(Icons.linear_scale_rounded),
            ),
          ],
        )
      ],
    );
  }
}
