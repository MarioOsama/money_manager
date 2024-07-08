import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/settings/ui/widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: AppString.settings.tr()),
        ListView(
          shrinkWrap: true,
          children: [
            SettingsItem(
              title: AppString.resetPIN.tr(),
              icon: const Icon(Icons.fiber_pin),
              onTap: () {
                context.pushNamed(Routes.resetPasswordScreen);
              },
            ),
            SettingsItem(
              title: AppString.preferences.tr(),
              icon: const Icon(Icons.linear_scale_rounded),
              onTap: () {
                context.pushNamed(Routes.preferencesScreen);
              },
            ),
          ],
        )
      ],
    );
  }
}
