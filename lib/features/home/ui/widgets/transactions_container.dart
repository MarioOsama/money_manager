import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/text_styles.dart';

part 'transactions_header_widget.dart';
part 'transactions_list_widget.dart';

enum TransactionType { expense, income }

class TransactionsContainer extends StatelessWidget {
  const TransactionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
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
