import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String title;
  final BoxShape shape;
  const Indicator(
      {super.key,
      required this.title,
      required this.color,
      required this.shape});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, right: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              title,
              textAlign: TextAlign.end,
              style: TextStyles.f14PrimaryBold.copyWith(
                color: AppColors.primaryColor,
                overflow: TextOverflow.clip,
                fontSize:
                    TextStyles.getResponsiveFontSize(context, baseFontSize: 12),
              ),
            ),
          ),
          horizontalSpace(5),
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: color,
              shape: shape,
            ),
          ),
        ],
      ),
    );
  }
}
