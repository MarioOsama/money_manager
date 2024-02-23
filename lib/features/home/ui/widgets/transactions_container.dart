import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/date.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';

part 'transactions_header_widget.dart';
part 'transactions_list_widget.dart';

class TransactionsContainer extends StatelessWidget {
  const TransactionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TransactionsHeaderWidget(
            transactionType: TransactionType.expense,
          ),
          const Expanded(
            child: _TransactionsListWidget(
              transactionType: TransactionType.expense,
            ),
          ),
          verticalSpace(25),
          const _TransactionsHeaderWidget(
            transactionType: TransactionType.income,
          ),
          const Expanded(
            child: _TransactionsListWidget(
              transactionType: TransactionType.income,
            ),
          ),
        ],
      ),
    );
  }
}
