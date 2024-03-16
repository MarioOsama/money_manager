import 'package:flutter/material.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class PreferencesItem extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  const PreferencesItem(
      {super.key,
      required this.title,
      this.subtitle,
      this.leading,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyles.f16BlackMedium,
      ),
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
