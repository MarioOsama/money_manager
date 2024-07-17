import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/all_transactions_list_view.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/date_header.dart';

class TransactionsBody extends StatefulWidget {
  const TransactionsBody({
    super.key,
  });

  @override
  State<TransactionsBody> createState() => _TransactionsBodyState();
}

class _TransactionsBodyState extends State<TransactionsBody> {
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = context.read<AllTransactionsCubit>().pageController;
    currentPageIndex = context
            .read<AllTransactionsCubit>()
            .transactionsByMonthMap
            .keys
            .length -
        1;
  }

  @override
  Widget build(BuildContext context) {
    final AllTransactionsCubit allTransactionsCubit =
        context.read<AllTransactionsCubit>();
    final transactionsMap = allTransactionsCubit.transactionsByMonthMap;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: DateHeader(
            pageIndex: currentPageIndex,
          ),
        ),
        Expanded(
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            controller: _pageController,
            itemCount: transactionsMap.length,
            itemBuilder: (context, index) {
              final List<Transaction> transactions =
                  _getCurrentPageTransactions(transactionsMap, index);
              return AllTransactionsListView(
                transactions: transactions,
              );
            },
          ),
        ),
      ],
    );
  }

  List<Transaction> _getCurrentPageTransactions(
      Map<String, List<Transaction>> transactionsMap, int index) {
    final List<Transaction> transactions =
        transactionsMap.values.toList().reversed.elementAt(index);
    return transactions;
  }
}
