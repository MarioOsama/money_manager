import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? action;
  final EdgeInsetsGeometry? margin;
  final Color? foregroundColor;
  final bool? withBackButton;
  const CustomAppBar(
      {super.key,
      this.title,
      this.action,
      this.margin,
      this.foregroundColor,
      this.withBackButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 35.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (withBackButton ?? false)
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: foregroundColor,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          if (title != null)
            Text(
              title!,
              style: TextStyles.f22PrimaryDarkSemiBold.copyWith(
                  color: foregroundColor,
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 22)),
            ),
          action ??
              SizedBox(
                height: 50.h,
              ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 48);
}
