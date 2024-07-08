import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class PreferencesItem extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final Widget trailing;
  const PreferencesItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.f16BlackMedium.copyWith(
                    fontSize: TextStyles.getResponsiveFontSize(context,
                        baseFontSize: 16)),
              ),
              verticalSpace(5),
              subtitle,
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: trailing,
          ),
        ),
      ],
    );
  }
}
