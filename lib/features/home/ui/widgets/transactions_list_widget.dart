import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/dismissible_background.dart';
import 'package:money_manager/core/widgets/transaction_item_card.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';

class TransactionsListWidget extends StatelessWidget {
  final TransactionType transactionType;
  const TransactionsListWidget({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.state is! HomeTransactionsFiltered) {
      homeCubit.filterTransactionsByType();
    }

    final bool isExpanse = transactionType == TransactionType.expense;
    final bool isPeriodicFormat = homeCubit.getDateFormat == 'Periodic';

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final List<Transaction> transactions = state is HomeTransactionsFiltered
            ? isExpanse
                ? state.expenses
                : state.incomes
            : [];

        final int listLength = transactions.length;
        final String transactionType = isExpanse ? 'Expense' : 'Income';

        return listLength == 0
            ? Center(
                child: Text(
                  'There are no $transactionType, \n try to log new $transactionType',
                  style: TextStyles.f14GreySemiBold.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 5.h),
                itemCount: listLength > 5 ? 5 : listLength,
                itemBuilder: (context, index) {
                  final Transaction currentTransaction = transactions[index];
                  final String categoryName = currentTransaction.categoryName;
                  final Category currentTransactionCategory =
                      homeCubit.getTransactionCategory(categoryName);
                  final String createdAt = currentTransaction.createdAt;
                  final String currencyAbbreviation =
                      homeCubit.getCurrencyAbbreviation;

                  return Dismissible(
                    key: Key(currentTransaction.createdAt),
                    onDismissed: (direction) => onDismissed(context, createdAt),
                    background: const DismissibleBackground(),
                    direction: DismissDirection.endToStart,
                    child: TransactionItemCard(
                      transactionData: currentTransaction,
                      transactionCategory: currentTransactionCategory,
                      isPeriodicDate: isPeriodicFormat,
                      currencyAbbreviation: currencyAbbreviation,
                    ),
                  );
                },
              );
      },
    );
  }

  onDismissed(BuildContext context, String createdAt) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final BankCardCubit bankCardCubit = context.read<BankCardCubit>();
    homeCubit.deleteTransaction(createdAt);
    bankCardCubit.updateBankCardData();
  }
}
