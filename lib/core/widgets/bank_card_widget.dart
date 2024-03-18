import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class BankCardWidget extends StatelessWidget {
  final double? radius;
  final double? height;
  final double? width;
  final EdgeInsets? padding;

  const BankCardWidget(
      {super.key, this.radius, this.height, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    final BankCardCubit bankCardCubit = context.read<BankCardCubit>();
    bankCardCubit.updateBankCardData();
    return BlocBuilder<BankCardCubit, BankCardState>(
      builder: (context, state) {
        double totalBalance =
            state is BankCardLoaded ? state.bankCardBalance : 0.0;
        double income = state is BankCardLoaded ? state.bankCardIncomes : 0.0;
        double expense = state is BankCardLoaded ? state.bankCardExpenses : 0.0;
        String currencyAbbreviation = bankCardCubit.getCurrencyAbbreviation;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: height?.h ?? 225.h,
          width: width?.w ?? double.infinity,
          padding: padding ?? const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(radius?.r ?? 20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDarkColor.withOpacity(0.75),
                blurRadius: 10,
                offset: const Offset(3, 7),
                spreadRadius: 3,
              )
            ],
            image: const DecorationImage(
                image: AssetImage('assets/images/bank-card-circles.png'),
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.lightCyanColor.withOpacity(0.2),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.lightCyanColor,
                              size: 20,
                            ),
                          ),
                          horizontalSpace(7),
                          Text(
                            'Total Balance',
                            style: TextStyles.f18CyanMedium,
                          ),
                        ],
                      ),
                      Text('$currencyAbbreviation $totalBalance',
                          style: TextStyles.f30WhiteBold),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  _buildBalanceCard(
                      title: 'Income',
                      amount: '$currencyAbbreviation $income',
                      icon: const Icon(
                        Icons.download_sharp,
                        color: AppColors.lightCyanColor,
                        size: 20,
                      )),
                  const Spacer(),
                  horizontalSpace(10),
                  _buildBalanceCard(
                      title: 'Expense',
                      amount: '$currencyAbbreviation $expense',
                      icon: const Icon(
                        Icons.file_upload,
                        color: AppColors.lightCyanColor,
                        size: 20,
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _buildBalanceCard(
      {required String title, required String amount, required Icon icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColors.lightCyanColor.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(5),
              child: icon,
            ),
            horizontalSpace(7),
            Text(
              title,
              style: TextStyles.f18CyanMedium,
            ),
          ],
        ),
        verticalSpace(5),
        Text(
          amount,
          style: TextStyles.f18WhiteSemiBold,
        ),
      ],
    );
  }
}
