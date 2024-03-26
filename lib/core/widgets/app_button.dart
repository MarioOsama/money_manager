import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

const _buttonRadius = 15.0;

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
  final double? fontSize;

  const AppButton({
    super.key,
    required this.onPress,
    required this.text,
    this.backgroundColor,
    this.borderWidth,
    this.width,
    this.height,
    this.horizontalPadding,
    this.verticalPadding,
    this.radius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final isBorder = borderWidth != null;
    return _buildContainer(isBorder);
  }

  Widget _buildContainer(bool isBorder) {
    return Container(
      width: width?.w ?? double.maxFinite,
      height: height?.h ?? 67.h,
      decoration: _buildDecoration(isBorder),
      child: _buildTextButton(isBorder),
    );
  }

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
      borderRadius: BorderRadius.circular(radius ?? _buttonRadius),
      boxShadow: !isBorder
          ? [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.7),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 3,
              ),
            ]
          : null,
    );
  }

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
            borderRadius: BorderRadius.circular(radius ?? _buttonRadius),
            side: BorderSide(
              color: AppColors.primaryColor,
              width: borderWidth ?? 1,
            ),
          ),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyles.f18WhiteSemiBold.copyWith(
            color: isBorder ? AppColors.primaryColor : Colors.white,
            fontSize: fontSize ?? 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
