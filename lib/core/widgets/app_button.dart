import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Color? backgroundColor;
  final double? borderWidth;
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;

  const AppButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.backgroundColor,
    this.borderWidth,
    this.width,
    this.height,
    this.horizontalPadding,
    this.verticalPadding,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check the button has outline border or not
    final isBorder = borderWidth != null;
    return _buildContainer(isBorder);
  }

  // Build the Container widget
  Widget _buildContainer(bool isBorder) {
    return Container(
      width: width?.w ?? double.maxFinite,
      height: height?.h ?? 67.h,
      decoration: _buildDecoration(isBorder),
      child: _buildTextButton(isBorder),
    );
  }

  // Build the BoxDecoration
  BoxDecoration _buildDecoration(bool isBorder) {
    return BoxDecoration(
      gradient: !isBorder
          ? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor.withOpacity(0.9),
                AppColors.primaryDarkColor.withOpacity(0.9),
              ],
            )
          : null,
      borderRadius: BorderRadius.circular(radius ?? 50),
      boxShadow: !isBorder
          ? [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.7),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 1,
              ),
            ]
          : null,
    );
  }

  // Build the TextButton widget
  Widget _buildTextButton(bool isBorder) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0,
            vertical: verticalPadding ?? 0,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 50),
            side: BorderSide(
              color: AppColors.primaryColor,
              width: borderWidth ?? 1,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyles.f18WhiteSemiBold.copyWith(
          color: isBorder ? AppColors.primaryColor : Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
