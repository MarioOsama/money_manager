import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/dismissible_background.dart';
import 'package:money_manager/core/widgets/transaction_item_card_hero.dart';
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

        return listLength == 0
            ? Center(
                child: Text(
                  isExpanse
                      ? AppString.emptyExpenseMessage.tr()
                      : AppString.emptyIncomeMessage.tr(),
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
                  final Transaction currentTransaction =
                      transactions[transactions.length - index - 1];
                  final String categoryName = currentTransaction.categoryName;
                  final Category currentTransactionCategory =
                      homeCubit.getTransactionCategory(categoryName);
                  final String currencyAbbreviation =
                      homeCubit.getCurrencyAbbreviation;

                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) =>
                        onDismissed(context, currentTransaction),
                    background: const DismissibleBackground(),
                    direction: DismissDirection.endToStart,
                    child: TransactionItemCardHero(
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

  void onDismissed(BuildContext context, Transaction transaction) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final BankCardCubit bankCardCubit = context.read<BankCardCubit>();
    bankCardCubit.updateBankCardDataOnDeleteTransaction(transaction);
    showUndoSnackBar(context, transaction);
  }

  void showUndoSnackBar(BuildContext context, Transaction transaction) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final BankCardCubit bankCardCubit = context.read<BankCardCubit>();
    final snackBar = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppString.deletedTransactionMessage.tr()),
        backgroundColor: AppColors.redColor,
        action: SnackBarAction(
          label: AppString.undo.tr(),
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
    snackBar.closed.then(
      (reason) {
        if (reason == SnackBarClosedReason.action) {
          bankCardCubit.updateBankCardDataOnRestoreTransaction(transaction);
          context.read<HomeCubit>().getTransactionsData();
          homeCubit.filterTransactionsByType();
          return;
        }
        homeCubit.deleteTransaction(transaction.createdAt);
        context.read<HomeCubit>().getTransactionsData();
        homeCubit.filterTransactionsByType();
      },
    );
  }
}
