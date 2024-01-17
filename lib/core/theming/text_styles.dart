import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/font_weight.dart';

class TextStyles {
  static TextStyle f48PrimaryMostBlack = TextStyle(
    fontSize: 42.sp,
    fontWeight: FontWeights.mostBold,
    color: AppColors.primaryColor,
  );

  static TextStyle f36PrimaryMostBlack = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeights.mostBold,
    color: AppColors.primaryColor,
  );

  static TextStyle f32CyanBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeights.bold,
    color: AppColors.cyanColor,
  );

  static TextStyle f18WhiteSemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeights.semiBold,
    color: Colors.white,
  );
}
