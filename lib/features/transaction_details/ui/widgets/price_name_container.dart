import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class PriceNameContainer extends StatelessWidget {
  final double transactionAmount;
  final String transactionTitle;
  final String transactionId;
  final bool isExpense;
  final String currencyAbbreviation;
  const PriceNameContainer({
    super.key,
    required this.transactionAmount,
    required this.transactionTitle,
    required this.isExpense,
    required this.transactionId,
    required this.currencyAbbreviation,
  });

  @override
  Widget build(BuildContext context) {
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
          image: DecorationImage(
            image: AssetImage('assets/images/transaction-price-bg.png'),
            fit: BoxFit.fitWidth,
            opacity: 0.02,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(250, 5),
            bottomRight: Radius.elliptical(250, 5),
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currencyAbbreviation,
                style: TextStyle(
                    fontSize: TextStyles.getResponsiveFontSize(context,
                        baseFontSize: 38),
                    color: AppColors.primaryDarkColor,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      )
                    ]),
              ),
              horizontalSpace(5),
              Hero(
                tag: '$transactionId+$transactionAmount',
                child: DefaultTextStyle(
                  style: TextStyles.f38WhiteBold
                      .copyWith(
                          color: priceColor,
                          fontSize: TextStyles.getResponsiveFontSize(context,
                              baseFontSize: 38))
                      .copyWith(shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                    )
                  ]),
                  child: Text(
                    '$transactionAmount',
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(25),
          Hero(
            tag: '$transactionId+$transactionTitle',
            child: DefaultTextStyle(
              style: TextStyles.f22WhiteRegular.copyWith(
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 22)),
              child: Text(
                transactionTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
