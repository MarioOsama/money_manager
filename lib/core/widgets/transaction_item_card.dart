import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/date.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class TransactionItemCard extends StatelessWidget {
  final Transaction transactionData;
  final Category transactionCategory;
  final String currencyAbbreviation;
  final bool isPeriodicDate;
  const TransactionItemCard({
    super.key,
    required this.transactionData,
    required this.transactionCategory,
    required this.isPeriodicDate,
    required this.currencyAbbreviation,
  });

  @override
  Widget build(BuildContext context) {
    final String categoryName = transactionData.categoryName;
    final String title = transactionData.title;
    final DateTime date = transactionData.date;
    final String formattedDate = isPeriodicDate
        ? DateHelper.getPeriodicDate(date)
        : DateHelper.toDateFormat(date.toString())!;
    final double amount = transactionData.amount;
    final int categoryColorCode = transactionCategory.colorCode;
    final bool isExpense =
        transactionData.transactionType == TransactionType.expense;
    final String typeSign = isExpense ? '-' : '+';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.grey[50],
          border: Border(
            left: BorderSide(
              color: isExpense
                  ? AppColors.lightRedColor
                  : AppColors.lightGreenColor,
              width: 5.w,
            ),
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: ListTile(
          onTap: () {
            context.pushNamed(Routes.transactionDetailsScreen,
                arguments: transactionData);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          titleAlignment: ListTileTitleAlignment.center,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          title: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: DefaultTextStyle(
              style: TextStyles.f16BlackSemiBold.copyWith(
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 16)),
              child: Text(
                title,
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 5.0),
            child: DefaultTextStyle(
              style: TextStyles.f15GreySemiBold.copyWith(
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 13)),
              child: Text(
                formattedDate,
              ),
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: DefaultTextStyle(
                    style: isExpense
                        ? TextStyles.f18RedSemiBold.copyWith(
                            fontSize: TextStyles.getResponsiveFontSize(context,
                                baseFontSize: 16))
                        : TextStyles.f18LightGreenSemiBold.copyWith(
                            fontSize: TextStyles.getResponsiveFontSize(context,
                                baseFontSize: 16)),
                    child: Text(
                      '$typeSign$currencyAbbreviation $amount',
                    ),
                  ),
                ),
              ),
              verticalSpace(10),
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Color(categoryColorCode).withOpacity(0.50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3.0,
                    ),
                    child: DefaultTextStyle(
                      style: TextStyles.f12BlackSemiBold.copyWith(
                          color:
                              Color(categoryColorCode + categoryColorCode * 3),
                          overflow: TextOverflow.ellipsis,
                          fontSize: TextStyles.getResponsiveFontSize(context,
                              baseFontSize: 12),
                          fontWeight: FontWeight.w600),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          categoryName,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
