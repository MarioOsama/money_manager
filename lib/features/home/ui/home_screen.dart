import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/features/home/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/home/ui/widgets/bank_card_container.dart';
import 'package:money_manager/features/home/ui/widgets/transactions_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TransactionCubit>().getTransactionsData();
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionErrorState) {
          return Center(child: Text(state.error));
        }
        return const Column(
          children: [
            BankCardContainer(),
            Expanded(
              child: TransactionsContainer(),
            ),
          ],
        );
      },
    );
  }
}
