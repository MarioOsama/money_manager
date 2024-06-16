import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class StatisticsHistoryItem extends StatelessWidget {
  const StatisticsHistoryItem({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpace(5.h),
          Text(title, style: TextStyles.f16BlackMedium),
          verticalSpace(8.h),
          Text(
            amount.toStringAsFixed(2),
            style: TextStyles.f18GreySemiBold,
          ),
        ],
      ),
    );
  }
}
