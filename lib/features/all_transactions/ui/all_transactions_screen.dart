import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/all_transactions_list_view.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/empty_transactions.dart';

class AllTransactionsScreen extends StatelessWidget {
  final TransactionType transactionType;
  const AllTransactionsScreen({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final AllTransactionsCubit allTransactionsCubit =
        context.read<AllTransactionsCubit>();
    allTransactionsCubit.loadAllTransactions(transactionType);
    final String titleType =
        transactionType == TransactionType.expense ? 'Expense' : 'Income';

    final bool noTransactions = allTransactionsCubit.transactionsList.isEmpty;

    return Scaffold(
      appBar: CustomAppBar(
        title: '$titleType Transactions',
        withBackButton: true,
        foregroundColor: AppColors.primaryDarkColor,
        action: IconButton(
          onPressed: () {
            _showSortingModalSheet(context, allTransactionsCubit);
          },
          icon: const Icon(
            Icons.sort,
            color: AppColors.primaryDarkColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: noTransactions
            ? EmptyTransactions(
                transactionType: transactionType,
              )
            : const AllTransactionsListView(),
      ),
    );
  }

  Future<dynamic> _showSortingModalSheet(
      BuildContext context, AllTransactionsCubit allTransactionsCubit) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Lowest Price');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      'Lowest Price',
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Highest Price');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      'Highest Price',
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Newest Date');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      'Newest Date',
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Oldest Date');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      'Oldest Date',
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
