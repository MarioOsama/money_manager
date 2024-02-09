import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? icon;
  final String? hintText;
  final void Function(String value)? onChanged;
  final bool? isRequired;

  const AppTextFormField({
    super.key,
    required this.title,
    required this.controller,
    this.keyboardType,
    this.icon,
    this.hintText,
    this.onChanged,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.f15GreySemiBold,
          ),
          verticalSpace(5),
          SizedBox(
            height: 75.h,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyles.f18PrimaryLightSemiBold,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: icon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.primaryLightColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.redColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.lightRedColor,
                  ),
                ),
              ),
              validator: isRequired! ? (value) => _validator(value) : null,
            ),
          ),
        ],
      ),
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a valid $title';
    }
    return null;
  }
}
