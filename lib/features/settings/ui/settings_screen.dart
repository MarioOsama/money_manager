import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/settings/ui/widgets/settings_item.dart';

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
          children: [
            SettingsItem(
              title: 'Reset PIN',
              icon: const Icon(Icons.fiber_pin),
              onTap: () {
                print('pressed');
                context.pushNamed(Routes.resetPasswordScreen);
              },
            ),
            SettingsItem(
              title: 'Preferences',
              icon: const Icon(Icons.linear_scale_rounded),
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
