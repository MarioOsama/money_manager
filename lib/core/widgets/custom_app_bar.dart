import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? action;
  const CustomAppBar({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.f22PrimaryDarkSemiBold,
          ),
          action ??
              SizedBox(
                height: 50.h,
              ),
        ],
      ),
    );
  }
}
