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
    context.read<BankCardCubit>().updateBankCardData();
    return BlocBuilder<BankCardCubit, BankCardState>(
      builder: (context, state) {
        double totalBalance =
            state is BankCardLoaded ? state.bankCardBalance : 0.0;
        double income = state is BankCardLoaded ? state.bankCardIncomes : 0.0;
        double expense = state is BankCardLoaded ? state.bankCardExpenses : 0.0;
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
                color: AppColors.primaryColor.withOpacity(0.75),
                blurRadius: 15,
                offset: const Offset(0, 15),
                spreadRadius: 5,
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
                      Text(
                        'Total Balance',
                        style: TextStyles.f18CyanMedium,
                      ),
                      Text('\$$totalBalance', style: TextStyles.f30WhiteBold),
                    ],
                  ),
                  const Spacer(),
                  //TODO: Remove this icon button if not needed
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 30,
                        color: AppColors.lightCyanColor,
                      ))
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  _buildBalanceCard(
                      title: 'Income',
                      amount: '\$$income',
                      icon: const Icon(
                        Icons.download_sharp,
                        color: AppColors.lightCyanColor,
                        size: 20,
                      )),
                  const Spacer(),
                  horizontalSpace(10),
                  _buildBalanceCard(
                      title: 'Expense',
                      amount: '\$$expense',
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.lightCyanColor.withOpacity(0.2),
              child: icon,
            ),
            horizontalSpace(7),
            Text(
              title,
              style: TextStyles.f18CyanMedium,
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyles.f18WhiteSemiBold,
        ),
      ],
    );
  }
}
