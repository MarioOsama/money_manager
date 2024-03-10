import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';

class PasswordStageWidget extends StatelessWidget {
  final String stageTitle;
  final String buttonTitle;
  const PasswordStageWidget(
      {super.key, required this.stageTitle, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          stageTitle,
          style: TextStyles.f20WhiteSemiBold,
        ),
        verticalSpace(50),
        AppTextFormField(
          controller: TextEditingController(),
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscure: true,
          borderColor: Colors.white,
          textStyle: TextStyles.f18WhiteSemiBold,
        ),
        verticalSpace(50),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            minimumSize: Size(double.infinity, 50.h),
            foregroundColor: AppColors.primaryColor,
            backgroundColor: Colors.white,
          ),
          child: Text(
            buttonTitle,
            style: TextStyles.f18PrimarySemiBold,
          ),
        ),
      ],
    );
  }
}
