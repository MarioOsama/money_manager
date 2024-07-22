import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/empty_transactions.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/transactions_body.dart';

class AllTransactionsBlocBuilder extends StatelessWidget {
  const AllTransactionsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTransactionsCubit, AllTransactionsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (AllTransactionsLoadedState):
            {
              return const TransactionsBody();
            }
          case const (AllTransactionsEmptyState):
            {
              return const EmptyTransactions(
                transactionType: TransactionType.expense,
              );
            }
          default:
            {
              return const EmptyTransactions(
                transactionType: TransactionType.expense,
              );
            }
        }
      },
    );
  }
}
