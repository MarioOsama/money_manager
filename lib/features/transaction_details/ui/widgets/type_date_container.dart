import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/date.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class TypeDateContainer extends StatelessWidget {
  final bool isExpense;
  final DateTime transactionDate;
  final String transactionId;
  final bool isPeriodicFormat;
  const TypeDateContainer({
    super.key,
    required this.isExpense,
    required this.transactionDate,
    required this.transactionId,
    required this.isPeriodicFormat,
  });

  @override
  Widget build(BuildContext context) {
    final String transactionType = isExpense ? 'Expense' : 'Income';
    final transactionFormattedDate = isPeriodicFormat
        ? DateHelper.getPeriodicDate(transactionDate)
        : DateHelper.toDateFormat(transactionDate.toString());
    return Positioned(
      bottom: 5,
      left: 20,
      right: 20,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey[400]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Type',
                  style: TextStyles.f16LightGreySemiBold.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 16)),
                ),
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 3,
                      decoration: BoxDecoration(
                          color: isExpense
                              ? AppColors.lightRedColor
                              : AppColors.lightGreenColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          )),
                    ),
                    horizontalSpace(5),
                    Text(
                      transactionType,
                      style: TextStyles.f16BlackSemiBold.copyWith(
                          fontSize: TextStyles.getResponsiveFontSize(context,
                              baseFontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
            VerticalDivider(
              color: Colors.grey[400],
              thickness: 1,
              width: 1,
              indent: 10,
              endIndent: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Date',
                  style: TextStyles.f16LightGreySemiBold.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 16)),
                ),
                Hero(
                  tag: '$transactionId+$transactionFormattedDate',
                  child: DefaultTextStyle(
                    style: TextStyles.f16BlackSemiBold.copyWith(
                        fontSize: TextStyles.getResponsiveFontSize(context,
                            baseFontSize: 16)),
                    child: Text(
                      transactionFormattedDate!,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
