import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';

class PasswordStageWidget extends StatelessWidget {
  final String stageTitle;
  final String buttonTitle;
  final TextEditingController passwordController;
  final void Function() onPressed;
  const PasswordStageWidget(
      {super.key,
      required this.stageTitle,
      required this.buttonTitle,
      required this.onPressed,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          stageTitle,
          style: TextStyles.f20WhiteSemiBold.copyWith(
              fontSize:
                  TextStyles.getResponsiveFontSize(context, baseFontSize: 20)),
        ),
        verticalSpace(50),
        AppTextFormField(
          controller: passwordController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscure: true,
          borderColor: Colors.white,
          textStyle: TextStyles.f18WhiteSemiBold.copyWith(
              fontSize:
                  TextStyles.getResponsiveFontSize(context, baseFontSize: 18)),
        ),
        verticalSpace(50),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            minimumSize: Size(double.infinity, 50.h),
            foregroundColor: AppColors.primaryColor,
            backgroundColor: Colors.white,
          ),
          child: Text(
            buttonTitle,
            style: TextStyles.f18PrimarySemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 18)),
          ),
        ),
      ],
    );
  }
}
