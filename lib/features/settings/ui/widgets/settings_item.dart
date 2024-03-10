import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function() onTap;
  const SettingsItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),
      padding: EdgeInsets.symmetric(vertical: 5.0.h),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 3,
            offset: const Offset(3, 5),
          )
        ],
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyles.f18WhiteSemiBold,
        ),
        trailing: const Icon(Icons.chevron_right_sharp),
        iconColor: Colors.white,
        onTap: onTap,
      ),
    );
  }
}
