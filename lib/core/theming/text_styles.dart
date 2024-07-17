import 'package:flutter/material.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/font_weight.dart';

class TextStyles {
  static TextStyle f48PrimaryMostBlack = const TextStyle(
    fontSize: 42,
    fontWeight: FontWeights.mostBold,
    color: AppColors.primaryColor,
  );

  static TextStyle f38WhiteBold = const TextStyle(
    fontSize: 38,
    fontWeight: FontWeights.bold,
    color: Colors.white,
  );

  static TextStyle f36PrimaryMostBold = const TextStyle(
    fontSize: 36,
    fontWeight: FontWeights.mostBold,
    color: AppColors.primaryColor,
  );

  static TextStyle f24CyanBold = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeights.bold,
    color: AppColors.cyanColor,
  );

  static TextStyle f24WhiteMedium = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeights.medium,
    color: Colors.white,
  );

  static TextStyle f24PrimaryBold = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeights.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle f18PrimaryBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle f20PrimaryDarkBold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeights.bold,
    color: AppColors.primaryDarkColor,
  );

  static TextStyle f20RedBold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeights.bold,
    color: AppColors.redColor,
  );

  static TextStyle f20PrimaryDarkSemiBold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeights.semiBold,
    color: AppColors.primaryDarkColor,
  );

  static TextStyle f22PrimaryDarkSemiBold = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeights.semiBold,
    color: AppColors.primaryDarkColor,
  );

  static TextStyle f20WhiteSemiBold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeights.semiBold,
    color: Colors.white,
  );

  static TextStyle f22WhiteRegular = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeights.regular,
    color: Colors.white,
  );

  static TextStyle f18WhiteSemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBold,
    color: Colors.white,
  );

  static TextStyle f18WhiteMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.medium,
    color: Colors.white,
  );

  static TextStyle f16BlackSemiBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.semiBold,
    color: Colors.black,
  );

  static TextStyle f18RedSemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBold,
    color: AppColors.lightRedColor,
  );

  static TextStyle f18LightPrimarySemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBold,
    color: AppColors.lightPrimaryColor,
  );

  static TextStyle f18LightGreenSemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBold,
    color: AppColors.lightGreenColor,
  );

  static TextStyle f18CyanMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.medium,
    color: AppColors.cyanColor,
  );

  static TextStyle f20LightGreySemiBold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeights.semiBold,
    color: Color(0xFF989898),
  );

  static TextStyle f16PrimaryMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    color: AppColors.primaryColor,
  );

  static TextStyle f18PrimarySemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBold,
    color: AppColors.primaryColor,
  );

  static TextStyle f16BlackMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    color: Colors.black,
  );

  static TextStyle f16LightPrimaryMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    color: AppColors.lightPrimaryColor,
  );

  static TextStyle f16LightGreySemiBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.semiBold,
    color: Color(0xFF989898),
  );

  static TextStyle f16WhiteMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    color: Colors.white,
  );

  static TextStyle f16PrimaryDarkBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.bold,
    color: AppColors.primaryDarkColor,
  );

  static TextStyle f15GreyRegular = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeights.regular,
    color: Color(0xFF646464),
  );

  static TextStyle f15GreySemiBold = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeights.semiBold,
    color: Color(0xFF646464),
  );

  static TextStyle f18GreySemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBold,
    color: Color.fromARGB(255, 83, 83, 83),
  );

  static TextStyle f15PrimaryLightSemiBold = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeights.semiBold,
    color: AppColors.lightPrimaryColor,
  );

  static TextStyle f14WhiteSemiBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeights.semiBold,
    color: Colors.white,
  );

  static TextStyle f14GreyRegular = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeights.regular,
    color: Color(0xFF646464),
  );

  static TextStyle f14GreySemiBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeights.semiBold,
    color: Color(0xFF646464),
  );

  static TextStyle f14PrimaryBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeights.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle f12BlackSemiBold = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeights.extraBold,
    color: Colors.black,
  );

  static double getResponsiveFontSize(BuildContext context,
      {required double baseFontSize}) {
    final double scaleFactor = _getScaleFactor(context);
    final double responsiveFontSize = baseFontSize * scaleFactor;
    final double minimumFontSize = baseFontSize * 0.8;
    final double maximumFontSize = baseFontSize * 1.1;
    return responsiveFontSize.clamp(minimumFontSize, maximumFontSize);
  }

  static double _getScaleFactor(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return width / 400;
  }
}
