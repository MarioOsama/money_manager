import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class PriceNameContainer extends StatelessWidget {
  final Transaction transaction;
  const PriceNameContainer({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.transactionType == TransactionType.expense;
    final priceColor =
        isExpense ? AppColors.lightRedColor : AppColors.lightGreenColor;
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      width: double.infinity,
      height: 250.h,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(12, 50, 12, 12),
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(250, 5),
            bottomRight: Radius.elliptical(250, 5),
          )),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Text(
              '\$120',
              style: TextStyles.f42WhiteBold.copyWith(color: priceColor),
            ),
          ),
          verticalSpace(25),
          Text(
            'Buy some stuff',
            style: TextStyles.f22WhiteRegular,
          ),
        ],
      ),
    );
  }
}
