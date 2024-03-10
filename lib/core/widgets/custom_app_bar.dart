import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? action;
  final EdgeInsetsGeometry? margin;
  final Color? foregroundColor;
  const CustomAppBar(
      {super.key, this.title, this.action, this.margin, this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Text(
              title!,
              style: TextStyles.f22PrimaryDarkSemiBold
                  .copyWith(color: foregroundColor),
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
