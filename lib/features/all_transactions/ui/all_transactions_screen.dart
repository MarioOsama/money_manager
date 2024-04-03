import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/transaction_item_card.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';

class AllTransactionsScreen extends StatelessWidget {
  final TransactionType transactionType;
  const AllTransactionsScreen({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final AllTransactionsCubit allTransactionsCubit =
        context.read<AllTransactionsCubit>();
    allTransactionsCubit.loadAllTransactions(transactionType);
    final List<Transaction> allTypeTransactions =
        (allTransactionsCubit.state as AllTransactionsLoadedState)
            .allTransactions;
    final String titleType =
        transactionType == TransactionType.expense ? 'Expense' : 'Income';
    final bool isPeriodicFormat =
        allTransactionsCubit.getDateFormat == 'Periodic';
    final String currencyAbbreviation =
        allTransactionsCubit.getCurrencyAbbreviation;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primaryDarkColor,
        title: Text(
          'All $titleType Transactions',
          style: TextStyles.f22PrimaryDarkSemiBold.copyWith(
              fontSize:
                  TextStyles.getResponsiveFontSize(context, baseFontSize: 22)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: ListView.builder(
          itemCount: allTypeTransactions.length,
          itemBuilder: (context, index) {
            final Transaction currentTransaction = allTypeTransactions[index];
            final Category currentTransactionCategory = allTransactionsCubit
                .getTransactionCategory(currentTransaction.categoryName);
            return TransactionItemCard(
                transactionData: allTypeTransactions[index],
                transactionCategory: currentTransactionCategory,
                isPeriodicDate: isPeriodicFormat,
                currencyAbbreviation: currencyAbbreviation);
          },
        ),
      ),
    );
  }
}
