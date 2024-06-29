import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/widgets/transaction_item_card.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';

class AllTransactionsListView extends StatelessWidget {
  const AllTransactionsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AllTransactionsCubit allTransactionsCubit =
        context.read<AllTransactionsCubit>();
    final bool isPeriodicFormat =
        allTransactionsCubit.getDateFormat == 'Periodic';
    final String currencyAbbreviation =
        allTransactionsCubit.getCurrencyAbbreviation;
    return BlocBuilder<AllTransactionsCubit, AllTransactionsState>(
      buildWhen: (previous, current) => current is AllTransactionsLoadedState,
      builder: (context, state) {
        final List<Transaction> allTypeTransactions =
            (state as AllTransactionsLoadedState).allTransactions.toList();
        return ListView.builder(
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
        );
      },
    );
  }
}
